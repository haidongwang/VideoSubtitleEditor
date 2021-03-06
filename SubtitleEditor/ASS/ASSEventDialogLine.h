//
//  ASSEventDialogLine.h
//  SubtitleEditor
//
//  Created by ocean on 2018/12/31.
//  Copyright © 2018年 Ocean. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASSEventDialogLine : NSObject {
    
}

-(id) initWithText:(NSString*)text;
-(NSString*) getOutputTextLine;
-(NSString*) getDialogStartTimeText;
-(NSString*) getDialogEndTimeText;
-(NSString*) getDefaultStyleName;
-(NSString*) getDialogText1DisplayString;
-(NSString*) getDialogText2DisplayString;
-(NSInteger) getStartTimeInMiliSeconds;

-(NSComparisonResult) compare:(ASSEventDialogLine*)otherLine;
@end
