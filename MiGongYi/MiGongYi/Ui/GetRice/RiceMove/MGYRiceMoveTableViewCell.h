//
//  MGYRiceMoveTableViewCell.h
//  MiGongYi
//
//  Created by megil on 11/17/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGYRiceMoveContentViewController.h"
#import "UIColor+Expanded.h"
#import "Masonry.h"
#import "MGYStoryPlayer.h"

@protocol MGYRiceMoveTableViewCellDelegate <NSObject>

- (void)disappearFromClickButton;
- (void)selectBranch:(MGYStoryBranch *)branch;

@end

@interface MGYRiceMoveTableViewCell : UITableViewCell

@property (nonatomic, weak) UIImageView *mapImageView;
@property (nonatomic, weak) UIImageView *bookImageView;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UILabel *getRiceLabel;
@property (nonatomic, weak) UILabel *riceLabel;
@property (nonatomic, weak) UILabel *conditionLabel;
@property (nonatomic, weak) UIImageView *conditionImageView;
@property(nonatomic, weak) id<MGYRiceMoveTableViewCellDelegate> cellDelegate;

- (void)reset;

+ (CGFloat)minHeight;

@end
