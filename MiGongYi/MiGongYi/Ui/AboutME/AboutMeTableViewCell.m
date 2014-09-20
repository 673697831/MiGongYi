//
//  AboutMeTableViewCell.m
//  MiGongYi
//
//  Created by megil on 9/20/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "AboutMeTableViewCell.h"
#import "MGYBaseProgressView.h"
#import "Masonry.h"
#import "UIColor+Expanded.h"

@interface AboutMeTableViewCell ()

@property(nonatomic, weak) UILabel *childLabel;
@property(nonatomic, weak) UILabel *nameLabel;
@property(nonatomic, weak) MGYBaseProgressView *backgroundView;
@property(nonatomic, weak) UIImageView *photoBackgroundView;
@property(nonatomic, weak) UIImageView *photoView;
@property(nonatomic, weak) UIImageView *editImageView;
@property(nonatomic, weak) UIImageView *settingImageView;
@property(nonatomic, weak) UILabel *countLabel;

@end

@implementation AboutMeTableViewCell

- (void)setup
{
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom).with.offset(-134/2);
    }];
    
    [self.photoBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundView).with.offset(20);
        make.centerX.equalTo(self.backgroundView);
    }];
    
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.photoBackgroundView);
    }];
    
    [self.childLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundView);
        make.top.equalTo(self.photoBackgroundView.mas_bottom).with.offset(10);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundView);
        make.top.equalTo(self.childLabel.mas_bottom).with.offset(10);
    }];
    
    [self.settingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backgroundView.mas_right).with.offset(-13);
        make.top.equalTo(self.backgroundView.mas_top).with.offset(10);
    }];
    
    [self.editImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backgroundView.mas_right).with.offset(-172/2);
        make.top.equalTo(self.settingImageView.mas_top).with.offset(16);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(self);
        make.top.equalTo(self.backgroundView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        MGYBaseProgressView *backgroundView = [MGYBaseProgressView new];
        [self addSubview:backgroundView];
        self.backgroundView = backgroundView;
        
        UIImageView *photoBackgroundView = [UIImageView new];
        [photoBackgroundView setImage:[UIImage imageNamed:@"page_Photobackground_normal"]];
        [self addSubview:photoBackgroundView];
        self.photoBackgroundView = photoBackgroundView;
        
        UIImageView *photoView = [UIImageView new];
        [photoView setImage:[UIImage imageNamed:@"page_Photo_normal"]];
        [self addSubview:photoView];
        self.photoView = photoView;
        
        UILabel *childLabel = [UILabel new];
        [self addSubview:childLabel];
        childLabel.font = [UIFont systemFontOfSize:16];
        childLabel.text = @"米公益小天使";
        childLabel.textColor = [UIColor whiteColor];
        self.childLabel = childLabel;
        
        UILabel *nameLabel = [UILabel new];
        [self addSubview:nameLabel];
        nameLabel.text = @"mouji@ricedonate.com";
        nameLabel.font = [UIFont systemFontOfSize:11];
        nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel = nameLabel;
        
        UIImageView *editImageView = [UIImageView new];
        [self addSubview:editImageView];
        [editImageView setImage:[UIImage imageNamed:@"page_edit2_nomal"]];
        self.editImageView = editImageView;
        
        UIImageView *settingImageView = [UIImageView new];
        [self addSubview:settingImageView];
        [settingImageView setImage:[UIImage imageNamed:@"page_setting_nomal"]];
        self.settingImageView = settingImageView;
        
        UILabel *countLabel = [UILabel new];
        countLabel.text = @"8";
        countLabel.textColor = [UIColor colorWithHexString:@"838383"];
        countLabel.font = [UIFont systemFontOfSize:68/2];
        countLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:countLabel];
        self.countLabel = countLabel;
        
        [self setup];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
