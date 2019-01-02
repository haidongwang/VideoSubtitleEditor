//
//  ASSEventDialogLine.m
//  SubtitleEditor
//
//  Created by ocean on 2018/12/31.
//  Copyright © 2018年 Ocean. All rights reserved.
//

#import "ASSEventDialogLine.h"
#import "ASSDialogTimeFrame.h"
#import "ASSDialogText.h"

@interface ASSEventDialogLine() {
//    NSInteger layer_;
}

@property (strong) NSMutableString* text;
@property (strong) NSString* prefix;
@property NSInteger layer;
@property (strong) ASSDialogTimeFrame* startTime;
@property (strong) ASSDialogTimeFrame* endTime;
@property (strong) NSString* styleName;
@property (strong) NSString* dialogName;
@property NSInteger leftMargin;
@property NSInteger rightMargin;
@property NSInteger verticalMargin;
@property (strong) NSString* effect;
@property (strong) ASSDialogText* text1;
@property (strong) ASSDialogText* text2;
@end

@implementation ASSEventDialogLine

-(id) initWithText:(NSString*)text {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.prefix = @"Dialogue:";
    if (![text hasPrefix:self.prefix]) {
        NSLog(@"[WARNING] not valid dialog line:%@.", text);
        return nil;
    }
    
    
    NSMutableString* textCopy = [NSMutableString stringWithString:text];
//    textCopy = [textCopy substringFromIndex:self.prefix.length];
    [textCopy deleteCharactersInRange:NSMakeRange(0, self.prefix.length)];
    
    self.text = textCopy;
    
    [self getLayer];
    [self getDialogStartTime];
    [self getDialogEndTime];
    [self getStyleName];
    [self getDialogName];
    [self getMargins];
    [self getEffect];
    [self getText1];
    [self getText2];

    return self;
}

-(NSString*) getOutputTextLine {
    NSMutableString* textLine = [NSMutableString string];
    [textLine appendString:self.prefix];
    [textLine appendString:[NSString stringWithFormat:@" %ld,", self.layer]];
    [textLine appendString:[self.startTime getOutputText]];
    [textLine appendString:@","];
    [textLine appendString:[self.endTime getOutputText]];
    [textLine appendString:@","];
    [textLine appendString:self.styleName];
    [textLine appendString:@","];
    [textLine appendString:self.dialogName];
    [textLine appendString:@","];
    [textLine appendString:[NSString stringWithFormat:@"%ld", self.leftMargin]];
    [textLine appendString:@","];
    [textLine appendString:[NSString stringWithFormat:@"%ld", self.rightMargin]];
    [textLine appendString:@","];
    [textLine appendString:[NSString stringWithFormat:@"%ld", self.verticalMargin]];
    [textLine appendString:@","];
    [textLine appendString:self.effect];
    [textLine appendString:@","];
    [textLine appendString:[self.text1 getOutputText]];
    [textLine appendString:@"\\N"];
    [textLine appendString:[self.text2 getOutputText]];
    
    return textLine;
}

-(void) getLayer {
    NSInteger nextCommaPosition = [self getNextCommaPosition:self.text];
    if (nextCommaPosition < 0) {
        return;
    }
    
    NSString* layerString = [self.text substringToIndex:nextCommaPosition];
    self.layer = [layerString integerValue];
    
    [self.text deleteCharactersInRange:NSMakeRange(0, nextCommaPosition + 1)];
}

-(void) getDialogStartTime {
    NSInteger nextCommaPosition = [self getNextCommaPosition:self.text];
    if (nextCommaPosition < 0) {
        NSLog(@"[WARNING] failed to get dialog start time:%@.", self.text);
        return;
    }
    
    NSString* startTimeText = [self.text substringToIndex:nextCommaPosition];
    self.startTime = [[ASSDialogTimeFrame alloc] initWithText:startTimeText];
    
    [self.text deleteCharactersInRange:NSMakeRange(0, nextCommaPosition + 1)];
}

-(void) getDialogEndTime {
    NSInteger nextCommaPosition = [self getNextCommaPosition:self.text];
    if (nextCommaPosition < 0) {
        NSLog(@"[WARNING] failed to get dialog end time:%@.", self.text);
        return;
    }
    
    NSString* endTimeText = [self.text substringToIndex:nextCommaPosition];
    self.endTime = [[ASSDialogTimeFrame alloc] initWithText:endTimeText];
    
    [self.text deleteCharactersInRange:NSMakeRange(0, nextCommaPosition + 1)];
}

-(void) getStyleName {
    NSInteger nextCommaPosition = [self getNextCommaPosition:self.text];
    if (nextCommaPosition < 0) {
        NSLog(@"[WARNING] failed to get style name:%@.", self.text);
        return;
    }
    
    self.styleName = [self.text substringToIndex:nextCommaPosition];
    [self.text deleteCharactersInRange:NSMakeRange(0, nextCommaPosition + 1)];
}

-(void) getDialogName {
    self.dialogName = [self getNextString];
}

-(void) getMargins {
    self.leftMargin = [self getNextInteger];
    self.rightMargin = [self getNextInteger];
    self.verticalMargin = [self getNextInteger];
}

-(void) getEffect {
    self.effect = [self getNextString];
}

-(void) getText1 {
    NSInteger newLinePosition = [self getTextNewLinePosition:self.text];
    if (newLinePosition < 0) {
        self.text1 = [[ASSDialogText alloc] initWithText:self.text];
        [self.text deleteCharactersInRange:NSMakeRange(0, self.text.length)];
        return;
    }
    
    NSString* text1String = [self.text substringToIndex:newLinePosition];
    self.text1 = [[ASSDialogText alloc] initWithText:text1String];
    [self.text deleteCharactersInRange:NSMakeRange(0, newLinePosition + 2)];
}

-(void) getText2 {
    self.text2 = [[ASSDialogText alloc] initWithText:self.text];
    [self.text deleteCharactersInRange:NSMakeRange(0, self.text.length)];
}

-(NSString*) getNextString {
    NSInteger nextCommaPosition = [self getNextCommaPosition:self.text];
    if (nextCommaPosition < 0) {
        NSLog(@"[WARNING] failed to get next string:%@.", self.text);
        return @"";
    }
    
    NSString* str = [self.text substringToIndex:nextCommaPosition];
    [self.text deleteCharactersInRange:NSMakeRange(0, nextCommaPosition + 1)];
    return str;
}

-(NSInteger) getNextInteger {
    NSInteger nextCommaPosition = [self getNextCommaPosition:self.text];
    if (nextCommaPosition < 0) {
        NSLog(@"[WARNING] failed to get next integer:%@.", self.text);
        return 0;
    }
    
    NSInteger intValue = [[self.text substringToIndex:nextCommaPosition] integerValue];
    [self.text deleteCharactersInRange:NSMakeRange(0, nextCommaPosition + 1)];
    return intValue;
}

-(NSInteger) getNextCommaPosition:(NSString*)text {
    NSInteger position = -1;
    for (int i = 0; i < text.length; ++i) {
        if ([text characterAtIndex:i] == ',') {
            position = i;
            break;
        }
    }
    
    return position;
}

-(NSInteger) getTextNewLinePosition:(NSString*)text {
    NSInteger position = -1;
    for (int i = 0; i < text.length; ++i) {
        if ([text characterAtIndex:i] == '\\') {
            if (i + 1 < text.length && [text characterAtIndex:i + 1] == 'N') {
                position = i;
                break;
            }
        }
    }
    
    return position;
}


@end
