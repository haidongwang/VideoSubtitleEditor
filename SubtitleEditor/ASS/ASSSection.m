//
//  ASSSection.m
//  SubtitleEditor
//
//  Created by ocean on 2018/12/26.
//  Copyright © 2018年 Ocean. All rights reserved.
//

#import "ASSSection.h"

@interface ASSSection () {
    
}
@property (nonatomic, readwrite) NSString* sectionTitle;
@property (nonatomic, readwrite) NSArray* sectionLines;

@end

@implementation ASSSection

-(id) init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    return self;
}

-(void) setTitle:(NSString*)title {
    self.sectionTitle = title;
}

-(void) setLines:(NSArray*)lines {
    self.sectionLines = lines;
}

@end
