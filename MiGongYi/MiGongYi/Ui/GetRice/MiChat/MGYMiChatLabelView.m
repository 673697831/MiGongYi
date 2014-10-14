//
//  MGYMiChatButtonView.m
//  MiGongYi
//
//  Created by megil on 9/30/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYMiChatLabelView.h"
#import "Masonry.h"
#import "UIColor+Expanded.h"
#import "DataManager.h"

@interface MGYMiChatLabelView ()

@property(nonatomic, weak) UIImageView *addImageView;
@property(nonatomic, weak) UIImageView *nextImageView;
@property(nonatomic, weak) UIImageView *warningImageView;
@property(nonatomic, weak) UILabel *nameLabel;
@property(nonatomic, weak) UIImageView *backImageView;
@property(nonatomic, weak) UILabel *timeLabel;
@property(nonatomic, weak) UILabel *deleteLabel;
@property(nonatomic ,weak) UIView *whiteView1;
@property(nonatomic, weak) UIView *whiteView2;
@property(nonatomic, weak) MGYMiChatProgressView *miChatProgressView;
@property(nonatomic, weak) UIView *leftView;
@property(nonatomic, weak) UIImageView *rightView;
@property(nonatomic, weak) UIView *subView1;
@property(nonatomic, weak) UIView *subView2;
@property(nonatomic, weak) UIView *subView3;

@end

@implementation MGYMiChatLabelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIView *leftView = [UIView new];
        [self addSubview:leftView];
        self.leftView = leftView;
        
        UIImageView *rightView = [UIImageView new];
        [rightView setImage:[UIImage imageNamed:@"michatbluebar"]];
        [self addSubview:rightView];
        self.rightView = rightView;
        
        UIView *subView1 = [UIView new];
        //subView1.backgroundColor = [UIColor blackColor];
        [self addSubview:subView1];
        self.subView1 = subView1;
        
        UIView *subView2 = [UIView new];
        [self addSubview:subView2];
        self.subView2 = subView2;
        
        UIView *subView3 = [UIView new];
        [self addSubview:subView3];
        self.subView3 = subView3;
        
        MGYMiChatProgressView *miChatProgressView = [MGYMiChatProgressView new];
        [self addSubview:miChatProgressView];
        self.miChatProgressView = miChatProgressView;
        
        UIImageView *addImageView = [UIImageView new];
        [addImageView setImage:[UIImage imageNamed:@"michatplus"]];
        [self addSubview:addImageView];
        self.addImageView = addImageView;
        
        UIImageView *nextImageView = [UIImageView new];
        [nextImageView setImage:[UIImage imageNamed:@"michatjiantou1"]];
        [self addSubview:nextImageView];
        self.nextImageView = nextImageView;
        
        UIImageView *warningImageView = [UIImageView new];
        warningImageView.hidden = YES;
        [warningImageView setImage:[UIImage imageNamed:@"michatwarning"]];
        [self addSubview:warningImageView];
        self.warningImageView = warningImageView;
        
        UILabel *nameLabel = [UILabel new];
        nameLabel.textColor = [UIColor colorWithHexString:@"838383"];
        nameLabel.font = [UIFont systemFontOfSize:21];
        nameLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UIImageView *backImageView = [UIImageView new];
        [backImageView setImage:[UIImage imageNamed:@"michatleft arrow"]];
        [self addSubview:backImageView];
        self.backImageView = backImageView;
        
        UILabel *timeLabel = [UILabel new];
        timeLabel.textColor = [UIColor blackColor];
        timeLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UILabel *deleteLabel = [UILabel new];
        deleteLabel.textColor = [UIColor whiteColor];
        deleteLabel.font = [UIFont systemFontOfSize:18];
        deleteLabel.text = NSLocalizedString(@"删除", @"删除");
        [self addSubview:deleteLabel];
        self.deleteLabel = deleteLabel;
        
        UIView *whiteView1 = [UIView new];
        whiteView1.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiteView1];
        self.whiteView1 = whiteView1;
        
        UIView *whiteView2 = [UIView new];
        whiteView2.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiteView2];
        self.whiteView2 = whiteView2;
        
        
        [self setup];
    }
    return self;
}

