//
//  MGYRiceMoveContentViewController.h
//  MiGongYi
//
//  Created by megil on 11/4/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGYSubViewController.h"
#import "MGYStory.h"
#import "MGYStoryPlayer.h"

typedef void (^MGYRiceMoveContentViewSelectCallback)(NSString *);
typedef void (^MGYRiceMoveContentViewTipsCallback)();

@interface MGYRiceMoveContentViewController : MGYSubViewController

- (instancetype)initWithNode:(MGYStoryNode *)node
              selectCallback:(MGYStorySelectCallback)selectCallback
          viewSelectCallback:(MGYRiceMoveContentViewSelectCallback)viewSelectCallback
                tipsCallback:(MGYRiceMoveContentViewTipsCallback)tipsCallback;

@end
