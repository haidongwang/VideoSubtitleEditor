//
//  SEMainWindowController.m
//  SubtitleEditor
//
//  Created by ocean on 2018/12/26.
//  Copyright © 2018年 Ocean. All rights reserved.
//

#import "SEMainWindowController.h"
#import "ASSManager.h"
#import "ASSDialogTableViewController.h"

@interface SEMainWindowController()
{
    
}
@property (strong) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSWindow* mainWindow;
@property (strong) ASSManager *assManager;

@end

@implementation SEMainWindowController

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (!self.assManager) {
        self.assManager = [[ASSManager alloc] init];
        self.assManager.window = self.mainWindow;
        self.dialogTableViewController.assManager = self.assManager;
        self.assManager.tableViewController = self.dialogTableViewController;
    }
    
    [self.sortButton setEnabled:NO];
}

#pragma mark - UI control callback

-(IBAction)onOpenButtonClicked:(id)sender {
//    [self.assManager loadTestFile];
    [self openASSFileWithDialog];
}

-(void) openASSFileWithDialog {
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    NSArray *allowedFileTypes = [NSArray arrayWithObject:@"ass"];
    [panel setAllowedFileTypes:allowedFileTypes];
    // This method displays the panel and returns immediately.
    // The completion handler is called when the user selects an
    // item or cancels the panel.
    [panel beginWithCompletionHandler:^(NSInteger result){
        if (result == NSModalResponseOK) {
            NSURL* url = [[panel URLs] objectAtIndex:0];
            [self performSelector:@selector(openASSFile:) withObject:url afterDelay:0.1];
        }
    }];
}

-(void) openASSFile:(NSURL*)url {
    [self.assManager loadFileFromURL:url];
    
    [self.tableView reloadData];
}

-(IBAction)onSaveButtonClicked:(id)sender {
//    [self.assManager saveTestFile];
    [self saveASSFileAsWithDialog];
}

-(void) saveASSFileAsWithDialog {
    NSWindow* window = [self window];
    [self.window makeFirstResponder:nil];
    
    NSSavePanel*   panel = [NSSavePanel savePanel];
    [panel setNameFieldStringValue:@""];
    NSArray *allowedFileTypes = [NSArray arrayWithObject:@"ass"];
    [panel setAllowedFileTypes:allowedFileTypes];
    [panel beginSheetModalForWindow:window completionHandler:^(NSInteger result){
        if (result == NSModalResponseOK) {
            NSURL* url = [panel URL];
            [self.assManager saveASSFileAs:url];
        }
    }];
}

-(IBAction)onSortButtonClicked:(id)sender {
    [self.assManager sortDialogsByStartTime];
    [self.assManager checkDialogsStartTimeSequences];
    [self.tableView reloadData];
}

@end
