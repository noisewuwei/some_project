//
//  TestVC.m
//  MMTabBarView Demo
//
//  Created by zuler on 2022/4/12.
//  Copyright © 2022 Michael Monscheuer. All rights reserved.
//

#import "TestVC.h"
#import "DemoFakeModel.h"

@interface TestVC (){
    
    MMTabBarView *tabBar;
    NSTabView *tabView;
    
}

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    tabBar = [[MMTabBarView alloc] initWithFrame:CGRectMake(0, 0, 1440, 700)];
    [self.view addSubview:tabBar];
    
//    tabView = [[NSTabView alloc] initWithFrame:CGRectMake(0, 0, 1440, 700)];
//    [self.view addSubview:tabView];
    
    [tabBar addObserver:self forKeyPath:@"orientation" options:NSKeyValueObservingOptionNew context:NULL];
    // remove any tabs present in the nib
//    for (NSTabViewItem *item in tabView.tabViewItems) {
//        [tabView removeTabViewItem:item];
//    }
    
    [self addDefaultTabs];
    
    
}

- (void)loadView{
    
    self.view = [[NSView alloc] initWithFrame:CGRectMake(0, 0, NSScreen.mainScreen.frame.size.width, NSScreen.mainScreen.frame.size.height)];
    
}

- (void)addNewTabWithTitle:(NSString *)aTitle {

    DemoFakeModel *newModel = [[DemoFakeModel alloc] init];
    [newModel setTitle:aTitle];
    NSTabViewItem *newItem = [[NSTabViewItem alloc] initWithIdentifier:newModel];
    [tabBar.tabView addTabViewItem:newItem];
    [tabBar.tabView selectTabViewItem:newItem];
}

