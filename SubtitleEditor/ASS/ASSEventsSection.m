//
//  ASSEventsSection.m
//  SubtitleEditor
//
//  Created by ocean on 2018/12/31.
//  Copyright © 2018年 Ocean. All rights reserved.
//

#import "ASSEventsSection.h"
#import "ASSEventDialogLine.h"

@interface ASSEventsSection () {
    
}
@property (strong) NSString* formatLine;
@property (strong) NSMutableArray* dialogLines;

-(BOOL) isFormatLine:(NSString*)line;

@end

@implementation ASSEventsSection

-(id) init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.dialogLines = [NSMutableArray array];
    
    return self;
}

-(NSArray*) getOutputLines {
    NSMutableArray* arr = [NSMutableArray array];
    [arr addObject:[NSString stringWithFormat:@"[%@]", self.sectionTitle]];
    [arr addObject:self.formatLine];
    
    for (int i = 0; i < self.dialogLines.count; ++i) {
        ASSEventDialogLine* dialogLine = self.dialogLines[i];
        [arr addObject:[dialogLine getOutputTextLine]];
    }
    return arr;
}

-(void) parseLines {
    for (int i = 0; i < self.sectionLines.count; ++i) {
        if ([self isFormatLine:self.sectionLines[i]]) {
            self.formatLine = [self.sectionLines[i] copy];
        } else {
            ASSEventDialogLine* line = [[ASSEventDialogLine alloc] initWithText:self.sectionLines[i]];
            if (line) {
                [self.dialogLines addObject:line];
            }
        }
    }
    
}

-(BOOL) isFormatLine:(NSString*)line {
    if ([line hasPrefix:@"Format:"]) {
        return YES;
    }
    return NO;
}

@end
