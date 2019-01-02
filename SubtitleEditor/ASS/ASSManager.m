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

@interface ASSManager()
@property (strong) ASSFileLoader *assFileLoader;
@property (strong) NSMutableArray* sections;
@property (strong) NSString* outputFileURL;
@end

@implementation ASSManager

-(id) init {
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
    NSString *assFilePath = [myBundle pathForResource:@"test1" ofType:@"ass"];
    NSLog(@"+++++++++ ass file path:%@", assFilePath);
    
    NSData* rawData = [NSData dataWithContentsOfFile:assFilePath];
    
    [self.assFileLoader loadFrowRawData:rawData sections:self.sections];
    for (int i = 0; i < self.sections.count; ++i) {
        [self.sections[i] parseLines];
    }
    
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


@end
