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
#import "MGYRiceBoxingDetailsHideView.h"
#import "DataManager.h"

static inline UILabel *labelFactory(){
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor colorWithHexString:@"FBA809"];
    return label;
}

@interface MGYRiceBoxingDetailsTableViewCell ()

@property (nonatomic, strong) MGYMonster *monster;
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
@property (nonatomic, weak) MGYRiceBoxingDetailsHideView *hideView;
@property (nonatomic, weak) UILabel *storyContentLabel;
@property (nonatomic, weak) UILabel *skillContentLabel;
@property (nonatomic, weak) UILabel *conditionLabel;
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
        [followButton addTarget:self
                         action:@selector(clickFollowButton)
               forControlEvents:UIControlEventTouchUpInside];
        [followButton setBackgroundImage:[UIImage imageNamed:@"follow_enable"]
                      forState:UIControlStateDisabled];
        [followButton setBackgroundImage:[UIImage imageNamed:@"follow_normal"]
                      forState:UIControlStateNormal];
        [followButton setBackgroundImage:[UIImage imageNamed:@"follow_selected"]
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
        
        UILabel *skillContentLabel = [UILabel new];
        skillContentLabel.numberOfLines = 0;
        skillContentLabel.font = [UIFont systemFontOfSize:14];
        skillContentLabel.textColor = [UIColor greenColor];
        [self addSubview:skillContentLabel];
        self.skillContentLabel = skillContentLabel;
        
        UILabel *conditionLabel = [UILabel new];
        conditionLabel.numberOfLines = 0;
        conditionLabel.font = [UIFont systemFontOfSize:14];
        conditionLabel.textColor = [UIColor redColor];
        [self addSubview:conditionLabel];
        self.conditionLabel = conditionLabel;
        
        UIView *lineView = [UIView new];
        lineView.hidden = YES;
        lineView.backgroundColor = [UIColor orangeColor];
        [self addSubview:lineView];
        self.lineView = lineView;
        
        MGYRiceBoxingDetailsHideView *hideView = [MGYRiceBoxingDetailsHideView new];
        [self addSubview:hideView];
        self.hideView = hideView;
        
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
        
        [self.skillContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bloodImageView);
            make.width.mas_equalTo(581.0/2);
            make.top.equalTo(self.storyContentLabel.mas_bottom);
        }];
        
        [self.conditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bloodImageView);
            make.width.mas_equalTo(581.0/2);
            make.top.equalTo(self.skillContentLabel.mas_bottom);
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self);
            make.centerX.equalTo(self);
            make.height.mas_equalTo(1 / [UIScreen mainScreen].scale);
            make.top.equalTo(self.mas_bottom);
        }];
        
        [self.hideView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.storyContentLabel);
            make.width.equalTo(self.storyContentLabel);
            make.height.mas_equalTo([self.hideView.class heightForView]);
        }];
        
    }
    return self;
}

- (void)setDetails:(MGYMonster *)monster
{
    self.monster = monster;
    
    if (monster.monsterStatus == MGYMonsterStatusLocked) {
        self.monsterImageView.image = [UIImage imageNamed:monster.gayImagePath];
    }else
    {
        self.monsterImageView.image = [UIImage imageNamed:monster.normalImagePath];
    }
    
    self.followButton.hidden = YES;
    self.skillContentLabel.text = @"";
    self.conditionLabel.text = @"";
    
    if (monster.monsterType == MGYMonsterTypeSmall) {
        self.followButton.hidden = NO;
        NSInteger fightTimes = monster.fightTimes <= 5 ? monster.fightTimes : 5;
        for (int i = 1; i <= fightTimes; i++) {
            UIImageView *imageView = [self valueForKey:[NSString stringWithFormat:@"tameImageView%d", i]];
            imageView.image = [UIImage imageNamed:@"kulou_highlight"];
        }
        
        for (int i = fightTimes + 1; i <= 5; i++) {
            UIImageView *imageView = [self valueForKey:[NSString stringWithFormat:@"tameImageView%d", i]];
            imageView.image = [UIImage imageNamed:@"kulou_normal"];
        }
        
        if (fightTimes >= 5) {
            self.followButton.enabled = YES;
        }else
        {
            self.followButton.enabled = NO;
        }
        
        if ([DataManager shareInstance].getRiceDataManager.getRiceBoxingFollowId == monster.monsterId) {
            self.followButton.selected = YES;
        }else
        {
            self.followButton.selected = NO;
        }
        
    }
    
    if (monster.monsterStatus == MGYMonsterStatusUnLocked) {
        self.monsterNameLabel.text = monster.monsterName;
        self.storyContentLabel.text = monster.storyContent;
        if(monster.skillContent && ![monster.skillContent isEqualToString:@""]){
            self.skillContentLabel.text = [NSString stringWithFormat:@"跟随技能:%@", monster.skillContent];
        }
        if(monster.condition && ![monster.condition isEqualToString:@""]){
            self.conditionLabel.text =[NSString stringWithFormat:@"特殊:%@", monster.condition];
        }
        self.bloodNumLabel.text = [NSString stringWithFormat:@"x %ld", (long)monster.maxHp];
        self.rateLabel.text = monster.rateContent;
        self.levelLabel.text = monster.levelContent;
        self.hideView.hidden = YES;
    }else
    {
        self.storyContentLabel.text = @"";
        NSString *string = @"未知";
        self.monsterNameLabel.text = string;
        self.bloodNumLabel.text = [NSString stringWithFormat:@"x %@", string];
        self.rateLabel.text = string;
        self.levelLabel.text = string;
        self.hideView.hidden = NO;
    }
    
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

- (void)clickFollowButton
{
    if (self.cellDelegate) {
        BOOL isSelected = self.followButton.isSelected ? YES:NO;
        [self.cellDelegate changeFollowMonster:self.monster
                              isSelectedStatus:isSelected];
    }
}

+ (CGFloat)minHeight
{
    return (31 + 64 + 500 + 109 + 47 + 38 + 35 + 32 + 36 + 27 + 1) / 2.0;
}

+ (CGFloat)hideHeight
{
    return [MGYRiceBoxingDetailsTableViewCell minHeight] + [MGYRiceBoxingDetailsHideView heightForView];
}

@end
