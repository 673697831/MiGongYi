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
@property(nonatomic, weak) UILabel *line1;
@property(nonatomic, weak) UILabel *line2;
@property(nonatomic, weak) UILabel *buttomLabel;
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
        //make.left.equalTo(self.progressLabel.mas_left);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(552/2);
        make.height.mas_equalTo(48);
    }];
    
    [self.buttomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
        self.title.font = [UIFont fontWithName:@"Helvetica"
                                          size:13];
        
        MGYProgressView *progressLabel = [[MGYProgressView alloc] initWithFrame:CGRectMake(0, 0, 552/2, 10)];
        self.progressLabel = progressLabel;
        progressLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.progressLabel];
        
        
        MGYDetailsIconListView *iconListView = [[MGYDetailsIconListView alloc] initWithFrame:CGRectMake(0, 0, 552/2, 104/2)];
        //iconListView.backgroundColor = [UIColor orangeColor];
        [self addSubview:iconListView];
        self.iconListView = iconListView;
        
        UILabel *line1 = [UILabel new];
        self.line1 = line1;
        [self.contentView addSubview:self.line1];
        self.line1.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        
        UILabel *line2 = [UILabel new];
        self.line2 = line2;
        [self.contentView addSubview:self.line2];
        self.line2.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        
        UILabel *buttomLabel = [UILabel new];
        self.buttomLabel = buttomLabel;
        [self.contentView addSubview:self.buttomLabel];
        self.buttomLabel.backgroundColor = [UIColor colorWithHexString:@"ebebeb"];
        //tab3Nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"公益项目" image:[UIImage imageNamed:@"page_Fav_normal2"] tag:0];
        
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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
