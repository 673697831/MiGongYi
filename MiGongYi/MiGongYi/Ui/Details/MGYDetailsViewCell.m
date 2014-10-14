//
//  DetailsViewCell.m
//  MiGongYi
//
//  Created by megil on 9/5/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYDetailsViewCell.h"
#import "Masonry.h"
#import "UIColor+Expanded.h"
#import "UIImageView+WebCache.h"
#import "MGYProgressView.h"
#import "MGYDetailsIconListView.h"

@interface MGYDetailsViewCell ()
@property(nonatomic, weak) UIImageView *photoView;
@property(nonatomic, weak) UILabel *title;
@property(nonatomic, weak) MGYProgressView *progressLabel;
@property(nonatomic, weak) MGYDetailsIconListView *iconListView;
@property(nonatomic, weak) UIView *buttomView;
@property(nonatomic, weak) UILabel *finishLabel;
@end

@implementation MGYDetailsViewCell
- (void)setup
{
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.left.equalTo(self.contentView.mas_left);
        make.height.mas_equalTo(448/2);
    }];
    
    CGFloat topOffset = 4;
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.photoView.mas_bottom).with.offset(topOffset);
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    
    [self.progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).with.offset(topOffset);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(552/2);
        make.height.mas_equalTo(20/2);
    }];
    
    [self.iconListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressLabel.mas_bottom).with.offset(4);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(552/2);
        make.height.mas_equalTo(48);
    }];
    
    [self.buttomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(25);
    }];
    
    [self.finishLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.photoView.mas_centerX);
        make.centerY.equalTo(self.photoView.mas_centerY);
        make.width.equalTo(self.photoView);
        make.height.mas_equalTo(40);
//        make.centerY.equalTo(self.photoView.mas_centerY);
    }];
    
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *photoView = [UIImageView new];
        self.photoView = photoView;
        [self.contentView addSubview:self.photoView];
        
        UILabel *finishLabel = [UILabel new];
        self.finishLabel = finishLabel;
        [self.photoView addSubview:self.finishLabel];
        self.finishLabel.text = @"捐赠已完成";
        self.finishLabel.textColor = [UIColor whiteColor];
        self.finishLabel.backgroundColor = [UIColor grayColor];
        self.finishLabel.alpha = 0.5;
        finishLabel.textAlignment = NSTextAlignmentCenter;
        finishLabel.textColor = [UIColor whiteColor];
        self.finishLabel.hidden = YES;
    
        UILabel *title = [UILabel new];
        self.title = title;
        [self.contentView addSubview:self.title];
        self.title.text = @"一碗粮, 关爱一个流浪的生命";
        self.title.textColor = [UIColor colorWithHexString:@"464646"];
        self.title.font = [UIFont systemFontOfSize:13];
        
        MGYProgressView *progressLabel = [MGYProgressView new];
        self.progressLabel = progressLabel;
        progressLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.progressLabel];
        
        MGYDetailsIconListView *iconListView = [MGYDetailsIconListView new];
        [self addSubview:iconListView];
        self.iconListView = iconListView;
        
        UIView *buttomView = [UIView new];
        self.buttomView = buttomView;
        [self.contentView addSubview:self.buttomView];
        self.buttomView.backgroundColor = [UIColor colorWithHexString:@"ebebeb"];
        
        [self setup];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)reset:(MGYProject *)args
{
    self.title.text = args.title;
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:args.coverImg]];
    [self.progressLabel resetProgress:args.progress];
    [self.iconListView reset:args.riceDonate joinNum:args.joinMemberNum favNum:args.favNum];
    
    if (args.status == MGYProjectStatusFinished) {
        self.finishLabel.hidden = NO;
    }else
    {
        self.finishLabel.hidden = YES;
    }
    [self layoutIfNeeded];
}


@end
