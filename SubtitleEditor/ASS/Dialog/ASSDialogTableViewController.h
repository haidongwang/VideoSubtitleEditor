//
//  ASSDialogTableViewController.h
//  SubtitleEditor
//
//  Created by ocean on 2019/1/4.
//  Copyright © 2019年 Ocean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASSManager.h"

@class ASSEventsSection;
@interface ASSDialogTableViewController : NSObject

@property (weak) ASSManager *assManager;
@property (weak) ASSEventsSection *eventSection;
@property (weak) IBOutlet NSButton* sortButton;

-(void) markStartTimeWarningForRow:(NSInteger)rowIndex;

@end
