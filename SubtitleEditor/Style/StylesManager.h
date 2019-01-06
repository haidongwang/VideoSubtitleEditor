//
//  StylesManager.h
//  SubtitleEditor
//
//  Created by ocean on 2019/1/6.
//  Copyright © 2019年 Ocean. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASSDialogStyle;
@interface StylesManager : NSObject

+(id) sharedInstance;
-(void) registerStyle:(ASSDialogStyle*)style;
-(void) reset;

@end
