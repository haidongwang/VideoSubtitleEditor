//
//  ASSFileLoader.h
//  SubtitleEditor
//
//  Created by ocean on 2018/12/26.
//  Copyright © 2018年 Ocean. All rights reserved.
//

#ifndef ASSFileLoader_h
#define ASSFileLoader_h
#import <Foundation/Foundation.h>

@interface ASSFileLoader : NSObject {
    
}

-(void) loadFrowRawData:(NSData*)data sections:(NSMutableArray*)sections;

@end

#endif /* ASSFileLoader_h */
