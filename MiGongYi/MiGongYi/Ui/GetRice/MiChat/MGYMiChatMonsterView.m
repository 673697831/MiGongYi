//
//  MGYMiChatMonsterView.m
//  MiGongYi
//
//  Created by megil on 10/14/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYMiChatMonsterView.h"
#import "Masonry.h"
#import "MGYMiChatMonsterTableViewCell.h"

@interface MGYMiChatMonsterView ()

@property(nonatomic, weak) UIImageView *monsterImageView;
@property(nonatomic, weak) UIImageView *ball1ImageView;
@property(nonatomic, weak) UIImageView *ball2ImageView;
@property(nonatomic, weak) UIImageView *ball3ImageView;
@property(nonatomic, weak) UIImageView *ball4ImageView;
@property(nonatomic, weak) UIImageView *ball5ImageView;
@property(nonatomic, weak) UIImageView *ball6ImageView;
@property(nonatomic, strong) NSArray *ballList;

@end

@implementation MGYMiChatMonsterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImageView *ball1ImageView = [UIImageView new];
        [self addSubview:ball1ImageView];
        self.ball1ImageView = ball1ImageView;
        
        UIImageView *ball2ImageView = [UIImageView new];
        [self addSubview:ball2ImageView];
        self.ball2ImageView = ball2ImageView;
        
        UIImageView *ball3ImageView = [UIImageView new];
        [self addSubview:ball3ImageView];
        self.ball3ImageView = ball3ImageView;
        
        UIImageView *ball4ImageView = [UIImageView new];
        [self addSubview:ball4ImageView];
        self.ball4ImageView = ball4ImageView;
        
        UIImageView *ball5ImageView = [UIImageView new];
        [self addSubview:ball5ImageView];
        self.ball5ImageView = ball5ImageView;
        
        UIImageView *ball6ImageView = [UIImageView new];
        [self addSubview:ball6ImageView];
        self.ball6ImageView =ball6ImageView;
        
        UIImageView *monsterImageView = [UIImageView new];
        [self addSubview:monsterImageView];
        self.monsterImageView = monsterImageView;
        
        [monsterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(268/2);
            make.right.equalTo(self).with.offset(-218/2);
            make.bottom.equalTo(self).with.offset(-62/2);
        }];
        
        [ball1ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(18);
            make.bottom.equalTo(self).with.offset(-78/2);
        }];
        
        [ball2ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ball1ImageView.mas_right).with.offset(10);
            make.bottom.equalTo(ball1ImageView);
        }];
        
        [ball3ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ball2ImageView.mas_right).with.offset(10);
            make.bottom.equalTo(ball2ImageView);
        }];
        
        [ball4ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.monsterImageView.mas_right).with.offset(-10);
            make.bottom.equalTo(ball1ImageView);
        }];
        
        [ball5ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ball4ImageView.mas_right).with.offset(10);
            make.bottom.equalTo(ball4ImageView);
        }];
        
        [ball6ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ball5ImageView.mas_right).with.offset(10);
            make.bottom.equalTo(ball5ImageView);
        }];
        
        self.ballList = @[ball1ImageView, ball2ImageView, ball3ImageView, ball4ImageView, ball5ImageView, ball6ImageView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)resetMonsterState:(NSArray *)array
{
    if ([array[6] integerValue] == MGYMiChatMonsterStateGray) {
        [self.monsterImageView setImage:[UIImage imageNamed:@"michatmonster2"]];
    }else
    {
        [self.monsterImageView setImage:[UIImage imageNamed:@"michatmonster"]];
    }
    
    for (int i = 0; i < 3; i ++) {
        UIImageView *imageView = self.ballList[i];
        if ([array[i] integerValue] == MGYMiChatMonsterStateGray) {
            [imageView setImage:[UIImage imageNamed:@"michatorange-gray-left"]];
        }else
        {
            [imageView setImage:[UIImage imageNamed:@"michatorange-left"]];
        }
    }
    
    for (int i = 3; i < array.count - 1; i ++) {
        UIImageView *imageView = self.ballList[i];
        if ([array[i] integerValue] == MGYMiChatMonsterStateGray) {
            [imageView setImage:[UIImage imageNamed:@"michatorange-gray-right"]];
        }else
        {
            [imageView setImage:[UIImage imageNamed:@"michatorange-right"]];
        }
    }
}

- (void)resetMonSterStateById:(NSInteger)index
                       statue:(MGYMiChatMonsterState)state
{
    UIImageView *imageView = self.ballList[index];
    if (index < 3) {
        if (state == MGYMiChatMonsterStateGray) {
            [imageView setImage:[UIImage imageNamed:@"michatorange-gray-left"]];
        }else
        {
            [imageView setImage:[UIImage imageNamed:@"michatorange-left"]];
        }
    }else
    {
        if (state == MGYMiChatMonsterStateGray) {
            [imageView setImage:[UIImage imageNamed:@"michatorange-gray-right"]];
        }else
        {
            [imageView setImage:[UIImage imageNamed:@"michatorange-right"]];
        }
    }
}

- (void)setFinished:(BOOL)isFinished
{
    if (isFinished) {
        [self.monsterImageView setImage:[UIImage imageNamed:@"michatmonster"]];
    }else
    {
        [self.monsterImageView setImage:[UIImage imageNamed:@"michatmonster2"]];
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
