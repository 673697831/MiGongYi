//
//  DetailsViewCell.m
//  MiGongYi
//
//  Created by megil on 9/5/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "DetailsViewCell.h"
#import "Masonry.h"
#import "UIColor+Expanded.h"
#import "UIImageView+WebCache.h"


@implementation DetailsViewCell
@synthesize photoView;
@synthesize title;
@synthesize progressLabel;
@synthesize detailsIconLeft;
@synthesize detailsIconMiddle;
@synthesize detailsIconRight;
@synthesize line1;
@synthesize line2;
@synthesize buttomLabel;
- (void)setup
{
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.left.equalTo(self.contentView.mas_left);
        make.height.mas_equalTo(448/2);
    }];
    
    CGFloat topOffset = 4;
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.photoView.mas_bottom).with.offset(topOffset);
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    
    [self.progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).with.offset(topOffset);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(552/2);
        make.height.mas_equalTo(20/2);
    }];
    
    [self.detailsIconLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressLabel.mas_bottom).with.offset(topOffset);
        make.left.equalTo(self.progressLabel.mas_left);
        make.width.mas_equalTo(552/2/3);
        make.height.mas_equalTo(120);
    }];
    
    [self.detailsIconMiddle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressLabel.mas_bottom).with.offset(topOffset);
        make.centerX.equalTo(self.progressLabel.mas_centerX);
        make.width.mas_equalTo(552/2/3);
        make.height.mas_equalTo(120);
    }];
    
    [self.detailsIconRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressLabel.mas_bottom).with.offset(topOffset);
        make.right.equalTo(self.progressLabel.mas_right);
        make.width.mas_equalTo(552/2/3);
        make.height.mas_equalTo(120);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressLabel.mas_bottom).with.offset(6);
        make.left.equalTo(self.progressLabel.mas_left).with.offset(552/2/3);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(96/2);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressLabel.mas_bottom).with.offset(6);
        make.left.equalTo(self.progressLabel.mas_left).with.offset(552/2/3*2);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(96/2);
    }];
    
    [self.buttomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(25);
    }];
    
    [self.finishLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.photoView.mas_centerX);
        make.centerY.equalTo(self.photoView.mas_centerY);
    }];
    
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.photoView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.photoView];

        self.finishLabel = [[UILabel alloc] init];
        [self.photoView addSubview:self.finishLabel];
        self.finishLabel.text = @"捐赠已完成";
        self.finishLabel.textColor = [UIColor whiteColor];
        
        CATextLayer *subLayer = [CATextLayer layer];
        [self.finishLabel.layer insertSublayer:subLayer atIndex:10];
        subLayer.frame = CGRectMake(-500, -9, 1000, 40);
        subLayer.opacity = 0.5;
        subLayer.backgroundColor = [UIColor grayColor].CGColor;
        self.finishLabel.hidden = YES;
    
        
        self.title = [[UILabel alloc] init];
        [self.contentView addSubview:self.title];
        self.title.text = @"一碗粮, 关爱一个流浪的生命";
        self.title.textColor = [UIColor colorWithHexString:@"464646"];
        self.title.font = [UIFont fontWithName:@"Helvetica" size:13];
        
        //self.progressLabel = [[ProgressLabel alloc] initWithFrame:CGRectMake(0, 0, 552/2/4, 10) BackgroundFrame:CGRectMake(0, 0, 552/2, 10)];
        self.progressLabel = [[ProgressLabel alloc] initWithFrame:CGRectMake(0, 0, 552/2, 10)];
        [self.contentView addSubview:self.progressLabel];
        
        self.detailsIconLeft = [[DetailsIcon alloc] initWithFrame:CGRectMake(0, 0, 552/2/3, 120) Args:[NSDictionary dictionaryWithObjectsAndKeys:@"355580", @"num", @"page_Rice_normal2", @"path", @"捐赠米粒", @"text", nil]];
        [self.contentView addSubview:self.detailsIconLeft];
        
        self.detailsIconMiddle = [[DetailsIcon alloc] initWithFrame:CGRectMake(0, 0, 552/2/3, 120) Args:[NSDictionary dictionaryWithObjectsAndKeys:@"355580", @"num", @"page_People_normal2", @"path", @"参与人数", @"text", nil]];
        [self.contentView addSubview:self.detailsIconMiddle];
        
        self.detailsIconRight = [[DetailsIcon alloc] initWithFrame:CGRectMake(0, 0, 552/2/3, 120) Args:[NSDictionary dictionaryWithObjectsAndKeys:@"355580", @"num", @"page_Fav_normal2", @"path", @"收藏次数", @"text", nil]];
        [self.contentView addSubview:self.detailsIconRight];
        
        self.line1 = [[UILabel alloc] init];
        [self.contentView addSubview:self.line1];
        self.line1.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        
        self.line2 = [[UILabel alloc] init];
        [self.contentView addSubview:self.line2];
        self.line2.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        
        self.buttomLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.buttomLabel];
        self.buttomLabel.backgroundColor = [UIColor colorWithHexString:@"ebebeb"];
        //tab3Nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"公益项目" image:[UIImage imageNamed:@"page_Fav_normal2"] tag:0];
        
        [self setup];
    }
    return self;
}

- (void)setDetails:(Project *)args
{
    self.title.text = args.title;
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:args.cover_img]];
    [self.progressLabel resetProgress:CGRectMake(0, 0, 552.0/2*args.progress/100, 10)];
    self.detailsIconLeft.numLabel.text = [NSString stringWithFormat:@"%d", args.rice_donate];
    self.detailsIconMiddle.numLabel.text = [NSString stringWithFormat:@"%d", args.join_member_num];
    self.detailsIconRight.numLabel.text = [NSString stringWithFormat:@"%d", args.fay_num];
    if (args.status == 0) {
        self.finishLabel.hidden = NO;
    }else
    {
        self.finishLabel.hidden = YES;
    }
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
