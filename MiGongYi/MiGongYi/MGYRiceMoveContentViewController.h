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
typedef void (^MGYRiceMoveContentViewDidDisappearCallback)();

@interface MGYRiceMoveContentViewController : MGYSubViewController

- (instancetype)initWithSelectCallback:(MGYStorySelectCallback)selectCallback
             contentViewSelectCallback:(MGYRiceMoveContentViewSelectCallback)contentViewSelectCallback
       contentViewDidDisappearCallback:(MGYRiceMoveContentViewDidDisappearCallback)contentViewDidDisappearCallback;




@end