- (void)setup
{
    
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self.mas_centerX);
    }];
    
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.top.equalTo(self);
        make.left.equalTo(self.mas_centerX);
        make.right.equalTo(self);
    }];
    
    [self.subView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self);
        make.centerY.equalTo(self);
        make.width.equalTo(self.rightView).with.multipliedBy(1.0/3);
        make.left.equalTo(self.rightView);
    }];
    
    [self.subView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.equalTo(self.rightView.mas_width).with.multipliedBy(1.0/3);
        make.left.equalTo(self.subView1);
    }];
    
    [self.subView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self);
        make.centerY.equalTo(self);
        make.width.equalTo(self.rightView.mas_width).with.multipliedBy(1.0/3);
        make.right.equalTo(self.rightView);
    }];
    
    [self.miChatProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(46);
        make.height.mas_equalTo(46);
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(10);
    }];
    
    [self.addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.leftView);
        make.centerY.equalTo(self.leftView);
    }];
    
    [self.nextImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_centerX).with.offset(-12);
    }];
    
    [self.warningImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_centerX).with.offset(-36);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftView);
        make.centerX.equalTo(self.leftView);
    }];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self.subView1);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self.rightView);
    }];
    
    [self.deleteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self.subView3);
    }];
    
    [self.whiteView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1/[UIScreen mainScreen].scale);
        make.height.mas_equalTo(41);
        make.centerY.equalTo(self);
        make.left.equalTo(self.subView1.mas_right);
    }];
    
    [self.whiteView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1/[UIScreen mainScreen].scale);
        make.height.mas_equalTo(41);
        make.centerY.equalTo(self);
        make.right.equalTo(self.subView3.mas_left);
    }];
    
}

- (void)reset:(MGYMiChatRecord *)miChatRecord
         type:(MGYMiChatProgressViewType)type
{
    self.nameLabel.text = miChatRecord.personName;
    self.warningImageView.hidden = ![DataManager shareInstance].canGainRiceFromMiChat || miChatRecord.completed || (miChatRecord.currentTimes < miChatRecord.totalTimes || miChatRecord.totalTimes == 0);
    
    if (miChatRecord.totalTimes > 0) {
        [self.miChatProgressView resetProgress:
         1.0 * miChatRecord.currentTimes / miChatRecord.totalTimes
                                          type:type];
        self.timeLabel.text = [self timeTips:miChatRecord.totalTimes];
        self.nextImageView.hidden = NO;
    }else
    {
        [self.miChatProgressView resetProgress:0 type:type];
        [self.miChatProgressView clearImage];
        self.nextImageView.hidden = YES;
    }
}

- (MGYMiChatPos)getTouchView:(CGPoint)point
{
    NSArray *viewArray = @[self.miChatProgressView, self.addImageView, self.nameLabel, self.warningImageView, self.nextImageView, self.subView1, self.subView3,];
    for (int i = 0; i < viewArray.count; i ++) {
        if ([[((UIView *)viewArray[i]).layer presentationLayer] hitTest:point]) {
            return i + 1;
        }
    }
    
    return 0;
}

- (NSString *)timeTips:(NSInteger)times
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@1] = NSLocalizedString(@"一周一次", @"一周一次");
    dic[@2] = NSLocalizedString(@"一周两次", @"一周两次");
    dic[@3] = NSLocalizedString(@"一周三次", @"一周三次");
    dic[@4] = NSLocalizedString(@"一周四次", @"一周四次");
    dic[@5] = NSLocalizedString(@"一周五次", @"一周五次");
    dic[@6] = NSLocalizedString(@"一周六次", @"一周六次");
    return dic[@(times)];
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
