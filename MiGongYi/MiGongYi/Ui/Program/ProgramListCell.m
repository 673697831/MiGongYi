//
//  ProgramListCell.m
//  MiGongYi
//
//  Created by megil on 9/4/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "ProgramListCell.h"
#import "Masonry.h"
#import "UIColor+Expanded.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
#import "MGYProgressView.h"

@interface ProgramListCell ()
{
    
}

@property(nonatomic, weak) UIImageView* photoView;
@property(nonatomic, weak) UILabel *nameLabel;
@property(nonatomic, weak) UILabel *lineLabel1;
@property(nonatomic, weak) UILabel *lineLabel2;
@property(nonatomic, weak) MGYProgressView *progressLabel;
@property(nonatomic, weak) UIImageView *miliView;
@property(nonatomic, weak) UILabel *miliNum;
@property(nonatomic, weak) UILabel *miliLabel;
@property(nonatomic, weak) UIImageView *peopleView;
@property(nonatomic, weak) UILabel *peopleNum;
@property(nonatomic, weak) UILabel *poppleLable;
@property(nonatomic, assign) BOOL hasDrawn;
@property(nonatomic, weak) UILabel *finishLabel;
@property(nonatomic, weak) UILabel *finishText;

@end

@implementation ProgramListCell
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
    
    [self.lineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).with.offset(1);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(1);
    }];
    
    [self.progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineLabel1.mas_bottom).with.offset(2);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(274/2);
        make.height.mas_equalTo(6);
    }];

    [self.miliView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressLabel.mas_bottom).with.offset(4);
        make.left.equalTo(self.progressLabel.mas_left);
        
    }];
    
    [self.lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(17);
        make.width.mas_equalTo(1);
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
        make.left.equalTo(self.lineLabel2.mas_right).with.offset(1);
    }];
    
    [self.peopleNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.peopleView.mas_top);
        make.left.equalTo(self.peopleView.mas_right).with.offset(2);
    }];
    
    [self.poppleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.peopleNum.mas_bottom).with.offset(1);
        make.left.equalTo(self.peopleNum.mas_left);
    }];
    
    [self.finishText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.photoView.mas_centerX);
        make.centerY.equalTo(self.photoView.mas_centerY);
    }];
    
    [self.finishLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.finishText.mas_centerX);
        make.centerY.equalTo(self.finishText.mas_centerY);
        make.width.equalTo(self.photoView.mas_width);
        make.height.mas_equalTo(40);
    }];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drwaCell
{
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *photoView = [UIImageView new];
    self.photoView = photoView;
    [self.contentView addSubview:self.photoView];
    
    
    
    UILabel *finishText = [UILabel new];
    self.finishText = finishText;
    [self.photoView addSubview:self.finishText];
    self.finishText.text = @"捐赠已完成";
    self.finishText.textColor = [UIColor whiteColor];

    UILabel *finishLabel = [UILabel new];
    self.finishLabel = finishLabel;
    [self.contentView addSubview:self.finishLabel];
    self.finishLabel.backgroundColor = [UIColor grayColor];
    self.finishLabel.alpha = 0.5;
    self.finishText.hidden = YES;
    self.finishLabel.hidden = YES;
    
    UILabel *nameLabel = [UILabel new];
    self.nameLabel = nameLabel;
    //self.nameLabel.text = @"虎子";
    self.nameLabel.textColor = [UIColor colorWithHexString:@"464646"];
    self.nameLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
    [self.contentView addSubview:self.nameLabel];
    
    UILabel *lineLabel1 = [UILabel new];
    self.lineLabel1 = lineLabel1;
    self.lineLabel1.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    [self.contentView addSubview:self.lineLabel1];
    
    
    //[self createProgress:self.progressLabel Tag:0 Width:274/2];
    
    UILabel *lineLabel2 = [UILabel new];
    self.lineLabel2 = lineLabel2;
    [self.contentView addSubview:self.lineLabel2];
    self.lineLabel2.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    
    UILabel *miliNum = [UILabel new];
    self.miliNum = miliNum;
    [self.contentView addSubview:self.miliNum];
    self.miliNum.textColor = [UIColor colorWithHexString:@"464646"];
    //self.miliNum.text = @"24.57K";
    self.miliNum.font = [UIFont fontWithName:@"Helvetica" size:10];
    
    UILabel *miliLabel = [UILabel new];
    self.miliLabel = miliLabel;
    [self.contentView addSubview:self.miliLabel];
    self.miliLabel.textColor = [UIColor colorWithHexString:@"bababa"];
    self.miliLabel.text = @"捐赠米粒(粒)";
    self.miliLabel.font = [UIFont fontWithName:@"Helvetica" size:6];
    
    UIImageView *peopleView = [UIImageView new];
    self.peopleView = peopleView;
    [self.contentView addSubview:self.peopleView];
    [self.peopleView setImage:[UIImage imageNamed:@"page_Participant_normal"]];
    
    UILabel *peopleNum = [UILabel new];
    self.peopleNum = peopleNum;
    [self.contentView addSubview:self.peopleNum];
    self.peopleNum.textColor = [UIColor colorWithHexString:@"464646"];
    //self.peopleNum.text = @"256938";
    self.peopleNum.font = [UIFont fontWithName:@"Helvetica" size:10];
    
    UILabel *peopleLabel = [UILabel new];
    self.poppleLable = peopleLabel;
    [self.contentView addSubview:self.poppleLable];
    self.poppleLable.textColor = [UIColor colorWithHexString:@"bababa"];
    self.poppleLable.text = @"参与人数(人)";
    self.poppleLable.font = [UIFont fontWithName:@"Helvetica" size:6];
    
    UIImageView *miliView = [UIImageView new];
    self.miliView = miliView;
    [self.miliView setImage:[UIImage imageNamed:@"page_Rice_normal"]];
    [self.contentView addSubview:self.miliView];
    
    //MGYProgressView *progressLabel = [[MGYProgressView alloc] initWithFrame:CGRectMake(0, 0, 274/2, 6)];
    //progressLabel.backgroundColor = [UIColor orangeColor];
    //progressLabel.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
   // progressLabel.layer.cornerRadius = 1;
    MGYProgressView *progressLabel = [[MGYProgressView alloc] initWithFrame:CGRectMake(0, 0, 274/2, 6)];
    self.progressLabel = progressLabel;
    progressLabel.backgroundColor = [UIColor clearColor];
    //progressLabel.layer.cornerRadius = 3;
    [self.contentView addSubview:progressLabel];
    [self setup];

}
-(void)update:(Project *)args
{
    
    if (!self.hasDrawn) {
        [self drwaCell];
        self.hasDrawn = YES;
    }
    
    [self.progressLabel updateProgress:args.progress];
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:args.coverImg]];
    self.nameLabel.text = args.title;
    self.miliNum.text = [NSString stringWithFormat:@"%d", args.riceDonate];
    self.peopleNum.text = [NSString stringWithFormat:@"%d", args.joinMemberNum];
    if (args.status == 0) {
        self.finishLabel.hidden = NO;
        self.finishText.hidden = NO;
    }else
    {
        self.finishLabel.hidden = YES;
        self.finishText.hidden = YES;
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
