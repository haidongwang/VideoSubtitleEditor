//
//  SEApplicationController.m
//  SubtitleEditor
//
//  Created by ocean on 2018/12/26.
//  Copyright © 2018年 Ocean. All rights reserved.
//

#import "SEApplicationController.h"
#import "SEMainWindowController.h"

@interface SEApplicationController() {
}
@property (strong) IBOutlet SEMainWindowController *mainWindowController;

@end

@implementation SEApplicationController

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Observe all windows closing so we can remove them from our array.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowClosed:) name:NSWindowWillCloseNotification object:nil];
}

- (void)windowClosed:(NSNotification *)note {
}

@end
