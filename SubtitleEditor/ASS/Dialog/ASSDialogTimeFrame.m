//
//  ASSDialogTimeFrame.m
//  SubtitleEditor
//
//  Created by ocean on 2018/12/31.
//  Copyright © 2018年 Ocean. All rights reserved.
//

#import "ASSDialogTimeFrame.h"

@interface ASSDialogTimeFrame() {
    
}

@property NSInteger totalMiliseconds;

@property (strong) NSString* text;

@end

@implementation ASSDialogTimeFrame

-(id) initWithText:(NSString*)text {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.text = [text copy];

    NSString* hourText = [self.text substringWithRange:NSMakeRange(0, 1)];
    NSInteger hours = [hourText integerValue];

    NSString* minutesText = [self.text substringWithRange:NSMakeRange(2, 2)];
    NSInteger minutes = [minutesText integerValue];

    NSString* secondsText = [self.text substringWithRange:NSMakeRange(5, 2)];
    NSInteger seconds = [secondsText integerValue];
    
    NSString* milisecondsText = [self.text substringWithRange:NSMakeRange(8, 2)];
    NSInteger miliseconds = [milisecondsText integerValue] * 10;
    
//    NSLog(@"++++++++++ hour:%@/%ld, minutes:%@/%ld, seconds:%@/%ld, mili:%@/%ld", hourText, hours, minutesText, minutes, secondsText, seconds, milisecondsText, miliseconds);
    self.totalMiliseconds = (hours * 3600 + minutes * 60 + seconds) * 1000 + miliseconds;
//    NSLog(@"++++++++ total miliseconds:%ld", self.totalMiliseconds);
    
    
    return self;
}

-(NSString*) getOutputText {
    return self.text;
}

-(NSInteger) getTotalMiliSeconds {
    return self.totalMiliseconds;
}

@end
