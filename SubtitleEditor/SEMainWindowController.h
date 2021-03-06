//
//  SEMainWindowController.h
//  SubtitleEditor
//
//  Created by ocean on 2018/12/26.
//  Copyright © 2018年 Ocean. All rights reserved.
//

@import Cocoa;
#import "ASSDialogTableViewController.h"

@interface SEMainWindowController : NSObject {
    
}

@property (weak) IBOutlet ASSDialogTableViewController* dialogTableViewController;
@property (weak) IBOutlet NSButton* sortButton;
@property (weak) IBOutlet NSWindow* window;

-(IBAction)onOpenButtonClicked:(id)sender;
-(IBAction)onSaveButtonClicked:(id)sender;
-(IBAction)onSortButtonClicked:(id)sender;

@end
