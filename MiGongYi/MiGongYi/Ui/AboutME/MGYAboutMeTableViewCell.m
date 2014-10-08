//
//  AboutMeTableViewCell.m
//  MiGongYi
//
//  Created by megil on 9/20/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYAboutMeTableViewCell.h"
#import "MGYBaseProgressView.h"
#import "Masonry.h"
#import "UIColor+Expanded.h"

@interface MGYAboutMeTableViewCell ()

@property(nonatomic, weak) UILabel *childLabel;
@property(nonatomic, weak) UILabel *nameLabel;
@property(nonatomic, weak) MGYBaseProgressView *backgroundView;
@property(nonatomic, weak) UIImageView *photoBackgroundView;
@property(nonatomic, weak) UIImageView *photoView;
@property(nonatomic, weak) UIImageView *editImageView;
@property(nonatomic, weak) UIImageView *settingImageView;
@property(nonatomic, weak) UILabel *countLabel;
@property(nonatomic, weak) UIButton *riceButton;
@property(nonatomic, weak) UIButton *friendButton;
@property(nonatomic, weak) UIButton *favButton;
@property(nonatomic, readonly) NSArray *listButton;

@end

@implementation MGYAboutMeTableViewCell

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
        make.top.equalTo(self.backgroundView.mas_bottom).with.offset(30);
        make.bottom.equalTo(self.mas_bottom).with.offset(-12);
    }];
    
    [self.friendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(55);
        make.bottom.equalTo(self.backgroundView);
    }];
    
    [self.riceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.friendButton.mas_left);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(55);
        make.bottom.equalTo(self.backgroundView);
    }];
    
    [self.favButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.friendButton.mas_right);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(55);
        make.bottom.equalTo(self.backgroundView);
    }];
    
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        MGYBaseProgressView *backgroundView = [MGYBaseProgressView new];
        backgroundView.backgroundColor = [UIColor clearColor];
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
        countLabel.text = @"0";
        countLabel.textColor = [UIColor colorWithHexString:@"838383"];
        countLabel.font = [UIFont systemFontOfSize:68/2];
        countLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:countLabel];
        self.countLabel = countLabel;
        
        UIButton *riceButton = [self buttonFactory:@"拥有米粒" normalImage:@"tab_rice_normal" selectedImage:@"tab_rice_selected" tag:0];
        self.riceButton = riceButton;
        [self addSubview:self.riceButton];
        
        UIButton *friendButton = [self buttonFactory:@"好友列表" normalImage:@"tab_friends_normal" selectedImage:@"tab_friends_selected" tag:1];
        self.friendButton = friendButton;
        [self addSubview:self.friendButton];
        
        UIButton *favButton = [self buttonFactory:@"收藏项目" normalImage:@"tabbar_ fav_normal" selectedImage:@"tabbar_ fav_selected" tag:2];
        self.favButton = favButton;
        [self addSubview:self.favButton];
        [UIImage imageNamed:@"tab_friends_selected"];
        _listButton = @[riceButton, friendButton, favButton];
        [self setup];
        [self selectButton:0];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (UIButton *)buttonFactory:(NSString *)title
                normalImage:(NSString *)normalImage
              selectedImage:(NSString *)selectedImage
                        tag:(NSInteger) tag
{
    UIButton *button = [UIButton new];
    [button setImage :[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected ];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"f16400"]forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:9];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0,30,15,0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(30,0,0,24)];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    
    return button;
}

- (void)clickButton:(id)sender
{
    [self selectButton:[sender tag]];
    [self.clickDelegate click:[sender tag]];
}

- (void)selectButton:(NSInteger)index
{
    for (UIButton *button in self.listButton) {
        if (index == button.tag) {
            button.backgroundColor = [UIColor whiteColor];
            button.selected = YES;
        }
        else
        {
            button.backgroundColor = [UIColor clearColor];
            button.selected = NO;
        }
    }
    
}

- (void)resetNum:(NSInteger)number
{
    self.countLabel.text = [NSString stringWithFormat:@"%d", number];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
