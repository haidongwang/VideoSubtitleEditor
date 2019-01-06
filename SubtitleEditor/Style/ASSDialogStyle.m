//
//  ASSDialogStyle.m
//  SubtitleEditor
//
//  Created by ocean on 2019/1/6.
//  Copyright © 2019年 Ocean. All rights reserved.
//

#import "ASSDialogStyle.h"

@interface ASSDialogStyle ()


@end

@implementation ASSDialogStyle

-(id) initWithString:(NSString*)style {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.rawStyle = [style copy];
    
    return self;
}

-(NSString*) getOutputString {
    return self.rawStyle;
}

-(NSString*) getDisplaystring {
    return self.rawStyle;
}

@end
