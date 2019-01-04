//
//  ASSDialogText.h
//  SubtitleEditor
//
//  Created by ocean on 2019/1/2.
//  Copyright © 2019年 Ocean. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASSDialogText : NSObject

-(id) initWithText:(NSString*)text;
-(NSString*) getOutputText;
-(BOOL) isEmpty;

@end
