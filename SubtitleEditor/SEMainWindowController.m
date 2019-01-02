//
//  SEMainWindowController.m
//  SubtitleEditor
//
//  Created by ocean on 2018/12/26.
//  Copyright © 2018年 Ocean. All rights reserved.
//

#import "SEMainWindowController.h"
#import "ASSManager.h"

@interface SEMainWindowController() <NSTableViewDelegate, NSTableViewDataSource>
{
    
}
@property (strong) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSWindow* mainWindow;
@property (strong) ASSManager *assManager;

@end

@implementation SEMainWindowController

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.assManager = [[ASSManager alloc] init];
    self.assManager.window = self.mainWindow;
}

#pragma mark - NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
//    return self.tableContents.count;
    return 2;
}


#pragma mark - NSTableViewDelegate

//- (void)tableView:(NSTableView *)tableView didRemoveRowView:(ATObjectTableRowView *)rowView forRow:(NSInteger)row {
    // Stop observing visible things.
//    ATDesktopImageEntity *imageEntity = rowView.objectValue;
//    NSInteger index = imageEntity ? [self.observedVisibleItems indexOfObject:imageEntity] : NSNotFound;
//    if (index != NSNotFound) {
//        [imageEntity removeObserver:self forKeyPath:ATEntityPropertyNamedThumbnailImage];
//        [self.observedVisibleItems removeObjectAtIndex:index];
//    }
//}

//- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row {
    // Make the row view keep track of our main model object.
//    return nil;
//    ATObjectTableRowView *result = [[ATObjectTableRowView alloc] initWithFrame:NSMakeRect(0, 0, 100, 100)];
//    result.objectValue = [self entityForRow:row];
//    return result;
//}

// We want to make "group rows" for the folders.
//- (BOOL)tableView:(NSTableView *)tableView isGroupRow:(NSInteger)row {
//    return NO;
//    if ([[self entityForRow:row] isKindOfClass:[ATDesktopFolderEntity class]]) {
//        return YES;
//    } else {
//        return NO;
//    }
//}

//- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
//    ATDesktopEntity *entity = [self entityForRow:row];
//    if ([entity isKindOfClass:[ATDesktopFolderEntity class]]) {
//        NSTextField *textField = [tableView makeViewWithIdentifier:@"TextCell" owner:self];
//        textField.stringValue = entity.title;
//        return textField;
//    } else {
//        ATTableCellView *cellView = [tableView makeViewWithIdentifier:@"MainCell" owner:self];
//        ATDesktopImageEntity *imageEntity = (ATDesktopImageEntity *)entity;
//        cellView.textField.stringValue = entity.title;
//        cellView.subTitleTextField.stringValue = imageEntity.fillColorName;
//        cellView.colorView.backgroundColor = imageEntity.fillColor;
//        cellView.colorView.drawBorder = YES;
//
//        // Use KVO to observe for changes of the thumbnail image.
//        if (self.observedVisibleItems == nil) {
//            _observedVisibleItems = [NSMutableArray new];
//        }
//        if (![self.observedVisibleItems containsObject:entity]) {
//            [imageEntity addObserver:self forKeyPath:ATEntityPropertyNamedThumbnailImage options:0 context:nil];
//            [imageEntity loadImage];
//            [self.observedVisibleItems addObject:imageEntity];
//        }
//
//        // Hide/show progress based on the thumbnail image being loaded or not.
//        if (imageEntity.thumbnailImage == nil) {
//            cellView.progessIndicator.hidden = NO;
//            [cellView.progessIndicator startAnimation:nil];
//            cellView.imageView.hidden = YES;
//        } else {
//            cellView.imageView.image = imageEntity.thumbnailImage;
//        }
//
//        // Size/hide things based on the row size.
//        [cellView layoutViewsForSmallSize:self.useSmallRowHeight animated:NO];
//        return cellView;
//    }
//}

// We make the "group rows" have the standard height, while all other image rows have a larger height.
- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 20;
}

- (NSIndexSet *)tableView:(NSTableView *)tableView selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes {
    // We don't want to change the selection if the user clicked in the fill color area.
//    NSInteger row = tableView.clickedRow;
//    if (row != -1 && ![self tableView:tableView isGroupRow:row]) {
//        ATTableCellView *cellView = [self.tableViewMain viewAtColumn:0 row:row makeIfNecessary:NO];
//        if (cellView) {
//            // Use hit testing to see if is a color view; if so, don't let it change the selection.
//            NSPoint windowPoint = NSApp.currentEvent.locationInWindow;
//            NSPoint point = [cellView.superview convertPoint:windowPoint fromView:nil];
//            NSView *view = [cellView hitTest:point];
//            if ([view isKindOfClass:[ATColorView class]]) {
//                // Don't allow the selection change.
//                return tableView.selectedRowIndexes;
//            }
//        }
//    }
    return proposedSelectionIndexes;
}

#pragma mark - UI control callback

-(IBAction)onOpenButtonClicked:(id)sender {
    [self.assManager loadTestFile];
}

-(IBAction)onSaveButtonClicked:(id)sender {
    [self.assManager saveTestFile];
}


@end
