//
//  ASSEventsSection.m
//  SubtitleEditor
//
//  Created by ocean on 2018/12/31.
//  Copyright © 2018年 Ocean. All rights reserved.
//

#import "ASSEventsSection.h"
#import "ASSEventDialogLine.h"
#import "ASSDialogTableViewController.h"

@interface ASSEventsSection () {
    
}
@property (strong) NSString* formatLine;
@property (strong) NSMutableArray* dialogLines;
@property (strong) NSMutableArray* hasProblemDialogs;

-(BOOL) isFormatLine:(NSString*)line;

@end

@implementation ASSEventsSection

-(id) init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.dialogLines = [NSMutableArray array];
    self.hasProblemDialogs = [NSMutableArray array];
    
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

-(NSInteger) getDialogLinesCount {
    return self.dialogLines.count;
}

-(NSString*) getDialogStartTimeOfLine:(NSInteger)lineIndex {
    return [self.dialogLines[lineIndex] getDialogStartTimeText];
}

-(NSString*) getDialogEndTimeOfLine:(NSInteger)lineIndex {
    return [self.dialogLines[lineIndex] getDialogEndTimeText];
}

-(NSString*) getDialogDefaultStyleNameOfLine:(NSInteger)lineIndex {
    return [self.dialogLines[lineIndex] getDefaultStyleName];
}

-(NSString*) getDialogText1OfLine:(NSInteger)lineIndex {
    return [self.dialogLines[lineIndex] getDialogText1];
}

-(NSString*) getDialogText2OfLine:(NSInteger)lineIndex {
    return [self.dialogLines[lineIndex] getDialogText2];
}

-(void) checkDialogsStartTimeSequences {
    self.hasProblemDialogs = [NSMutableArray array];
    for (int i = 1; i < self.dialogLines.count; ++i) {
        NSInteger prevLineTotalMiliSeconds = [self.dialogLines[i - 1] getStartTimeInMiliSeconds];
        NSInteger currentLineTotalMiliSeconds = [self.dialogLines[i] getStartTimeInMiliSeconds];
        if (currentLineTotalMiliSeconds < prevLineTotalMiliSeconds) {
//            [self.tableViewController markStartTimeWarningForRow:i];
            [self.hasProblemDialogs addObject:[NSNumber numberWithInteger:i]];
        }
    }
    
    if (self.hasProblemDialogs.count > 0) {
        [self.tableViewController.sortButton setEnabled:YES];
        NSLog(@"+++++++++++ enabled:%@.", self.tableViewController.sortButton);
    } else {
        [self.tableViewController.sortButton setEnabled:NO];
    }
    NSLog(@"+++++++++++ has problem lines:%ld", self.hasProblemDialogs.count);
}

-(BOOL) isStartTimeLessThenPreviousOne:(NSInteger)lineIndex {
    NSNumber* number = [NSNumber numberWithInteger:lineIndex];
    if ([self.hasProblemDialogs indexOfObject:number] == NSNotFound) {
        return NO;
    }
    return YES;
}

-(void) sortDialogsByStartTime {
    NSLog(@"+++++++++++++ sortDialogsWithStartTime;");
    [self.dialogLines sortUsingComparator:^NSComparisonResult(id a, id b) {
        ASSEventDialogLine* first = a;
        ASSEventDialogLine* second = b;
        return [first compare:second];
    }];
}

@end
