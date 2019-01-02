//
//  ASSSection.h
//  SubtitleEditor
//
//  Created by ocean on 2018/12/26.
//  Copyright © 2018年 Ocean. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASSSection : NSObject {
    
}

@property (nonatomic, readwrite) NSString* sectionTitle;
@property (nonatomic, readwrite) NSMutableArray* sectionLines;

-(void) setTitle:(NSString*)title;
-(void) setLines:(NSMutableArray*)lines;
-(void) parseLines;
-(NSArray*) getOutputLines;

@end
