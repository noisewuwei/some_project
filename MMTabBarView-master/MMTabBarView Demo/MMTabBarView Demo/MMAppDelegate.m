//
//  MMAppDelegate.m
//  MMTabBarView Demo
//
//  Created by Michael Monscheuer on 9/19/12.
//  Copyright (c) 2016 Michael Monscheuer. All rights reserved.
//

#import "MMAppDelegate.h"

#import "DemoWindowController.h"
#import "TestVC.h"

@implementation MMAppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)pNotification {
    [NSColorPanel.sharedColorPanel setShowsAlpha:YES];

	[self newWindow:self];
}
- (IBAction)newWindow:(id)sender {
        // create window controller
	DemoWindowController *newWindowController = [[DemoWindowController alloc] initWithWindowNibName:@"DemoWindow"];
        // load window (as we need the nib file to be loaded before we can proceed
    [newWindowController loadWindow];
        // add the default tabs
	[newWindowController addDefaultTabs];
        // finally show the window
	[newWindowController showWindow:self];
    
    
//    TestVC *con = [[TestVC alloc] initWithNibName:nil bundle:nil];
//    
//    int width = (int)NSScreen.mainScreen.frame.size.width;
//    int height = (int)NSScreen.mainScreen.frame.size.height;
//    
//    NSRect frame = CGRectMake(0, 0, width, height-100);
//    NSUInteger style = NSTitledWindowMask | NSClosableWindowMask |NSMiniaturizableWindowMask | NSResizableWindowMask;
//    NSWindow *window = [[NSWindow alloc] initWithContentRect:frame styleMask:style backing:NSBackingStoreBuffered defer:YES];
//    window.title = @"New Create Window";
//    
//    window.contentViewController = con;
//    //窗口显示
//    [window makeKeyAndOrderFront:nil];
//    //窗口居中
//    [window center];
    
}

@end
