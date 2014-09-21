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
@property(nonatomic, weak) UIButton *riceButton;
@property(nonatomic, weak) UIButton *friendButton;
@property(nonatomic, weak) UIButton *favButton;
@property(nonatomic, readonly) NSArray *listButton;

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
        //countLabel.text
        countLabel.textColor = [UIColor colorWithHexString:@"838383"];
        countLabel.font = [UIFont systemFontOfSize:68/2];
        countLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:countLabel];
        self.countLabel = countLabel;
        
       // UIButton *button = [UIButton new];
        //[self addSubview:button];
        self.riceButton = [self buttonFactory:@"拥有米粒" normalImage:@"tab_rice_normal" selectedImage:@"tab_rice_selected" tag:0];
        [self addSubview:self.riceButton];
        
        self.friendButton = [self buttonFactory:@"好友列表" normalImage:@"tab_friends_normal" selectedImage:@"tab_friends_selected" tag:1];
        [self addSubview:self.friendButton];
        
        self.favButton = [self buttonFactory:@"收藏项目" normalImage:@"tabbar_ fav_normal" selectedImage:@"tabbar_ fav_selected" tag:2];
        [self addSubview:self.favButton];
        [UIImage imageNamed:@"tab_friends_selected"];
//        [button bringSubviewToFront:button.titleLabel];
//        [button setImage :[UIImage imageNamed:@"tabbar_ fav_normal"] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:@"tabbar_ fav_selected"] forState:UIControlStateSelected ];
//        [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
//        button.selected = YES;
//        CGFloat width = button.imageView.bounds.size.width;
//        UIImage *imaged = [UIImage imageNamed:@"tabbar_ fav_selected"];
//        NSLog(@"width ==%f", imaged.size.width);
//        [button setTitle:@"收藏项目" forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor blueColor]forState:UIControlStateSelected];
//        button.titleLabel.font = [UIFont systemFontOfSize:9];
//        //button.contentVerticalAlignment = UIViewContentModeRight;
//        [button setImageEdgeInsets:UIEdgeInsetsMake(0,30,15,0)];
//        [button setTitleEdgeInsets:UIEdgeInsetsMake(30,0,0,24)];
        //[button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        //[button setContentVerticalAlignment:UIConvertica];
        //button.tintColor = [UIColor colorWithHexString:@"f16400"];
        //button.t
        _listButton = @[self.riceButton, self.friendButton, self.favButton];
        [self setup];
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
    //button.contentVerticalAlignment = UIViewContentModeRight;
    [button setImageEdgeInsets:UIEdgeInsetsMake(0,30,15,0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(30,0,0,24)];
    [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    
    return button;
}

- (void)selectButton:(id)sender
{
    for (UIButton *button in self.listButton) {
        if ([sender tag] == button.tag) {
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
