//
//  ASSDialogText.m
//  SubtitleEditor
//
//  Created by ocean on 2019/1/2.
//  Copyright © 2019年 Ocean. All rights reserved.
//

#import "ASSDialogText.h"
#import "StylesManager.h"
#import "ASSDialogStyle.h"

@interface ASSDialogText () {
}

@property (strong) NSMutableString* outputText;
@property (strong) NSMutableString* displayText;
@property (strong) NSMutableArray* splitedTexts;

@end

@implementation ASSDialogText

-(id) initWithText:(NSString*)text {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.outputText = [NSMutableString stringWithString:text];
    
    [self splitStylesAndTexts];
    
    return self;
}

-(NSString*) getOutputText {
    return self.outputText;
}

-(NSString*) getDisplayText {
    return self.displayText;
}

-(BOOL) isEmpty {
    return self.outputText.length == 0;
}

-(void) splitStylesAndTexts {
    self.splitedTexts = [NSMutableArray array];
    NSMutableString* dialogLine = [NSMutableString stringWithString:self.outputText];
    while (dialogLine.length > 0) {
        if ([dialogLine characterAtIndex:0] == '{') {
            NSString* rawStyle = [self extractStyle:dialogLine];
            ASSDialogStyle* style = [[ASSDialogStyle alloc] initWithString:rawStyle];
            [self.splitedTexts addObject:style];
        } else {
            NSString* text = [self extractText:dialogLine];
            [self.splitedTexts addObject:text];
        }
    }
    
    [self mergeSequencedStyles];
    
    self.displayText = [NSMutableString string];
    self.outputText = [NSMutableString string];
    for (NSInteger i = 0; i < self.splitedTexts.count; ++i) {
        if ([self.splitedTexts[i] isKindOfClass:[ASSDialogStyle class]]) {
            ASSDialogStyle* style = (ASSDialogStyle*)self.splitedTexts[i];
            
            [[StylesManager sharedInstance] registerStyle:style];
            
            [self.displayText appendString:style.symbol];
            [self.outputText appendString:style.rawStyle];
        } else {
            [self.displayText appendString:self.splitedTexts[i]];
            [self.outputText appendString:self.splitedTexts[i]];
        }
    }
}

-(void) mergeSequencedStyles {
    NSMutableArray* oldSplitedTexts = self.splitedTexts;
    self.splitedTexts = [NSMutableArray array];
    while (oldSplitedTexts.count > 0) {
        NSObject* firstObject = oldSplitedTexts[0];
        if ([firstObject isKindOfClass:[ASSDialogStyle class]]) {
            NSInteger nextNonStyleObjectIndex = 1;
            for (NSInteger i = 1; i < oldSplitedTexts.count; ++i) {
                NSObject* object = oldSplitedTexts[i];
                if (![object isKindOfClass:[ASSDialogStyle class]]) {
                    nextNonStyleObjectIndex = i;
                    break;
                }
            }
            
            ASSDialogStyle* combinedStyle = [self mergeSequenceStylesOf:oldSplitedTexts To:nextNonStyleObjectIndex];
            [oldSplitedTexts removeObjectsInRange:NSMakeRange(0, nextNonStyleObjectIndex)];
            [self.splitedTexts addObject:combinedStyle];
        } else {
            [self.splitedTexts addObject:firstObject];
            [oldSplitedTexts removeObjectAtIndex:0];
        }
    }
}

-(ASSDialogStyle*) mergeSequenceStylesOf:(NSMutableArray*)objects To:(NSInteger)nonStyleObjectIndex {
    if (nonStyleObjectIndex == 1) {
        return (ASSDialogStyle*)objects[0];
    } else {
        NSMutableString* combinedString = [NSMutableString string];
        for (NSInteger i = 0; i < nonStyleObjectIndex; ++i) {
            ASSDialogStyle* style = objects[i];
            [combinedString appendString:style.rawStyle];
        }
        
        [combinedString replaceOccurrencesOfString:@"}{" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, combinedString.length)];
        
        return [[ASSDialogStyle alloc] initWithString:combinedString];
    }
}

-(NSString*) extractText:(NSMutableString*)line {
    NSInteger textEndIndex = -1;
    for (NSInteger i = 0; i < line.length; ++i) {
        if ([line characterAtIndex:i] == '{') {
            textEndIndex = i;
            break;
        }
    }
    if (textEndIndex == -1) {
        textEndIndex = line.length;
    }
    
    NSString* textString = [line substringToIndex:textEndIndex];
    [line deleteCharactersInRange:NSMakeRange(0, textEndIndex)];
    return textString;
}

-(NSString*) extractStyle:(NSMutableString*)line {
    NSInteger styleEndIndex = -1;
    for (NSInteger i = 0; i < line.length; ++i) {
        if ([line characterAtIndex:i] == '}') {
            styleEndIndex = i + 1;
            break;
        }
    }
    if (styleEndIndex == -1) {
        styleEndIndex = line.length;
    }
    
    NSString* styleString = [line substringToIndex:styleEndIndex];
    [line deleteCharactersInRange:NSMakeRange(0, styleEndIndex)];
    return styleString;
}

@end
