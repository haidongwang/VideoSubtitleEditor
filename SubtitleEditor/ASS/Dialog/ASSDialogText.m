//
//  ASSDialogText.m
//  SubtitleEditor
//
//  Created by ocean on 2019/1/2.
//  Copyright © 2019年 Ocean. All rights reserved.
//

#import "ASSDialogText.h"

@interface ASSDialogText () {
}

@property (strong) NSString* text;

@end

@implementation ASSDialogText

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
