//
//  MGYRiceBoxingMonsterProgressView.m
//  MiGongYi
//
//  Created by megil on 11/21/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceBoxingMonsterProgressView.h"
#import "Masonry.h"
#import "UIColor+Expanded.h"
#import "DataManager.h"

@interface MGYRiceBoxingMonsterProgressView ()

@property (nonatomic, weak) UIImageView *smallBall0;
@property (nonatomic, weak) UIImageView *smallBall1;
@property (nonatomic, weak) UIImageView *smallBall2;
@property (nonatomic, weak) UIImageView *middleBall0;
@property (nonatomic, weak) UIImageView *middleBall1;
@property (nonatomic, weak) UIImageView *bossImageView;
@property (nonatomic, weak) UIButton *bossButton;
@property (nonatomic, weak) UILabel *bossLabel;

@end

@implementation MGYRiceBoxingMonsterProgressView

- (instancetype)init
{
    self = [super init];
    if(self){
        for(int i = 0; i < 3; i++){
            UIImageView *imageView = [UIImageView new];
            [imageView setImage:[UIImage imageNamed:@"small_monster_tips_normal"]];
            [self addSubview:imageView];
            [self setValue:imageView
                    forKey:[NSString stringWithFormat:@"smallBall%d", i]];
        }
        
        for (int i = 0; i < 2; i++){
            UIImageView *imageView = [UIImageView new];
            [imageView setImage:[UIImage imageNamed:@"middle_monster_tips_normal"]];
            [self addSubview:imageView];
            [self setValue:imageView
                    forKey:[NSString stringWithFormat:@"middleBall%d", i]];
        }
        
//        UIImageView *bossImageView = [UIImageView new];
//        [bossImageView setImage:[UIImage imageNamed:@"fight_normal"]];
//        [self addSubview:bossImageView];
//        self.bossImageView = bossImageView;
//        
//        UILabel *bossLabel = [UILabel new];
//        bossLabel.text = @"Boss战";
//        bossLabel.font = [UIFont systemFontOfSize:11];
//        bossLabel.textColor = [UIColor whiteColor];
//        [self addSubview:bossLabel];
//        self.bossLabel = bossLabel;
        
        UIButton *bossButton = [UIButton new];
        bossButton.titleLabel.font = [UIFont systemFontOfSize:11];
        [bossButton setBackgroundImage:[UIImage imageNamed:@"fight_normal"]
                              forState:UIControlStateDisabled];
        [bossButton setTitle:@"Boss战"
                    forState:UIControlStateDisabled];
        
        [bossButton setBackgroundImage:[UIImage imageNamed:@"fight_hightlight"]
                              forState:UIControlStateNormal];
        [bossButton setTitle:@"Boss战"
                    forState:UIControlStateNormal];
        
        [bossButton addTarget:self
                       action:@selector(click)
             forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:bossButton];
        self.bossButton = bossButton;
        
        
        
        [self.smallBall0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(18);
            make.centerY.equalTo(self);
        }];
        
        [self.smallBall1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.smallBall0.mas_right).with.offset(18);
            make.centerY.equalTo(self);
        }];
        
        [self.smallBall2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.smallBall1.mas_right).with.offset(18);
            make.centerY.equalTo(self);
        }];
        
        [self.middleBall0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.smallBall2.mas_right).with.offset(18);
            make.centerY.equalTo(self);
        }];
        
        [self.middleBall1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.middleBall0.mas_right).with.offset(18);
            make.centerY.equalTo(self);
        }];
        
//        [self.bossImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self).with.offset(-18);
//            make.centerY.equalTo(self);
//            make.width.mas_equalTo(70);
//            make.height.mas_equalTo(32);
//        }];
//        
//        [self.bossLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.bossImageView);
//            make.centerY.equalTo(self.bossImageView);
//        }];
        
        [self.bossButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).with.offset(-18);
            make.centerY.equalTo(self);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(32);
        }];
        
        self.backgroundColor = [UIColor colorWithHexString:@"2e2f31"];
    }
    
    return self;
}

- (void)click
{
    if (self.progressViewDelegate) {
        [self.progressViewDelegate clickFightButton];
    }
    self.bossButton.enabled = NO;
}

- (void)reset
{
    NSInteger smallTimes = [[DataManager shareInstance].getRiceDataManager riceBoxingSmallTimes];
    NSInteger middleTimes = [[DataManager shareInstance].getRiceDataManager riceBoxingMiddleTimes];
    smallTimes = smallTimes < 3?smallTimes:3;
    middleTimes = middleTimes <2?middleTimes:2;
    
    for(int i = 0; i < smallTimes; i ++){
        UIImageView *imageView = [self valueForKey:[NSString stringWithFormat:@"smallBall%d", i]];
        imageView.image = [UIImage imageNamed:@"small_monster_tips_hightlight"];
    }
    
    for(int i = smallTimes; i < 3; i ++){
        UIImageView *imageView = [self valueForKey:[NSString stringWithFormat:@"smallBall%d", i]];
        imageView.image = [UIImage imageNamed:@"small_monster_tips_normal"];
    }
    
    for(int i = 0; i < middleTimes; i ++){
        UIImageView *imageView = [self valueForKey:[NSString stringWithFormat:@"middleBall%d", i]];
        imageView.image = [UIImage imageNamed:@"middle_monster_tips_hightlight"];
    }
    
    for(int i = middleTimes; i < 2; i ++){
        UIImageView *imageView = [self valueForKey:[NSString stringWithFormat:@"middleBall%d", i]];
        imageView.image = [UIImage imageNamed:@"middle_monster_tips_normal"];
    }
    
    if(smallTimes == 3 && middleTimes == 2)
    {
        self.bossButton.enabled = YES;
    }else
    {
        self.bossButton.enabled = NO;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end