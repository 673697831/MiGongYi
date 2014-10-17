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

@end

@implementation MGYMiChatMonsterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        for (int i=1; i<7; i++) {
            UIImageView* imageView = [UIImageView new];
            [self addSubview:imageView];
            [self setValue:imageView
                    forKey:[NSString stringWithFormat:@"ball%dImageView", i]];
        }
        
        UIImageView *monsterImageView = [UIImageView new];
        [self addSubview:monsterImageView];
        self.monsterImageView = monsterImageView;
        
        [monsterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(268/2);
            make.right.equalTo(self).with.offset(-218/2);
            make.bottom.equalTo(self).with.offset(-62/2);
        }];
        
        [_ball1ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(18);
            make.bottom.equalTo(self).with.offset(-78/2);
        }];
        
        [_ball2ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_ball1ImageView.mas_right).with.offset(10);
            make.bottom.equalTo(_ball1ImageView);
        }];
        
        [_ball3ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_ball2ImageView.mas_right).with.offset(10);
            make.bottom.equalTo(_ball2ImageView);
        }];
        
        [_ball4ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.monsterImageView.mas_right).with.offset(-10);
            make.bottom.equalTo(_ball1ImageView);
        }];
        
        [_ball5ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_ball4ImageView.mas_right).with.offset(10);
            make.bottom.equalTo(_ball4ImageView);
        }];
        
        [_ball6ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_ball5ImageView.mas_right).with.offset(10);
            make.bottom.equalTo(_ball5ImageView);
        }];
        
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
    
    for (int i = 1; i < 4; i ++) {
        UIImageView *imageView = [self valueForKey:[NSString stringWithFormat:@"ball%dImageView", i]];
        if ([array[i] integerValue] == MGYMiChatMonsterStateGray) {
            [imageView setImage:[UIImage imageNamed:@"michatorange-gray-left"]];
        }else
        {
            [imageView setImage:[UIImage imageNamed:@"michatorange-left"]];
        }
    }
    
    for (int i = 4; i < array.count; i ++) {
        UIImageView *imageView = [self valueForKey:[NSString stringWithFormat:@"ball%dImageView", i]];
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
    UIImageView *imageView = [self valueForKey:[NSString stringWithFormat:@"ball%dImageView", index]];
    if (index < 4) {
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
