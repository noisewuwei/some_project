//
//  CLTTerminal.m
//  CoolTerm
//
//  Created by Tom Lieber on 1/12/14.
//  Copyright (c) 2014 Tom Lieber. All rights reserved.
//

#include <util.h>
#import "CLTTerminal.h"
#include <sys/sysctl.h>
typedef struct kinfo_proc kinfo_proc;

static const NSUInteger kDefaultScrollbackCharacters = 100000;

@interface CLTTerminal () <NSTextViewDelegate>
@end

@interface CLTTerminalScrollView ()

@property (nonatomic, assign) BOOL drawBorder;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic) NSColor *borderColor;

@end

@implementation CLTTerminal
{
    CLTTerminalScrollView *scrollView;
    
    NSTask *task;
    NSFileHandle *masterHandle, *slaveHandle;
    NSPipe *errorOutputPipe;
    NSUInteger nonInputLength;
    
    void (^readHandler)(NSFileHandle *);
    BOOL readsEnabled;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.scrollbackCharacters = kDefaultScrollbackCharacters;
        [self start];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.scrollbackCharacters = kDefaultScrollbackCharacters;
    [self start];
}

- (void)setFrame:(NSRect)frameRect
{
    frameRect.size.height += scrollView.frame.size.height - scrollView.borderWidth * 2 - self.lastLineHeight;
    [super setFrame:frameRect];
}

- (void)setFrameSize:(NSSize)newSize
{
    newSize.height += scrollView.frame.size.height - scrollView.borderWidth * 2 - self.lastLineHeight;
    [super setFrameSize:newSize];
}

- (void)cleanUp
{
    [masterHandle closeFile];
    [slaveHandle closeFile];
    [errorOutputPipe.fileHandleForReading closeFile];
    [errorOutputPipe.fileHandleForWriting closeFile];
    [task terminate];
}

- (void)start
{
    self.delegate = self;
    
    self.automaticDashSubstitutionEnabled = NO;
    self.automaticQuoteSubstitutionEnabled = NO;
    
    scrollView = (CLTTerminalScrollView *)self.superview.superview;
    scrollView.contentView.postsBoundsChangedNotifications = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(scrolled:)
                                                 name:NSViewBoundsDidChangeNotification
                                               object:scrollView.contentView];
    
    task = [NSTask new];
    
    NSDictionary *environment = [NSProcessInfo processInfo].environment;
    NSString *homePath = environment[@"HOME"];
    if (homePath) {
        task.currentDirectoryPath = homePath;
    }
}

- (IBAction)sendCommand:(id)sender
{
    [self writeCommand:[self.textStorage.string substringWithRange:self.selectedRange]];
}

- (NSString *)currentDirectoryPath
{
    return task.currentDirectoryPath;
}

- (void)setCurrentDirectoryPath:(NSString *)path
{
    task.currentDirectoryPath = path;
}

