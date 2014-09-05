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
#import <QuartzCore/QuartzCore.h>

@implementation ProgramListCell
@synthesize photoView;
@synthesize nameLabel;
@synthesize lineLabel1;
@synthesize lineLabel2;
@synthesize progressLabel;


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
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.photoView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.photoView];
        
        self.photoView.backgroundColor = [UIColor blueColor];
        [self.photoView setImage:nil];
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.text = @"虎子";
        self.nameLabel.textColor = [UIColor colorWithHexString:@"464646"];
        self.nameLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
        [self.contentView addSubview:self.nameLabel];
        
        self.lineLabel1 = [[UILabel alloc] init];
        self.lineLabel1.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        [self.contentView addSubview:self.lineLabel1];
        
        
        //[self createProgress:self.progressLabel Tag:0 Width:274/2];
        self.progressLabel = [[ProgressLabel alloc] initWithFrame:CGRectMake(0, 0, 137/4*3, 6) BackgroundFrame:CGRectMake(0, 0, 274/2, 6)];
        [self.contentView addSubview:self.progressLabel];
        
        self.miliView = [[UIImageView alloc] init];
        [self.miliView setImage:[UIImage imageNamed:@"page_Rice_normal"]];
        [self.contentView addSubview:self.miliView];
        
        
        
        
        self.lineLabel2 = [[UILabel alloc] init];
        [self.contentView addSubview:self.lineLabel2];
        self.lineLabel2.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
        
        self.miliNum = [[UILabel alloc] init];
        [self.contentView addSubview:self.miliNum];
        self.miliNum.textColor = [UIColor colorWithHexString:@"464646"];
        self.miliNum.text = @"24.57K";
        self.miliNum.font = [UIFont fontWithName:@"Helvetica" size:10];
        
        self.miliLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.miliLabel];
        self.miliLabel.textColor = [UIColor colorWithHexString:@"bababa"];
        self.miliLabel.text = @"捐赠米粒(粒)";
        self.miliLabel.font = [UIFont fontWithName:@"Helvetica" size:6];
        
        self.peopleView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.peopleView];
        [self.peopleView setImage:[UIImage imageNamed:@"page_Participant_normal"]];
        
        self.peopleNum = [[UILabel alloc] init];
        [self.contentView addSubview:self.peopleNum];
        self.peopleNum.textColor = [UIColor colorWithHexString:@"464646"];
        self.peopleNum.text = @"256938";
        self.peopleNum.font = [UIFont fontWithName:@"Helvetica" size:10];
        
        self.poppleLable = [[UILabel alloc] init];
        [self.contentView addSubview:self.poppleLable];
        self.poppleLable.textColor = [UIColor colorWithHexString:@"bababa"];
        self.poppleLable.text = @"参与人数(人)";
        self.poppleLable.font = [UIFont fontWithName:@"Helvetica" size:6];
        [self setup];
        // Initialization code
    }
    return self;
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
