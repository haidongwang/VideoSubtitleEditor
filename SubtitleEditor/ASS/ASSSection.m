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

-(void) setLines:(NSMutableArray*)lines {
    self.sectionLines = lines;
}

-(void) parseLines {
    // Do nothing here
}

-(NSArray*) getOutputLines {
    NSMutableArray* arr = [NSMutableArray array];
    [arr addObject:[NSString stringWithFormat:@"[%@]", self.sectionTitle]];
    [arr addObjectsFromArray:self.sectionLines];
    return arr;
}

@end
