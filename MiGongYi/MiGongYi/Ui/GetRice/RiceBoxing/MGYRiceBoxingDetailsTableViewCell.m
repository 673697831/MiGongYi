//
//  MGYRiceBoxingDetailsTableViewCell.m
//  MiGongYi
//
//  Created by megil on 11/15/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceBoxingDetailsTableViewCell.h"
#import "Masonry.h"
#import "UIColor+Expanded.h"

static inline UILabel *labelFactory(){
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor colorWithHexString:@"FBA809"];
    return label;
}

@interface MGYRiceBoxingDetailsTableViewCell ()

@property (nonatomic, weak) UILabel *monsterNameLabel;
@property (nonatomic, weak) UILabel *tameLabel;
@property (nonatomic, weak) UIImageView *tameImageView1;
@property (nonatomic, weak) UIImageView *tameImageView2;
@property (nonatomic, weak) UIImageView *tameImageView3;
@property (nonatomic, weak) UIImageView *tameImageView4;
@property (nonatomic, weak) UIImageView *tameImageView5;
@property (nonatomic, weak) UIButton *followButton;
@property (nonatomic, weak) UIImageView *monsterImageView;
@property (nonatomic, weak) UIImageView *manImageView;
@property (nonatomic, weak) UIImageView *bloodImageView;
@property (nonatomic, weak) UILabel *bloodNumLabel;
@property (nonatomic, weak) UIImageView *rateImageView;
@property (nonatomic, weak) UILabel *rateLabel;
@property (nonatomic, weak) UIImageView *levelImageView;
@property (nonatomic, weak) UILabel *levelLabel;
@property (nonatomic, weak) UIButton *anliButton;
@property (nonatomic, weak) UILabel *storyContentLabel;
@property (nonatomic, weak) UIView *lineView;