- (void)addHistory:(NSAttributedString *)history
{
    NSMutableAttributedString *as = [NSMutableAttributedString new];
    [as appendAttributedString:history];
    [as appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n--- end restored state ---\n"]];
    
    [self.textStorage insertAttributedString:as atIndex:0];
    [self addedData];
    nonInputLength += as.length;
}

- (void)addedData
{
    if (_scrollbackCharacters > 0 && nonInputLength > _scrollbackCharacters) {
        NSInteger toDelete = nonInputLength - _scrollbackCharacters;
        [self.textStorage replaceCharactersInRange:NSMakeRange(0, toDelete) withString:@""];
        nonInputLength = _scrollbackCharacters;
    }
    
    if (self.activityHandler != nil) {
        self.activityHandler(self);
    }
}

- (void)setAutoScroll:(BOOL)autoScroll
{
    if (_autoScroll != autoScroll) {
        _autoScroll = autoScroll;
        scrollView.drawBorder = _autoScroll;
        
        if (_autoScroll) {
            [self scrollToBottom];
        }
    }
}

- (void)setDefaultFont:(NSFont *)defaultFont
{
    if (![_defaultFont isEqual:defaultFont]) {
        _defaultFont = defaultFont;
    }
}


#pragma mark - Menu Events

- (IBAction)toggleAutoScroll:(id)sender
{
    self.autoScroll = !self.autoScroll;
    
    if ([sender isKindOfClass:[NSMenuItem class]]) {
        NSMenuItem *menuItem = (NSMenuItem *)sender;
        menuItem.state = _autoScroll ? NSOnState : NSOffState;
    }
}


#pragma mark - Text View Events

- (void)keyDown:(NSEvent *)theEvent
{
    NSUInteger flags = theEvent.modifierFlags;
    unsigned short keyCode = theEvent.keyCode;
    
    if ((flags & NSControlKeyMask) && keyCode == 8) {
        [self sendCtrlC];
    } else if ((flags & NSControlKeyMask) && keyCode == 2) {
//        [masterHandle writeData:[NSData dataWithBytes:"\004" length:1]];
        [self sendCtrlC];
    } else if ((flags & NSDeviceIndependentModifierFlagsMask) == 0 && keyCode == 126) {
        NSLog(@"up");
    } else if ((flags & NSDeviceIndependentModifierFlagsMask) == 0 && keyCode == 125) {
        NSLog(@"down");
    } else {
        [super keyDown:theEvent];
    }
}

- (void)sendCtrlC
{
    [masterHandle writeData:[NSData dataWithBytes: "\004" length:1]];

    kinfo_proc *procs = NULL;
    size_t count;
    if (0 != GetBSDProcessList(&procs, &count)) {
        return;
    }
    BOOL hasChildren = NO;
    for (size_t i = 0; i < count; i++) {
        if (procs[i].kp_eproc.e_ppid == task.processIdentifier) {
            hasChildren = YES;
            kill(procs[i].kp_proc.p_pid, SIGINT);
        }
    }
    free(procs);

    if (hasChildren == NO) {
        kill(task.processIdentifier, SIGINT);
    }
}

static int GetBSDProcessList(kinfo_proc **procList, size_t *procCount)
// Returns a list of all BSD processes on the system.  This routine
// allocates the list and puts it in *procList and a count of the
// number of entries in *procCount.  You are responsible for freeing
// this list (use "free" from System framework).
// On success, the function returns 0.
// On error, the function returns a BSD errno value.
{
    int                 err;
    kinfo_proc *        result;
    bool                done;
    static const int    name[] = { CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0 };
    // Declaring name as const requires us to cast it when passing it to
    // sysctl because the prototype doesn't include the const modifier.
    size_t              length;

    assert( procList != NULL);
    assert(*procList == NULL);
    assert(procCount != NULL);

    *procCount = 0;

    // We start by calling sysctl with result == NULL and length == 0.
    // That will succeed, and set length to the appropriate length.
    // We then allocate a buffer of that size and call sysctl again
    // with that buffer.  If that succeeds, we're done.  If that fails
    // with ENOMEM, we have to throw away our buffer and loop.  Note
    // that the loop causes use to call sysctl with NULL again; this
    // is necessary because the ENOMEM failure case sets length to
    // the amount of data returned, not the amount of data that
    // could have been returned.

    result = NULL;
    done = false;
    do {
        assert(result == NULL);

        // Call sysctl with a NULL buffer.

        length = 0;
        err = sysctl( (int *) name, (sizeof(name) / sizeof(*name)) - 1,
                     NULL, &length,
                     NULL, 0);
        if (err == -1) {
            err = errno;
        }

        // Allocate an appropriately sized buffer based on the results
        // from the previous call.

        if (err == 0) {
            result = malloc(length);
            if (result == NULL) {
                err = ENOMEM;
            }
        }

        // Call sysctl again with the new buffer.  If we get an ENOMEM
        // error, toss away our buffer and start again.

        if (err == 0) {
            err = sysctl( (int *) name, (sizeof(name) / sizeof(*name)) - 1,
                         result, &length,
                         NULL, 0);
            if (err == -1) {
                err = errno;
            }
            if (err == 0) {
                done = true;
            } else if (err == ENOMEM) {
                assert(result != NULL);
                free(result);
                result = NULL;
                err = 0;
            }
        }
    } while (err == 0 && ! done);

    // Clean up and establish post conditions.

    if (err != 0 && result != NULL) {
        free(result);
        result = NULL;
    }
    *procList = result;
    if (err == 0) {
        *procCount = length / sizeof(kinfo_proc);
    }
    assert( (err == 0) == (*procList != NULL) );
    return err;
}

- (BOOL)shouldChangeTextInRange:(NSRange)affectedCharRange replacementString:(NSString *)replacementString
{
    BOOL should = [super shouldChangeTextInRange:affectedCharRange replacementString:replacementString];
    
    if (should && replacementString != nil) {
        if (affectedCharRange.location < nonInputLength) {
            if (replacementString.length > affectedCharRange.length) { // "" -> "asdf"
                nonInputLength += replacementString.length - affectedCharRange.length;
            } else { // "asdf" -> ""
                nonInputLength -= affectedCharRange.length - replacementString.length;
            }
        }
    }
    
    return should;
}

- (void)didChangeText
{
    NSString *input = self.pendingInput;
    if ([input hasSuffix:@"\n"]) {
        [self.textStorage replaceCharactersInRange:NSMakeRange(nonInputLength, input.length) withString:@""];
        [self writeCommand:input];
    }
}

- (void)scrolled:(id)sender
{
//    [self enableReadsIfNecessary];
}


#pragma mark - Text View Helpers

- (NSString *)pendingInput
{
    return [[self.textStorage string] substringFromIndex:nonInputLength];
}

- (BOOL)isEndOfTextVisible
{
    NSRange glyphRange = [self.layoutManager glyphRangeForBoundingRect:scrollView.documentVisibleRect
                                                       inTextContainer:self.textContainer];
    return self.textStorage.string.length == glyphRange.location + glyphRange.length;
    
    // alternate method http://stackoverflow.com/a/15547841/129889
//    return (NSMaxY(self.textView.visibleRect) == NSMaxY(self.textView.bounds));
}

- (void)scrollToBottom
{
    [self scrollRangeToVisible:NSMakeRange(self.string.length, 0)];
}

- (CGFloat)lastLineHeight
{
    return 20; // TODO
}


#pragma mark - I/O Helpers

- (void)startShell
{
    int amaster = 0, aslave = 0;
    if (openpty(&amaster, &aslave, NULL, NULL, NULL) == -1) {
        NSLog(@"openpty failed");
        return;
    }
    
    masterHandle = [[NSFileHandle alloc] initWithFileDescriptor:amaster closeOnDealloc:YES];
    slaveHandle = [[NSFileHandle alloc] initWithFileDescriptor:aslave closeOnDealloc:YES];
    
    NSMutableDictionary *environment = [NSProcessInfo processInfo].environment.mutableCopy;
    environment[@"TERM"] = @"xterm";
    
    task.launchPath = @"/bin/bash";
    task.arguments = @[@"-i",@"-l"];
    task.environment = environment;
    
    task.standardInput = slaveHandle;
    task.standardOutput = slaveHandle;
    task.standardError = errorOutputPipe = [NSPipe pipe];
    
    __block typeof(self) weakSelf = self;
    
    readHandler = ^(NSFileHandle *handle) {
        NSData *data = handle.availableData;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf receivedData:data];
        });
    };
    
    task.terminationHandler = ^(NSTask *task){
        dispatch_async(dispatch_get_main_queue(), ^{
            typeof(self) strongSelf = weakSelf;
            [strongSelf cleanUp];
            
            if (strongSelf.terminationHandler != nil) {
                strongSelf.terminationHandler(strongSelf);
            }
        });
    };
    
    [self enableReads:YES];
    
    [task launch];
}

