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

@property (strong) NSString* text;

@end

@implementation ASSDialogTimeFrame

-(id) initWithText:(NSString*)text {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.text = [text copy];
    
    return self;
}

-(NSString*) getOutputText {
    return self.text;
}

@end
