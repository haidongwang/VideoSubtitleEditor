//
//  ASSDialogStyle.h
//  SubtitleEditor
//
//  Created by ocean on 2019/1/6.
//  Copyright © 2019年 Ocean. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASSDialogStyle : NSObject

@property (strong) NSString* rawStyle;
@property (strong) NSString* symbol;

-(id) initWithString:(NSString*)style;

-(NSString*) getOutputString;
-(NSString*) getDisplaystring;

@end
