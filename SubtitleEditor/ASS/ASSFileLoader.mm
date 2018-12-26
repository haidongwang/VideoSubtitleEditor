//
//  ASSFileLoader.m
//  SubtitleEditor
//
//  Created by ocean on 2018/12/26.
//  Copyright © 2018年 Ocean. All rights reserved.
//

#import "ASSFileLoader.h"
#import "ASSSection.h"

@interface ASSFileLoader () {
    
}

@property (strong) NSMutableArray* sections;

@end

@implementation ASSFileLoader

-(id) init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.sections = [NSMutableArray array];
    
    return self;
}

-(void) loadFrowRawData:(NSData*)data {
    if (!data) {
        return;
    }
    
    NSString* utf8String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray* lines = [utf8String componentsSeparatedByString:@"\n"];
    NSMutableArray* mutableLines = [NSMutableArray arrayWithArray:lines];
    
    while ([self getNextSection:mutableLines]) {
    };
}

-(BOOL) getNextSection:(NSMutableArray*)lines {
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
    
    ASSSection* section = [[ASSSection alloc] init];
    [section setTitle:[self getSectionTitle:lines[sectionStartLine]]];
    NSMutableArray* sectionLines = [NSMutableArray array];
    for (NSInteger i = sectionStartLine + 1; i < sectionEndLine; ++i) {
        [sectionLines addObject:lines[i]];
    }
    [section setLines:sectionLines];
    
    NSRange range = NSMakeRange(sectionStartLine, sectionEndLine - sectionStartLine);
    [lines removeObjectsInRange:range];
    
    [self.sections addObject:section];
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

