//
//  MGYRiceMoveEquipView.m
//  MiGongYi
//
//  Created by megil on 11/5/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceMoveEquipView.h"
#import "Masonry.h"

@interface MGYRiceMoveEquipView ()

@property (nonatomic, weak) UIImageView *tipsImageView;
@property (nonatomic, weak) UILabel *tipsLabel;
@property (nonatomic, weak) UIButton *confirmButton;

@end

@implementation MGYRiceMoveEquipView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 5;
        self.layer.borderColor = [UIColor blueColor].CGColor;
        UIImageView *tipsImageView = [UIImageView new];
        [self addSubview:tipsImageView];
        self.tipsImageView = tipsImageView;
        
        UILabel *tipsLabel = [UILabel new];
        tipsLabel.numberOfLines = 0;
        tipsLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:tipsLabel];
        self.tipsLabel = tipsLabel;
        
        UIButton *confirmButton = [UIButton new];
        confirmButton.backgroundColor = [UIColor orangeColor];
        [confirmButton setTitle:@"确定"
                       forState:UIControlStateNormal];
        [confirmButton setTitleColor:[UIColor whiteColor]
                            forState:UIControlStateNormal];
        [confirmButton addTarget:self
                          action:@selector(click:)
                forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:confirmButton];
        self.confirmButton = confirmButton;
        
        [tipsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.centerX.equalTo(self);
        }];
        
        [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tipsImageView.mas_bottom).with.offset(20);
            make.width.mas_equalTo(160);
            make.centerX.equalTo(self);
        }];
        
        [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).with.offset(-10);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(20);
            make.centerX.equalTo(self);
        }];
        
//        [tipsImageView setImage:[UIImage imageNamed:@"event1"]];
//        
//        tipsLabel.text = @"获得青丝软履，行动力能量翻倍，大郎迫不及待地迈开了脚。";
    }
    return self;
}

- (void)reset:(NSString *)imagePath
      content:(NSString *)content
{
    [self.tipsImageView setImage:[UIImage imageNamed:imagePath]];
    self.tipsLabel.text = content;
}

- (void)click:(id)sender
{
    self.hidden = YES;
}

//- (instancetype)initWithImage:(NSString *)imagePath
//                      content:(NSString *)content
//{
//    self = [self init];
//    if (self) {
//        UIImageView *tipsImageView
//    }
//    
//    return self;
//
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
