//
//  MGYMiChatButtonView.m
//  MiGongYi
//
//  Created by megil on 9/30/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYMiChatLabelView.h"
#import "Masonry.h"
#import "MGYMiChatProgressView.h"
#import "UIColor+Expanded.h"

@interface MGYMiChatLabelView ()

@property(nonatomic, weak) UIImageView *addImageView;
@property(nonatomic, weak) UIImageView *nextImageView;
@property(nonatomic, weak) UIImageView *warningImageView;
@property(nonatomic, weak) UILabel *nameLabel;
@property(nonatomic, weak) UIImageView *backImageView;
@property(nonatomic, weak) UILabel *timeLabel;
@property(nonatomic, weak) UILabel *deleteLabel;
@property(nonatomic ,weak) UILabel *whiteLabel1;
@property(nonatomic, weak) UILabel *whiteLabel2;
@property(nonatomic, weak) MGYMiChatProgressView *miChatProgressView;
@property(nonatomic, weak) UIView *leftView;
@property(nonatomic, weak) UIImageView *rightView;
@property(nonatomic, weak) UIView *subView1;
@property(nonatomic, weak) UIView *subView2;
@property(nonatomic, weak) UIView *subView3;

@end

@implementation MGYMiChatLabelView

- (void)resetProgress:(CGFloat)progress
{
    [self.miChatProgressView resetProgress:progress];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
//        UILabel *label1 = [UILabel new];
//        //label1.backgroundColor = [UIColor grayColor];
//        label1.layer.cornerRadius = 10;
//        label1.layer.backgroundColor = [UIColor grayColor].CGColor;
//        [self addSubview:label1];
//        self.label1 = label1;
//        
//        UILabel *label2 = [UILabel new];
//        //label1.backgroundColor = [UIColor grayColor];
//        label2.layer.cornerRadius = 10;
//        label2.layer.backgroundColor = [UIColor orangeColor].CGColor;
//        [self addSubview:label2];
//        self.label2 = label2;
//        
//        UIImageView *imageView1 = [UIImageView new];
//        [imageView1 setImage:[UIImage imageNamed:@"michatlittlemonster1-gray"]];
//        [self addSubview:imageView1];
//        self.imageView1 = imageView1;
//        
//        UIImageView *imageView2 = [UIImageView new];
//        [imageView2 setImage:[UIImage imageNamed:@"michatlittlemonster1"]];
//        [self addSubview:imageView2];
//        self.imageView2 = imageView2;
        
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
        
        MGYMiChatProgressView *miChatProgressView = [[MGYMiChatProgressView alloc] initWithImage:@"michatlittlemonster1-gray" progressImageName:@"michatlittlemonster1"];
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
        timeLabel.textColor = [UIColor whiteColor];
        timeLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UILabel *deleteLabel = [UILabel new];
        deleteLabel.textColor = [UIColor whiteColor];
        deleteLabel.font = [UIFont systemFontOfSize:18];
        deleteLabel.text = @"删除";
        [self addSubview:deleteLabel];
        self.deleteLabel = deleteLabel;
        
        UILabel *whiteLabel1 = [UILabel new];
        whiteLabel1.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiteLabel1];
        self.whiteLabel1 = whiteLabel1;
        
        UILabel *whiteLabel2 = [UILabel new];
        whiteLabel2.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiteLabel2];
        self.whiteLabel2 = whiteLabel2;
        
        
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
    
//    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(46);
//        make.height.mas_equalTo(46);
//        make.centerY.equalTo(self);
//        make.left.equalTo(self).with.offset(10);
//    }];
//    
//    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.label1);
//    }];
//    
//    [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.label1);
//        make.centerY.equalTo(self.label1);
//    }];
//    
//    [self.imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.label1);
//        make.centerY.equalTo(self.label1);
//    }];
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
    
    [self.whiteLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(41);
        make.centerY.equalTo(self);
        make.left.equalTo(self.subView1.mas_right);
    }];
    
    [self.whiteLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(41);
        make.centerY.equalTo(self);
        make.right.equalTo(self.subView3.mas_left);
    }];
    
}

- (void)reset:(NSString *)peopleName
{
    self.nameLabel.text = peopleName;
}

- (MGYMiChatPos)getTouchView:(CGPoint)point state:(MGYMiChatCellState)state
{
    if (state == MGYMiChatStateCellRight) {
        point.x = point.x + CGRectGetWidth(self.bounds) / 2.0;
    }
    
    NSArray *viewArray = @[self.miChatProgressView, self.addImageView, self.nameLabel, self.warningImageView, self.nextImageView, self.subView1, self.subView3,];
    for (int i = 0; i < viewArray.count; i ++) {
        if ([[((UIView *)viewArray[i]).layer presentationLayer] hitTest:point]) {
            return i + 1;
        }
    }
    
    return 0;
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
