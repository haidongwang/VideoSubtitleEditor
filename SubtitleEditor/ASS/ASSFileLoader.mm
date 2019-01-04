//
//  ASSFileLoader.m
//  SubtitleEditor
//
//  Created by ocean on 2018/12/26.
//  Copyright © 2018年 Ocean. All rights reserved.
//

#import "ASSFileLoader.h"
#import "ASSSection.h"
#import "ASSEventsSection.h"
#import <Cocoa/Cocoa.h>

@interface ASSFileLoader () {
    
}

@end

@implementation ASSFileLoader

-(id) init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    return self;
}

-(void) loadFrowRawData:(NSData*)data sections:(NSMutableArray*)sections {
    if (!data) {
        return;
    }
    
    NSMutableString* assText = [[NSMutableString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
//    if (!assText) {
//        assText = [[NSString alloc] initWithData:data encoding:NSUTF16LittleEndianStringEncoding];
//    }
    
    if (!assText) {
        assText = [[NSMutableString alloc] initWithData:data encoding:NSUTF16StringEncoding];
    }

    if (!assText) {
        NSAlert* alert = [[NSAlert alloc] init];
        alert.messageText = @"Failed to load file.";
        [alert runModal];
    }
    
    [assText replaceOccurrencesOfString:@"\r" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, assText.length)];
    
    NSArray* lines = [assText componentsSeparatedByString:@"\n"];
    NSMutableArray* mutableLines = [NSMutableArray arrayWithArray:lines];

    while ([self getNextSection:mutableLines sections:sections]) {
    };
}

-(BOOL) getNextSection:(NSMutableArray*)lines sections:(NSMutableArray*)sections {
    NSInteger sectionStartLine = 0;
    for (NSInteger i = 0; i < lines.count; ++i) {
        if ([self isSectionTitleLine:lines[i]]) {
            sectionStartLine = i;
            break;
        }
    }
    
    if (sectionStartLine == lines.count) {
        return NO;
    }
    
    NSInteger sectionEndLine = lines.count;
    for (NSInteger i = sectionStartLine + 1; i < lines.count; ++i) {
        if ([self isSectionTitleLine:lines[i]]) {
            sectionEndLine = i;
            break;
        }
    }
    
    NSString* title = [self getSectionTitle:lines[sectionStartLine]];
    ASSSection* section = nil;
    if ([title isEqualToString:@"Events"]) {
        section = [[ASSEventsSection alloc] init];
    } else {
        section = [[ASSSection alloc] init];
    }
    [section setTitle:title];
    NSMutableArray* sectionLines = [NSMutableArray array];
    for (NSInteger i = sectionStartLine + 1; i < sectionEndLine; ++i) {
        [sectionLines addObject:lines[i]];
    }
    [section setLines:sectionLines];
    
    NSRange range = NSMakeRange(sectionStartLine, sectionEndLine - sectionStartLine);
    [lines removeObjectsInRange:range];
    
    [sections addObject:section];
    NSLog(@"++++++++++++ %ld --> %ld", sectionStartLine, sectionEndLine);
//    NSLog(@"++++++++++ title:%@ count:%ld", section.title, section.lines.count);
    
    return YES;
}

-(BOOL) isSectionTitleLine:(NSString*)line {
    if (line.length > 0 && [line characterAtIndex:0] == '[') {
        return YES;
    }
    return NO;
}

-(NSString*) getSectionTitle:(NSString*)line {
    NSInteger titleStart = 0;
    NSInteger titleEnd = 0;
    for (int i = 0; i < line.length; ++i) {
        if ([line characterAtIndex:i] == '[') {
            titleStart = i + 1;
        } else if ([line characterAtIndex:i] == ']') {
            titleEnd = i;
        }
    }
    
    if (titleEnd >= titleStart + 1) {
        return [line substringWithRange:NSMakeRange(titleStart, titleEnd - titleStart)];
    }
    
    return nil;
}


@end

