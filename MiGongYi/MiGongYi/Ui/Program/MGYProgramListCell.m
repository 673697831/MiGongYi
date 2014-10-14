//
//  ProgramListCell.m
//  MiGongYi
//
//  Created by megil on 9/4/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYProgramListCell.h"
#import "Masonry.h"
#import "UIColor+Expanded.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
#import "MGYProgressView.h"

@interface MGYProgramListCell ()
{
    
}

@property(nonatomic, weak) UIImageView* photoView;
@property(nonatomic, weak) UILabel *nameLabel;
@property(nonatomic, weak) UIView *lineView1;
@property(nonatomic, weak) UIView *lineView2;
@property(nonatomic, weak) MGYProgressView *progressLabel;
@property(nonatomic, weak) UIImageView *miliView;
@property(nonatomic, weak) UILabel *miliNum;
@property(nonatomic, weak) UILabel *miliLabel;
@property(nonatomic, weak) UIImageView *peopleView;
@property(nonatomic, weak) UILabel *peopleNum;
@property(nonatomic, weak) UILabel *poppleLable;
@property(nonatomic, assign) BOOL hasDrawn;
@property(nonatomic, weak) UILabel *finishLabel;
//@property(nonatomic, weak) UILabel *finishText;

@end

@implementation MGYProgramListCell
- (void)setup
{
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(self.contentView.frame.size.width);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.photoView.mas_bottom).with.offset(1);
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).with.offset(1);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
    }];
    
    [self.progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView1.mas_bottom).with.offset(2);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(274/2);
        make.height.mas_equalTo(6);
    }];

    [self.miliView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressLabel.mas_bottom).with.offset(4);
        make.left.equalTo(self.progressLabel.mas_left);
        
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(17);
        make.width.mas_equalTo(1/[UIScreen mainScreen].scale);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.progressLabel.mas_bottom).with.offset(4);
    }];
    
    [self.miliNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.miliView.mas_top);
        make.left.equalTo(self.miliView.mas_right).with.offset(2);
    }];
    
    [self.miliLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.miliNum.mas_bottom).with.offset(1);
        make.left.equalTo(self.miliNum.mas_left);
    }];
    
    [self.peopleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressLabel.mas_bottom).with.offset(4);
        make.left.equalTo(self.lineView2.mas_right).with.offset(1);
    }];
    
    [self.peopleNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.peopleView.mas_top);
        make.left.equalTo(self.peopleView.mas_right).with.offset(2);
    }];
    
    [self.poppleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.peopleNum.mas_bottom).with.offset(1);
        make.left.equalTo(self.peopleNum.mas_left);
    }];
    
    [self.finishLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.photoView.mas_centerX);
        make.centerY.equalTo(self.photoView.mas_centerY);
        make.width.equalTo(self.photoView.mas_width);
        make.height.mas_equalTo(40);
    }];
}

- (void)drwaCell
{
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *photoView = [UIImageView new];
    self.photoView = photoView;
    [self.contentView addSubview:self.photoView];

    UILabel *finishLabel = [UILabel new];
    self.finishLabel = finishLabel;
    [self.contentView addSubview:self.finishLabel];
    self.finishLabel.backgroundColor = [UIColor grayColor];
    self.finishLabel.alpha = 0.5;
    finishLabel.text = NSLocalizedString(@"捐赠已完成", @"捐赠已完成");
    finishLabel.textAlignment = NSTextAlignmentCenter;
    finishLabel.textColor = [UIColor whiteColor];
    self.finishLabel.hidden = YES;
    
    UILabel *nameLabel = [UILabel new];
    self.nameLabel = nameLabel;
    //self.nameLabel.text = @"虎子";
    self.nameLabel.textColor = [UIColor colorWithHexString:@"464646"];
    self.nameLabel.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:self.nameLabel];
    
    UIView *lineView1 = [UIView new];
    self.lineView1 = lineView1;
    self.lineView1.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    [self.contentView addSubview:self.lineView1];
    
    
    //[self createProgress:self.progressLabel Tag:0 Width:274/2];
    
    UIView *lineView2 = [UIView new];
    self.lineView2 = lineView2;
    [self.contentView addSubview:self.lineView2];
    self.lineView2.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    
    UILabel *miliNum = [UILabel new];
    self.miliNum = miliNum;
    [self.contentView addSubview:self.miliNum];
    self.miliNum.textColor = [UIColor colorWithHexString:@"464646"];
    //self.miliNum.text = @"24.57K";
    self.miliNum.font = [UIFont systemFontOfSize:10];
    
    UILabel *miliLabel = [UILabel new];
    self.miliLabel = miliLabel;
    [self.contentView addSubview:self.miliLabel];
    self.miliLabel.textColor = [UIColor colorWithHexString:@"bababa"];
    self.miliLabel.text = NSLocalizedString(@"捐赠米粒(粒)", @"捐赠米粒(粒)");
    self.miliLabel.font = [UIFont systemFontOfSize:6];
    
    UIImageView *peopleView = [UIImageView new];
    self.peopleView = peopleView;
    [self.contentView addSubview:self.peopleView];
    [self.peopleView setImage:[UIImage imageNamed:@"page_Participant_normal"]];
    
    UILabel *peopleNum = [UILabel new];
    self.peopleNum = peopleNum;
    [self.contentView addSubview:self.peopleNum];
    self.peopleNum.textColor = [UIColor colorWithHexString:@"464646"];
    //self.peopleNum.text = @"256938";
    self.peopleNum.font = [UIFont systemFontOfSize:10];
    
    UILabel *peopleLabel = [UILabel new];
    self.poppleLable = peopleLabel;
    [self.contentView addSubview:self.poppleLable];
    self.poppleLable.textColor = [UIColor colorWithHexString:@"bababa"];
    self.poppleLable.text = NSLocalizedString(@"参与人数(人)", @"参与人数(人)");
    self.poppleLable.font = [UIFont systemFontOfSize:6];
    
    UIImageView *miliView = [UIImageView new];
    self.miliView = miliView;
    [self.miliView setImage:[UIImage imageNamed:@"page_Rice_normal"]];
    [self.contentView addSubview:self.miliView];
    
    MGYProgressView *progressLabel = [[MGYProgressView alloc] initWithFrame:CGRectZero];
    self.progressLabel = progressLabel;
    progressLabel.backgroundColor = [UIColor clearColor];
    //progressLabel.layer.cornerRadius = 3;
    [self.contentView addSubview:progressLabel];
    [self setup];

}
-(void)reset:(MGYProject *)args
{
    
    if (!self.hasDrawn) {
        [self drwaCell];
        self.hasDrawn = YES;
    }
    
    [self.progressLabel resetProgress:args.progress];
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:args.coverImg]];
    self.nameLabel.text = args.title;
    self.miliNum.text = [NSString stringWithFormat:@"%d", args.riceDonate];
    self.peopleNum.text = [NSString stringWithFormat:@"%d", args.joinMemberNum];
    if (args.status == MGYProjectStatusFinished) {
        self.finishLabel.hidden = NO;
    }else
    {
        self.finishLabel.hidden = YES;
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
