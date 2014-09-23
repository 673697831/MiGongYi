//
//  MGYProjectDevelopmentsTableViewCell.m
//  MiGongYi
//
//  Created by megil on 9/23/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYProjectDevelopmentsTableViewCell.h"
#import "UIColor+Expanded.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface MGYProjectDevelopmentsTableViewCell ()

@property(nonatomic, weak) UIImageView *coverImageView;
@property(nonatomic, weak) UILabel *timeLabel;
@property(nonatomic, weak) UILabel *lineLabel;
@property(nonatomic, weak) UILabel *summaryLabel;
@property(nonatomic, weak) UIButton *messageButton;
@property(nonatomic, weak) UIButton *readmoreButton;

@end

@implementation MGYProjectDevelopmentsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UIImageView *coverImageView = [UIImageView new];
        [self addSubview:coverImageView];
        self.coverImageView = coverImageView;
        
        UILabel *timeLabel = [UILabel new];
        timeLabel.font = [UIFont systemFontOfSize:12];
        timeLabel.textColor = [UIColor colorWithString:@"838383"];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UILabel *lineLabel = [UILabel new];
        lineLabel.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
        [self addSubview:lineLabel];
        self.lineLabel = lineLabel;
        
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(self.bounds.size.width * 0.7);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(28);
        make.centerX.equalTo(self);
        make.top.equalTo(self.coverImageView.mas_bottom);
    }];
    
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(552/2);
        make.height.mas_equalTo(1);
        make.centerX.equalTo(self);
        make.top.equalTo(self.timeLabel.mas_bottom);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)reset:(MGYProjectRecent *)projectRecent
{
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:projectRecent.coverImg]];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:projectRecent.showTime];
    NSLog(@"%@",confromTimesp);
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:confromTimesp];
    NSLog(@"%d%d%d", [comps year], [comps month], [comps day]);
    self.timeLabel.text = [NSString stringWithFormat:@"%d年%d月%d日", [comps year], [comps month], [comps day]];
}

@end
