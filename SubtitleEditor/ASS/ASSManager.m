//
//  ASSManager.m
//  SubtitleEditor
//
//  Created by ocean on 2018/12/27.
//  Copyright © 2018年 Ocean. All rights reserved.
//

#import "ASSManager.h"
#import "ASSFileLoader.h"
#import "ASSSection.h"
#import "ASSEventsSection.h"
#import "ASSDialogTableViewController.h"
#import "StylesManager.h"

@interface ASSManager()
@property (strong) ASSFileLoader *assFileLoader;
@property (strong) NSMutableArray* sections;
@property (strong) NSString* outputFileURL;
@end

@implementation ASSManager

-(id) init {
    NSLog(@"++++++++++++ assmanager init.");
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.assFileLoader = [[ASSFileLoader alloc] init];
    self.sections = [NSMutableArray array];
    
    return self;
}

-(void) loadTestFile {
    self.sections = [NSMutableArray array];
    
    NSBundle *myBundle = [NSBundle mainBundle];
//    NSString *assFilePath = [myBundle pathForResource:@"TestResources/test1" ofType:@"ass"];
//    NSString *assFilePath = [myBundle pathForResource:@"TestResources/test2" ofType:@"ass"];
//    NSString *assFilePath = [myBundle pathForResource:@"TestResources/test3" ofType:@"ass"];
//    NSString *assFilePath = [myBundle pathForResource:@"TestResources/test4" ofType:@"ass"];
//    NSString *assFilePath = [myBundle pathForResource:@"TestResources/test5" ofType:@"ass"];
//    NSString *assFilePath = [myBundle pathForResource:@"TestResources/test6" ofType:@"ass"];
//    NSString *assFilePath = [myBundle pathForResource:@"TestResources/short" ofType:@"ass"];
    NSString *assFilePath = [myBundle pathForResource:@"TestResources/short2" ofType:@"ass"];
    NSLog(@"+++++++++ ass file path:%@", assFilePath);
    
    NSData* rawData = [NSData dataWithContentsOfFile:assFilePath];
    [self loadASSData:rawData];
}

-(void) loadFileFromURL:(NSURL*)url {
    self.sections = [NSMutableArray array];
    [[StylesManager sharedInstance] reset];
    
    NSData* rawData = [NSData dataWithContentsOfFile:[url path]];
    [self loadASSData:rawData];
}

-(void) loadASSData:(NSData*)rawData {
    [self.assFileLoader loadFrowRawData:rawData sections:self.sections];
    for (int i = 0; i < self.sections.count; ++i) {
        if ([self.sections[i] isKindOfClass:[ASSEventsSection class]]) {
            self.eventSection = self.sections[i];
            self.eventSection.tableViewController = self.tableViewController;
            self.tableViewController.eventSection = self.eventSection;
        }
        [self.sections[i] parseLines];
    }
    
    [self checkDialogsStartTimeSequences];
}

-(NSInteger) getDialogLinesCount {
    if (!self.eventSection) {
        return 0;
    }
    NSLog(@"++++++++++++++++ getDialogLinesCount:%@", self.eventSection);
    return [self.eventSection getDialogLinesCount];
}

-(void) saveTestFile {
    NSString* outputFilePath = @"/Users/ocean/Downloads/test1.ass";
    [self saveASSFile:outputFilePath];
}

-(void) saveASSFileAs:(NSURL*)url {
    [self saveASSFile:[url path]];
}

-(void) saveASSFile:(NSString*)filePath {
    NSMutableArray* allLines = [NSMutableArray array];
    for (int i = 0; i < self.sections.count; ++i) {
        NSArray* sectionLines = [self.sections[i] getOutputLines];
        [allLines addObjectsFromArray:sectionLines];
    }
    
    NSMutableData* data = [NSMutableData data];
    for (int i = 0; i < allLines.count; ++i) {
        NSData* lineData = [allLines[i] dataUsingEncoding:NSUTF8StringEncoding];
        [data appendData:lineData];
        [data appendData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSError* error = nil;
    BOOL writeResult = [data writeToFile:filePath options:NSDataWritingAtomic error:&error];
    NSLog(@"+++++++++++++ data:%ld write to path:%@, result:%d, error:%@", data.length,  filePath, writeResult, error);
}

-(NSString *) datafilepath{
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents=[path objectAtIndex:0];
    return [documents stringByAppendingFormat:@"/test1.ass"];
}

-(void) writeDataToURL:(NSURL*)url {
    
}

-(NSString*) getDialogStartTimeTextOfRow:(NSInteger)rowIndex {
    return [self.eventSection getDialogStartTimeOfLine:rowIndex];
}

-(NSString*) getDialogEndTimeTextOfRow:(NSInteger)rowIndex {
    return [self.eventSection getDialogEndTimeOfLine:rowIndex];
}

-(NSString*) getDialogDefaultStyleOfRow:(NSInteger)rowIndex {
    return [self.eventSection getDialogDefaultStyleNameOfLine:rowIndex];
}

-(NSString*) getDialogDisplayText1OfRow:(NSInteger)rowIndex {
    return [self.eventSection getDialogDisplayText1OfLine:rowIndex];
}

-(NSString*) getDialogDisplayText2OfRow:(NSInteger)rowIndex {
    return [self.eventSection getDialogDisplayText2OfLine:rowIndex];
}

-(void) checkDialogsStartTimeSequences {
    [self.eventSection checkDialogsStartTimeSequences];
}

-(void) sortDialogsByStartTime {
    [self.eventSection sortDialogsByStartTime];
}

@end
