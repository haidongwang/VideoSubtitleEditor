//
//  ASSEventsSection.h
//  SubtitleEditor
//
//  Created by ocean on 2018/12/31.
//  Copyright © 2018年 Ocean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASSSection.h"

@interface ASSEventsSection : ASSSection

-(NSArray*) getOutputLines;
-(void) parseLines;
-(NSInteger) getDialogLinesCount;
-(NSString*) getDialogStartTimeOfLine:(NSInteger)lineIndex;
-(NSString*) getDialogEndTimeOfLine:(NSInteger)lineIndex;
-(NSString*) getDialogDefaultStyleNameOfLine:(NSInteger)lineIndex;
-(NSString*) getDialogText1OfLine:(NSInteger)lineIndex;
-(NSString*) getDialogText2OfLine:(NSInteger)lineIndex;

@end