- (void)receivedData:(NSData *)data
{
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//    string = [string stringByReplacingOccurrencesOfString:@"[?2004h" withString:@""];
//    string = [string stringByReplacingOccurrencesOfString:@"[?2004l" withString:@""];
    
    NSLog(@"hahahaha%@",string);
    
    
    NSDictionary *attributes = nil;
    if (_defaultFont != nil) {
        attributes = @{NSFontAttributeName: _defaultFont};
    }
    NSAttributedString *as = [[NSAttributedString alloc] initWithString:string attributes:attributes];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        for (int i = 0; i < byteRange.length; i++) {
            const unsigned char *chars = (const unsigned char *)bytes;
            if (iscntrl(chars[i]) && chars[i] != 9 && chars[i] != 10 && chars[i] != 13) {
//                NSLog(@"control character: %d", chars[i]);
            }
        }
    }];
    
    
    
    [self.textStorage insertAttributedString:as atIndex:nonInputLength];
    nonInputLength += as.length;
    [self addedData];
    
    if (_autoScroll) {
        [self scrollToBottom];
    } else if (!self.isEndOfTextVisible) {
//        [self enableReads:NO];
    }
}

- (void)enableReads:(BOOL)enable
{
    if (enable && !readsEnabled) {
        masterHandle.readabilityHandler = readHandler;
        errorOutputPipe.fileHandleForReading.readabilityHandler = readHandler;
        readsEnabled = YES;
    } else if (!enable && readsEnabled) {
        masterHandle.readabilityHandler = nil;
        errorOutputPipe.fileHandleForReading.readabilityHandler = nil;
        readsEnabled = NO;
    }
}

- (void)enableReadsIfNecessary
{
//    [self enableReads:self.isEndOfTextVisible];
}

- (void)writeCommand:(NSString *)command
{
    if (![command hasSuffix:@"\n"]) {
        command = [command stringByAppendingString:@"\n"];
    }
    [masterHandle writeData:[command dataUsingEncoding:NSUTF8StringEncoding]];
}

@end

@implementation CLTTerminalScrollView

- (void)awakeFromNib {
    _borderWidth = 10;
    _borderColor = [NSColor colorWithCalibratedRed:0.049 green:0.396 blue:0.58 alpha:1];
}

- (void)setDrawBorder:(BOOL)drawBorder
{
    if (_drawBorder != drawBorder) {
        _drawBorder = drawBorder;
        [self setNeedsLayout:YES];
    }
}

- (void)tile
{
    id contentView = [self contentView];
    [super tile];
    if (_drawBorder) {
        [contentView setFrame:NSInsetRect([contentView frame], _borderWidth, _borderWidth)];
    }
}

- (void)drawRect:(NSRect)dirtyRect
{
    if (_drawBorder) {
        [_borderColor set];
        
        NSBezierPath *path = [NSBezierPath bezierPathWithRect:self.bounds];
        [path setLineWidth:_borderWidth * 2 + 2];
        [path stroke];
    }
}

@end
