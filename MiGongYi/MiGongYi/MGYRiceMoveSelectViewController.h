//
//  MGYRiceMoveSelectViewController.h
//  MiGongYi
//
//  Created by megil on 11/10/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGYSubViewController.h"
#import "MGYStoryPlayer.h"

typedef void (^MGYRiceMoveSelectViewSelectCallback)(NSString *);
typedef void (^MGYRiceMoveSelectViewDidDisappearCallback)();

@interface MGYRiceMoveSelectViewController : MGYSubViewController

@property (nonatomic, weak) IBOutlet UIButton *leftButton;
@property (nonatomic, weak) IBOutlet UIButton *rightButton;

- (void)setCallback:(MGYStorySelectCallback)storySelectCallback
selectViewSelectCallback:(MGYRiceMoveSelectViewSelectCallback)selectViewSelectCallback
selectViewDidDisappearCallback:(MGYRiceMoveSelectViewDidDisappearCallback)selectViewDidDisappearCallback;

@end
