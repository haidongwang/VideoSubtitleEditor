//
//  StylesManager.m
//  SubtitleEditor
//
//  Created by ocean on 2019/1/6.
//  Copyright © 2019年 Ocean. All rights reserved.
//

#import "StylesManager.h"
#import "ASSDialogStyle.h"

@interface StylesManager()

@property (strong) NSMutableDictionary* stylesMap;

@end

@implementation StylesManager

+(id) sharedInstance {
    static StylesManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(id) init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    [self reset];
    
    return self;
}

-(void) reset {
    self.stylesMap = [NSMutableDictionary dictionary];
}

-(void) registerStyle:(ASSDialogStyle*)style {
    NSString* symbol = [self.stylesMap valueForKey:style.rawStyle];
    if (!symbol) {
        NSString* symbol = [NSString stringWithFormat:@"<S%ld>", self.stylesMap.count + 1];
        [self.stylesMap setValue:symbol forKey:style.rawStyle];
        style.symbol = symbol;
    } else {
        style.symbol = symbol;
    }
}

@end