- (void)addDefaultTabs {

    [self addNewTabWithTitle:@"Tab"];
    [self addNewTabWithTitle:@"Bar"];
    [self addNewTabWithTitle:@"View"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context {

    if (object == tabBar) {
        if ([keyPath isEqualToString:@"orientation"]) {
            [self _updateForOrientation:[(NSNumber*) [change objectForKey:NSKeyValueChangeNewKey] unsignedIntegerValue]];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

-(void)_updateForOrientation:(MMTabBarOrientation)newOrientation {

    //change the frame of the tab bar according to the orientation
    NSRect tabBarFrame = tabBar.frame, tabViewFrame = tabView.frame;
    NSRect totalFrame = NSUnionRect(tabBarFrame, tabViewFrame);

    NSSize intrinsicTabBarContentSize = tabBar.intrinsicContentSize;

    if (newOrientation == MMTabBarHorizontalOrientation) {
        if (intrinsicTabBarContentSize.height == NSViewNoInstrinsicMetric)
            intrinsicTabBarContentSize.height = 22;
        tabBarFrame.size.height = tabBar.isTabBarHidden ? 1 : intrinsicTabBarContentSize.height;
        tabBarFrame.size.width = totalFrame.size.width;
        tabBarFrame.origin.y = totalFrame.origin.y + totalFrame.size.height - tabBarFrame.size.height;
        tabViewFrame.origin.x = 13;
        tabViewFrame.size.width = totalFrame.size.width - 23;
        tabViewFrame.size.height = totalFrame.size.height - tabBarFrame.size.height - 2;
        [tabBar setAutoresizingMask:NSViewMinYMargin | NSViewWidthSizable];
    } else {
        tabBarFrame.size.height = totalFrame.size.height;
        tabBarFrame.size.width = tabBar.isTabBarHidden ? 1 : 120;
        tabBarFrame.origin.y = totalFrame.origin.y;
        tabViewFrame.origin.x = tabBarFrame.origin.x + tabBarFrame.size.width;
        tabViewFrame.size.width = totalFrame.size.width - tabBarFrame.size.width;
        tabViewFrame.size.height = totalFrame.size.height;
        [tabBar setAutoresizingMask:NSViewHeightSizable];
    }

    tabBarFrame.origin.x = totalFrame.origin.x;
    tabViewFrame.origin.y = totalFrame.origin.y;

    [tabView setFrame:tabViewFrame];
    [tabBar setFrame:tabBarFrame];

//    [popUp_orientation selectItemWithTag:newOrientation];
//    [self.window display];
//
//    if (newOrientation == MMTabBarHorizontalOrientation) {
//        [NSUserDefaults.standardUserDefaults setObject:[[popUp_orientation itemAtIndex:0] title] forKey:@"Orientation"];
//    } else {
//        [NSUserDefaults.standardUserDefaults setObject:[[popUp_orientation itemAtIndex:1] title] forKey:@"Orientation"];
//    }
}

#pragma mark -
#pragma mark ---- tab bar config ----

- (void)configStyle:(id)sender {
    
    [tabBar setStyleNamed:@"Metal"];
    
    [self _updateForOrientation:tabBar.orientation];
}

- (void)configOnlyShowCloseOnHover:(id)sender {
    NSControlStateValue const state = [(NSButton*) sender state];

    [tabBar setOnlyShowCloseOnHover:state];
}

- (void)configCanCloseOnlyTab:(id)sender {
    NSControlStateValue const state = [(NSButton*) sender state];
    [tabBar setCanCloseOnlyTab:state];
}

- (void)configDisableTabClose:(id)sender {
    NSControlStateValue const state = [(NSButton*) sender state];

    [tabBar setDisableTabClose:state];

    [NSUserDefaults.standardUserDefaults setObject:[NSNumber numberWithBool:state]
     forKey:@"DisableTabClose"];
}

- (void)configAllowBackgroundClosing:(id)sender {
    NSControlStateValue const state = [(NSButton*) sender state];

    [tabBar setAllowsBackgroundTabClosing:state];

    [NSUserDefaults.standardUserDefaults setObject:[NSNumber numberWithBool:state]
     forKey:@"AllowBackgroundClosing"];
}

- (void)configHideForSingleTab:(id)sender {
    NSControlStateValue const state = [(NSButton*) sender state];

    [tabBar setHideForSingleTab:state];

    [NSUserDefaults.standardUserDefaults setObject:[NSNumber numberWithBool:state]
     forKey:@"HideForSingleTab"];
}

- (void)configAddTabButton:(id)sender {
    NSControlStateValue const state = [(NSButton*) sender state];

    [tabBar setShowAddTabButton:state];

    [NSUserDefaults.standardUserDefaults setObject:[NSNumber numberWithBool:state]
     forKey:@"ShowAddTabButton"];
}

- (void)configTabMinWidth:(id)sender {
    NSInteger const value = [(NSControl*) sender integerValue];
    if (tabBar.buttonOptimumWidth < value) {
        [tabBar setButtonMinWidth:tabBar.buttonOptimumWidth];
        [(NSControl*) sender setIntegerValue:tabBar.buttonOptimumWidth];
        return;
    }

    [tabBar setButtonMinWidth:value];

    [NSUserDefaults.standardUserDefaults setObject:[NSNumber numberWithInteger:value]
     forKey:@"TabMinWidth"];
}

- (void)configTabMaxWidth:(id)sender {
    NSInteger const value = [(NSControl*) sender integerValue];
    if (tabBar.buttonOptimumWidth > value) {
        [tabBar setButtonMaxWidth:tabBar.buttonOptimumWidth];
        [(NSControl*) sender setIntegerValue:tabBar.buttonOptimumWidth];
        return;
    }

    [tabBar setButtonMaxWidth:value];

    [NSUserDefaults.standardUserDefaults setObject:[NSNumber numberWithInteger:value]
     forKey:@"TabMaxWidth"];
}

- (void)configTabOptimumWidth:(id)sender {
    NSInteger const value = [(NSControl*) sender integerValue];
    if (tabBar.buttonMaxWidth < value) {
        [tabBar setButtonOptimumWidth:tabBar.buttonMaxWidth];
        [(NSControl*) sender setIntegerValue:tabBar.buttonMaxWidth];
        return;
    }

    if (tabBar.buttonMinWidth > value) {
        [tabBar setButtonOptimumWidth:tabBar.buttonMinWidth];
        [(NSControl*) sender setIntegerValue:tabBar.buttonMinWidth];
        return;
    }

    [tabBar setButtonOptimumWidth:value];
}

- (void)configTabSizeToFit:(id)sender {
    NSControlStateValue const state = [(NSButton*) sender state];

    [tabBar setSizeButtonsToFit:state];

    [NSUserDefaults.standardUserDefaults setObject:[NSNumber numberWithBool:state]
     forKey:@"SizeToFit"];
}

- (void)configTearOffStyle:(id)sender {
    NSPopUpButton* const popupButton = sender;
    [tabBar setTearOffStyle:(popupButton.indexOfSelectedItem == 0) ? MMTabBarTearOffAlphaWindow : MMTabBarTearOffMiniwindow];

    [NSUserDefaults.standardUserDefaults setObject:popupButton.title
     forKey:@"Tear-Off"];
}

- (void)configUseOverflowMenu:(id)sender {
    NSControlStateValue const state = [(NSButton*) sender state];

    [tabBar setUseOverflowMenu:state];

    [NSUserDefaults.standardUserDefaults setObject:[NSNumber numberWithBool:state]
     forKey:@"UseOverflowMenu"];
}

- (void)configAutomaticallyAnimates:(id)sender {
    NSControlStateValue const state = [(NSButton*) sender state];

    [tabBar setAutomaticallyAnimates:state];

    [NSUserDefaults.standardUserDefaults setObject:[NSNumber numberWithBool:state]
     forKey:@"AutomaticallyAnimates"];
}

- (void)configAllowsScrubbing:(id)sender {
    NSControlStateValue const state = [(NSButton*) sender state];

    [tabBar setAllowsScrubbing:state];

    [NSUserDefaults.standardUserDefaults setObject:[NSNumber numberWithBool:state]
     forKey:@"AllowScrubbing"];
}

#pragma mark -
#pragma mark ---- delegate ----

- (void)tabView:(NSTabView *)aTabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem {
    // need to update bound values to match the selected tab
    DemoFakeModel* const tabBarItem = tabViewItem.identifier;
   
}

- (BOOL)tabView:(NSTabView *)aTabView shouldCloseTabViewItem:(NSTabViewItem *)tabViewItem {
    NSWindow* const window = NSApp.keyWindow;
    if (window == nil) {
        return NO;
    }
    if ([tabViewItem.label isEqualToString:@"Drake"]) {
        NSAlert *drakeAlert = [[NSAlert alloc] init];
        [drakeAlert setMessageText:@"No Way!"];
        [drakeAlert setInformativeText:@"I refuse to close a tab named \"Drake\""];
        [drakeAlert addButtonWithTitle:@"OK"];
        [drakeAlert beginSheetModalForWindow:window completionHandler:nil];
        return NO;
    }
    return YES;
}

- (void)tabView:(NSTabView *)aTabView didCloseTabViewItem:(NSTabViewItem *)tabViewItem {
    NSLog(@"didCloseTabViewItem: %@", tabViewItem.label);
}

- (void)tabView:(NSTabView *)aTabView didMoveTabViewItem:(NSTabViewItem *)tabViewItem toIndex:(NSUInteger)index
{
    NSLog(@"tab view did move tab view item %@ to index:%ld",tabViewItem.label,index);
}

- (void)addNewTabToTabView:(NSTabView *)aTabView {
//    [self addNewTab:aTabView];
}

- (NSArray<NSPasteboardType> *)allowedDraggedTypesForTabView:(NSTabView *)aTabView {
    return @[NSFilenamesPboardType, NSStringPboardType];
}

- (BOOL)tabView:(NSTabView *)aTabView acceptedDraggingInfo:(id <NSDraggingInfo>)draggingInfo onTabViewItem:(NSTabViewItem *)tabViewItem {
    NSPasteboardType const pasteboardType = draggingInfo.draggingPasteboard.types[0];
    if (pasteboardType == nil) {
        return NO;
    }
    NSLog(@"acceptedDraggingInfo: %@ onTabViewItem: %@", [draggingInfo.draggingPasteboard stringForType:pasteboardType], tabViewItem.label);
    return YES;
}

- (NSMenu *)tabView:(NSTabView *)aTabView menuForTabViewItem:(NSTabViewItem *)tabViewItem {
    NSLog(@"menuForTabViewItem: %@", tabViewItem.label);
    return nil;
}

- (BOOL)tabView:(NSTabView *)aTabView shouldAllowTabViewItem:(NSTabViewItem *)tabViewItem toLeaveTabBarView:(MMTabBarView *)tabBarView {
    return YES;
}

- (BOOL)tabView:(NSTabView*)aTabView shouldDragTabViewItem:(NSTabViewItem *)tabViewItem inTabBarView:(MMTabBarView *)tabBarView {
    return YES;
}

- (NSDragOperation)tabView:(NSTabView*)aTabView validateDrop:(id<NSDraggingInfo>)sender proposedItem:(NSTabViewItem *)tabViewItem proposedIndex:(NSUInteger)proposedIndex inTabBarView:(MMTabBarView *)tabBarView {

    return NSDragOperationMove;
}

- (NSDragOperation)tabView:(NSTabView *)aTabView validateSlideOfProposedItem:(NSTabViewItem *)tabViewItem proposedIndex:(NSUInteger)proposedIndex inTabBarView:(MMTabBarView *)tabBarView {

    return NSDragOperationMove;
}

- (void)tabView:(NSTabView*)aTabView didDropTabViewItem:(NSTabViewItem *)tabViewItem inTabBarView:(MMTabBarView *)tabBarView {
    NSLog(@"didDropTabViewItem: %@ inTabBarView: %@", tabViewItem.label, tabBarView);
}

- (NSImage *)tabView:(NSTabView *)aTabView imageForTabViewItem:(NSTabViewItem *)tabViewItem offset:(NSSize *)offset styleMask:(NSUInteger *)styleMask {
    // grabs whole window image
    NSImage *viewImage = [[NSImage alloc] init];
    NSBitmapImageRep *viewRep;
    if (@available(macOS 10.14, *)) {
        NSView *contentView=self.view;
        NSRect rect=contentView.visibleRect;
        viewRep=[contentView bitmapImageRepForCachingDisplayInRect:rect];
        [contentView cacheDisplayInRect:rect toBitmapImageRep:viewRep];
    }
    else {
        NSRect contentFrame = self.view.frame;
        [self.view lockFocus];
        viewRep = [[NSBitmapImageRep alloc] initWithFocusedViewRect:contentFrame];
        [self.view unlockFocus];
    }
    [viewImage addRepresentation:viewRep];

    // grabs snapshot of dragged tabViewItem's view (represents content being dragged)
    NSView *viewForImage = tabViewItem.view;
    NSRect viewRect = viewForImage.frame;
    NSImage *tabViewImage = [[NSImage alloc] initWithSize:viewRect.size];
    [tabViewImage lockFocus];
    [viewForImage drawRect:viewForImage.bounds];
    [tabViewImage unlockFocus];

    [viewImage lockFocus];
    NSPoint tabOrigin = tabView.frame.origin;
    tabOrigin.x += 10;
    tabOrigin.y += 13;
    [tabViewImage drawAtPoint:tabOrigin fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
//    [tabViewImage compositeToPoint:tabOrigin operation:NSCompositeSourceOver];
    [viewImage unlockFocus];

    MMTabBarView *tabBarView = (MMTabBarView *)aTabView.delegate;
    
    //draw over where the tab bar would usually be
    NSRect tabFrame = tabBar.frame;
    [viewImage lockFocus];
    [NSColor.windowBackgroundColor set];
    NSRectFill(tabFrame);
    //draw the background flipped, which is actually the right way up
    NSAffineTransform *transform = NSAffineTransform.transform;
    [transform scaleXBy:1.0 yBy:-1.0];
    [transform concat];
    tabFrame.origin.y = -tabFrame.origin.y - tabFrame.size.height;
    [tabBarView.style drawBezelOfTabBarView:tabBarView inRect:tabFrame];
    [transform invert];
    [transform concat];

    [viewImage unlockFocus];

    if (tabBarView.orientation == MMTabBarHorizontalOrientation) {
        offset->width = tabBarView.leftMargin;
        offset->height = 22;
    } else {
        offset->width = 0;
        offset->height = 22 + tabBarView.topMargin;
    }

    if (styleMask) {
        *styleMask = NSTitledWindowMask | NSTexturedBackgroundWindowMask;
    }

    return viewImage;
}

- (MMTabBarView *)tabView:(NSTabView *)aTabView newTabBarViewForDraggedTabViewItem:(NSTabViewItem *)tabViewItem atPoint:(NSPoint)point {
    NSLog(@"newTabBarViewForDraggedTabViewItem: %@ atPoint: %@", tabViewItem.label, NSStringFromPoint(point));

//    //create a new window controller with no tab items
//    DemoWindowController *controller = [[DemoWindowController alloc] initWithWindowNibName:@"DemoWindow"];
//
//    MMTabBarView *tabBarView = (MMTabBarView *)aTabView.delegate;
//
//    id <MMTabStyle> style = tabBarView.style;
//
//    NSRect windowFrame = controller.window.frame;
//    point.y += windowFrame.size.height - controller.window.contentView.frame.size.height;
//    point.x -= [style leftMarginForTabBarView:tabBarView];
//
//    [controller.window setFrameTopLeftPoint:point];
//    [controller.tabBar setStyle:style];
//
//    return controller.tabBar;
}

- (void)tabView:(NSTabView *)aTabView closeWindowForLastTabViewItem:(NSTabViewItem *)tabViewItem {
    NSLog(@"closeWindowForLastTabViewItem: %@", tabViewItem.label);
//    [self.window close];
}

- (void)tabView:(NSTabView *)aTabView tabBarViewDidHide:(MMTabBarView *)tabBarView {
    NSLog(@"tabBarViewDidHide: %@", tabBarView);
}

- (void)tabView:(NSTabView *)aTabView tabBarViewDidUnhide:(MMTabBarView *)tabBarView {
    NSLog(@"tabBarViewDidUnhide: %@", tabBarView);
}

- (NSString *)tabView:(NSTabView *)aTabView toolTipForTabViewItem:(NSTabViewItem *)tabViewItem {
    return tabViewItem.label;
}

- (NSString *)accessibilityStringForTabView:(NSTabView *)aTabView objectCount:(NSInteger)objectCount {
    return (objectCount == 1) ? @"item" : @"items";
}

@end
