//
//  MGYDonationCommentView.h
//  MiGongYi
//
//  Created by megil on 12/3/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGYPortocolInstantnews.h"

@protocol MGYDonationCommentViewDelegate <NSObject>

- (void)finishMove;

@end

@interface MGYDonationCommentView : UIView<UIWebViewDelegate>

@property (nonatomic, weak) id<MGYDonationCommentViewDelegate> commentViewDelegate;

- (void)move;

- (void)reset:(NSArray *)arrayComment;

@end
