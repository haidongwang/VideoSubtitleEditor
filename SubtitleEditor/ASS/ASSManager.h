//
//  ASSManager.h
//  SubtitleEditor
//
//  Created by ocean on 2018/12/27.
//  Copyright © 2018年 Ocean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface ASSManager : NSObject

@property (weak) NSWindow* window;

-(void) loadTestFile;
-(void) saveTestFile;
-(NSInteger) getDialogLinesCount;
-(NSString*) getDialogStartTimeTextOfRow:(NSInteger)rowIndex;
-(NSString*) getDialogEndTimeTextOfRow:(NSInteger)rowIndex;
-(NSString*) getDialogDefaultStyleOfRow:(NSInteger)rowIndex;
-(NSString*) getDialogText1OfRow:(NSInteger)rowIndex;
-(NSString*) getDialogText2OfRow:(NSInteger)rowIndex;

@end
