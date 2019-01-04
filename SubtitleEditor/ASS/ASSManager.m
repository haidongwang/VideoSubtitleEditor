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

@interface ASSManager()
@property (strong) ASSFileLoader *assFileLoader;
@property (strong) NSMutableArray* sections;
@property (strong) NSString* outputFileURL;
@property (weak) ASSEventsSection* eventSection;
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
    NSBundle *myBundle = [NSBundle mainBundle];
//    NSString *assFilePath = [myBundle pathForResource:@"TestResources/test1" ofType:@"ass"];
//    NSString *assFilePath = [myBundle pathForResource:@"TestResources/test2" ofType:@"ass"];
//    NSString *assFilePath = [myBundle pathForResource:@"TestResources/test3" ofType:@"ass"];
//    NSString *assFilePath = [myBundle pathForResource:@"TestResources/test4" ofType:@"ass"];
    NSString *assFilePath = [myBundle pathForResource:@"TestResources/short" ofType:@"ass"];
    NSLog(@"+++++++++ ass file path:%@", assFilePath);
    
    NSData* rawData = [NSData dataWithContentsOfFile:assFilePath];
    
    [self.assFileLoader loadFrowRawData:rawData sections:self.sections];
    for (int i = 0; i < self.sections.count; ++i) {
        if ([self.sections[i] isKindOfClass:[ASSEventsSection class]]) {
            self.eventSection = self.sections[i];
        }
        [self.sections[i] parseLines];
    }
    NSLog(@"+++++++++ %@", self.eventSection);
    
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
    BOOL writeResult = [data writeToFile:outputFilePath options:NSDataWritingAtomic error:&error];
    NSLog(@"+++++++++++++ data:%ld write to path:%@, result:%d, error:%@", data.length,  outputFilePath, writeResult, error);

//    if (!self.outputFileURL) {
//        NSSavePanel*   panel = [NSSavePanel savePanel];
//        [panel setNameFieldStringValue:@""];
//        NSArray *allowedFileTypes = [NSArray arrayWithObject:@"ass"];
//        [panel setAllowedFileTypes:allowedFileTypes];
//        [panel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result){
//            if (result == NSModalResponseOK) {
//                self.outputFileURL = [panel URL];
//                NSURL* theFile = [panel URL];
//                LevelWriter* writer = [[LevelWriter alloc] init];
//                [writer writeToFile:theFile info:&levelInfo_];
//                self.fileURL = theFile;
//                self.workingPath = [fileURL_.path stringByDeletingLastPathComponent];
//                isModificationSaved_ = YES;
//                NSArray *pathComponents = self.fileURL.pathComponents;
//                if (pathComponents.count > 0) {
//                    self.fileName = [pathComponents objectAtIndex:pathComponents.count - 1];
//                    workingLevelIndex_ = (int)[[self.fileName substringWithRange:NSMakeRange(5, 8)] integerValue] - 1;
//                    [self updateUploadButtonState];
//                }
//
//                [self updateTitle];
//                [self updateSaveButtonState];
//                [self updateDeleteButtonState];
//            }
//        }];
//    } else {
//        LevelWriter* writer = [[LevelWriter alloc] init];
//        [writer writeToFile:self.fileURL info:&levelInfo_];
//        isModificationSaved_ = YES;
//        [self updateTitle];
//        [self updateSaveButtonState];
//    }

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

-(NSString*) getDialogText1OfRow:(NSInteger)rowIndex {
    return [self.eventSection getDialogText1OfLine:rowIndex];
}

-(NSString*) getDialogText2OfRow:(NSInteger)rowIndex {
    return [self.eventSection getDialogText2OfLine:rowIndex];
}

@end