@end
@implementation MGYRiceBoxingDetailsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *monsterNameLabel = [UILabel new];
        monsterNameLabel.font = [UIFont systemFontOfSize:39.36/2];
        monsterNameLabel.textAlignment = NSTextAlignmentCenter;
        monsterNameLabel.textColor = [UIColor whiteColor];
        monsterNameLabel.backgroundColor = [UIColor orangeColor];
        [self addSubview:monsterNameLabel];
        self.monsterNameLabel = monsterNameLabel;
        
        UILabel *tameLabel = [UILabel new];
        tameLabel.font = [UIFont systemFontOfSize:24.06/2];
        tameLabel.textColor = [UIColor grayColor];
        tameLabel.text = @"驯服值";
        [self addSubview:tameLabel];
        self.tameLabel = tameLabel;
        
        for (int i = 1; i <= 5; i ++) {
            UIImageView *imageView = [UIImageView new];
            imageView.image = [UIImage imageNamed:@"kulou_normal"];
            //imageView.backgroundColor = [UIColor grayColor];
            [self addSubview:imageView];
            [self setValue:imageView
                    forKey:[NSString stringWithFormat:@"tameImageView%d", i]];
        }
        
        UIImageView *monsterImageView = [UIImageView new];
        monsterImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:monsterImageView];
        self.monsterImageView = monsterImageView;
        
        UIButton *followButton = [UIButton new];
        [followButton setBackgroundImage:[UIImage imageNamed:@"follow_enable"]
                      forState:UIControlStateDisabled];
        [followButton setTitle:@"跟随"
                      forState:UIControlStateDisabled];
        [followButton setBackgroundImage:[UIImage imageNamed:@"follow_normal"]
                      forState:UIControlStateNormal];
        [followButton setTitle:@"跟随"
                      forState:UIControlStateNormal];
        [followButton setBackgroundImage:[UIImage imageNamed:@"follow_selected"]
                      forState:UIControlStateSelected];
        [followButton setTitle:@"跟随中"
                      forState:UIControlStateSelected];
        
        [self addSubview:followButton];
        self.followButton = followButton;
        followButton.enabled = NO;
        
        UIImageView *manImageView = [UIImageView new];
        //manImageView.image = [UIImage imageNamed:@"man_dapei"];
        [self addSubview:manImageView];
        self.manImageView = manImageView;
        
        UIImageView *bloodImageView = [UIImageView new];
        bloodImageView.image = [UIImage imageNamed:@"blood_tujian"];
        [self addSubview:bloodImageView];
        self.bloodImageView = bloodImageView;
        
        UILabel *bloodNumLabel = labelFactory();
        [self addSubview:bloodNumLabel];
        self.bloodNumLabel = bloodNumLabel;
        
        UIImageView *rateImageView = [UIImageView new];
        rateImageView.image = [UIImage imageNamed:@"pinlv"];
        [self addSubview:rateImageView];
        self.rateImageView = rateImageView;
        
        UILabel *rateLabel = labelFactory();
        [self addSubview:rateLabel];
        self.rateLabel = rateLabel;
        
        UILabel *levelLabel = labelFactory();
        [self addSubview:levelLabel];
        self.levelLabel = levelLabel;
        
        UIImageView *levelImageView = [UIImageView new];
        levelImageView.image = [UIImage imageNamed:@"level"];
        [self addSubview:levelImageView];
        self.levelImageView = levelImageView;
        
        UIButton *anliButton = [UIButton new];
        anliButton.backgroundColor = [UIColor clearColor];
        [anliButton setBackgroundImage:[UIImage imageNamed:@"anli"]
                    forState:UIControlStateDisabled];
        [anliButton setTitle:@"案例"
                    forState:UIControlStateDisabled];
        [anliButton setTitleColor:[UIColor whiteColor]
                         forState:UIControlStateDisabled];
        anliButton.enabled = NO;
        [self addSubview:anliButton];
        self.anliButton = anliButton;
        
        UILabel *storyContentLabel = [UILabel new];
        storyContentLabel.numberOfLines = 0;
        storyContentLabel.font = [UIFont systemFontOfSize:14];
        storyContentLabel.textColor = [UIColor colorWithHexString:@"838383"];
        [self addSubview:storyContentLabel];
        self.storyContentLabel = storyContentLabel;
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = [UIColor orangeColor];
        [self addSubview:lineView];
        self.lineView = lineView;
        
        [self.monsterNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(581.0/2);
            make.height.mas_equalTo(64/2);
            make.centerX.equalTo(self);
            make.top.equalTo(self).with.offset(31.0/2);
        }];
        
        [self.tameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.monsterNameLabel.mas_bottom).with.offset(19/2.0);
        }];
        
        [self.tameImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.tameLabel.mas_bottom).with.offset(9.0/2);
        }];
        
        [self.tameImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.tameImageView3);
            make.width.equalTo(self.tameImageView3);
            make.centerY.equalTo(self.tameImageView3);
            make.right.equalTo(self.tameImageView3.mas_left).with.offset(-16/2);
        }];
        
        [self.tameImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.tameImageView3);
            make.width.equalTo(self.tameImageView3);
            make.centerY.equalTo(self.tameImageView3);
            make.right.equalTo(self.tameImageView2.mas_left).with.offset(-16/2);
        }];
        
        [self.tameImageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.tameImageView3);
            make.width.equalTo(self.tameImageView3);
            make.centerY.equalTo(self.tameImageView3);
            make.left.equalTo(self.tameImageView3.mas_right).with.offset(16/2);
        }];
        
        [self.tameImageView5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.tameImageView3);
            make.width.equalTo(self.tameImageView3);
            make.centerY.equalTo(self.tameImageView3);
            make.left.equalTo(self.tameImageView4.mas_right).with.offset(16/2);
        }];
        
        [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(44/2);
            make.bottom.equalTo(self.monsterNameLabel.mas_bottom).with.offset(500/2 + 109/2);
        }];
        
        [self.monsterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.followButton.mas_bottom);
            make.centerX.equalTo(self);
        }];
        
        [self.manImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).with.offset(-45.0/2);
            make.bottom.equalTo(self.monsterImageView);
        }];
        
        [self.bloodImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.monsterImageView.mas_bottom).with.offset(47.0/2);
            make.left.equalTo(self).with.offset(33.0/2);
        }];
        
        [self.bloodNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bloodImageView.mas_right).with.offset(5);
            make.centerY.equalTo(self.bloodImageView);
        }];
        
        [self.rateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_centerX).with.offset(-10);
            make.centerY.equalTo(self.bloodImageView);
        }];
        
        [self.rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.rateImageView.mas_right).with.offset(5);
            make.centerY.equalTo(self.bloodImageView);
        }];
        
        [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).with.offset(-40/2);
            make.centerY.equalTo(self.bloodImageView);
        }];
        
        [self.levelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.levelLabel.mas_left).with.offset(-5);
            make.centerY.equalTo(self.bloodImageView);
        }];
        
        [self.anliButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bloodImageView);
            make.top.equalTo(self.bloodImageView.mas_bottom).with.offset(35.0/2);
        }];
        
        [self.storyContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bloodImageView);
            make.width.mas_equalTo(581.0/2);
            make.top.equalTo(self.anliButton.mas_bottom).with.offset(36/2);
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self);
            make.centerX.equalTo(self);
            make.height.mas_equalTo(1 / [UIScreen mainScreen].scale);
            make.top.equalTo(self.storyContentLabel.mas_bottom).with.offset(27.0/2);
        }];
        
    }
    return self;
}

- (void)setDetails:(MGYMonster *)monster
{
    self.monsterNameLabel.text = monster.monsterName;
    self.monsterImageView.image = [UIImage imageNamed:monster.gayImagePath];
    self.bloodNumLabel.text = [NSString stringWithFormat:@"x %ld", (long)monster.maxHp];
    self.rateLabel.text = monster.rateContent;
    self.levelLabel.text = monster.levelContent;
    self.storyContentLabel.text = monster.storyContent;
    if (monster.monsterType == MGYMonsterTypeLarge) {
        self.manImageView.image = [UIImage imageNamed:@"man_dapei"];
    }else
    {
        self.manImageView.image = [UIImage imageNamed:@"man_xiaopei"];
    }
    
    BOOL hide = monster.monsterType == MGYMonsterTypeSmall ? NO : YES;
    self.tameLabel.hidden = hide;
    for (int i = 1; i <= 5; i ++) {
        UIImageView *imageView = [self valueForKey:[NSString stringWithFormat:@"tameImageView%d", i]];
        imageView.hidden = hide;
    }
    
}

+ (CGFloat)minHeight
{
    return (31 + 64 + 500 + 109 + 47 + 38 + 35 + 32 + 36 + 27 + 1) / 2.0;
}

@end
