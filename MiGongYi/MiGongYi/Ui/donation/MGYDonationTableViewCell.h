//
//  MGYDonationTableViewCell.h
//  MiGongYi
//
//  Created by megil on 12/2/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGYDonationProgressView.h"
#import "MGYDonationCommentView.h"
#import "MGYProtocolMyDonate.h"

@protocol MGYDonationTableViewCellDelegate <NSObject>

- (void)openKeyBoard;

@end

@interface MGYDonationTableViewCell : UITableViewCell<MGYDonationCommentViewDelegate>

@property (nonatomic, weak) MGYDonationCommentView *commentView;

@property (nonatomic, weak) id<MGYDonationTableViewCellDelegate> donationCellDelegate;

//- (void)resetProgress:(CGFloat)progress;

- (void)reset:(MGYProtocolMyDonate *)donate;

- (void)resetComment:(NSArray *)arrayComment;

- (void)move;

+ (CGFloat)minHeight;

@end
