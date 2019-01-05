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
    [self.assManager loadTestFile];
    [self.tableView reloadData];
    
    [self performSelectorOnMainThread:@selector(onTableIsReloaded) withObject:nil waitUntilDone:NO];
}

-(IBAction)onSaveButtonClicked:(id)sender {
    [self.assManager saveTestFile];
}

-(IBAction)onSortButtonClicked:(id)sender {
    [self.assManager sortDialogsByStartTime];
    [self.assManager checkDialogsStartTimeSequences];
    [self.tableView reloadData];
}

-(void) onTableIsReloaded {
}

@end
