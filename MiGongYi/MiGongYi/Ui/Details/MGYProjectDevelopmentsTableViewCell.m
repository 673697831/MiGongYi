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
@property(nonatomic, weak) UIView *lineView;
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
        timeLabel.textColor = [UIColor colorWithHexString:@"838383"];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UIView *lineView = [UILabel new];
        lineView.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
        [self addSubview:lineView];
        self.lineView = lineView;
        
        UILabel *summaryLabel = [UILabel new];
        summaryLabel.numberOfLines = 0;
        summaryLabel.font = [UIFont systemFontOfSize:13];
        summaryLabel.textColor = [UIColor colorWithHexString:@"838383"];
        [self addSubview:summaryLabel];
        self.summaryLabel = summaryLabel;
        
        UIButton *messageButton = [self buttonFactory];
        self.messageButton = messageButton;
        [self.messageButton setTitle:NSLocalizedString(@"进入聊天", @"进入聊天")
                            forState:UIControlStateNormal];
        [self addSubview:self.messageButton];
        
        UIButton *readmoreButton = [self buttonFactory];
        self.readmoreButton = readmoreButton;
        [self.readmoreButton setTitle:NSLocalizedString(@"阅读更多", @"阅读更多")
                             forState:UIControlStateNormal];
        [self addSubview:self.readmoreButton];
        
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(552/2);
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
        make.centerX.equalTo(self);
        make.top.equalTo(self.timeLabel.mas_bottom);
    }];
    
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.lineView.mas_width);
        make.top.equalTo(self.lineView.mas_bottom).with.offset(15);
        make.centerX.equalTo(self.lineView.mas_centerX);
    }];
    
    [self.messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(35);
        make.right.equalTo(self.mas_centerX).with.offset(-20);
        make.top.equalTo(self.summaryLabel.mas_bottom).with.offset(15);
    }];
    
    [self.readmoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(35);
        make.left.equalTo(self.mas_centerX).with.offset(20);
        make.top.equalTo(self.summaryLabel.mas_bottom).with.offset(15);
    }];
}

- (UIButton *)buttonFactory
{
    UIButton *messageButton = [UIButton new];
    messageButton.layer.borderWidth = 1;
    messageButton.layer.borderColor = [UIColor colorWithHexString:@"f16400"].CGColor;
    messageButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [messageButton setTitleColor:[UIColor colorWithHexString:@"f16400"]
                        forState:UIControlStateNormal];
    return messageButton;
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
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
//    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//    comps = [calendar components:unitFlags fromDate:confromTimesp];
    //self.timeLabel.text = [NSString stringWithFormat:@"%d年%d月%d日", [comps year], [comps month], [comps day]];
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy年MM月dd日";
    self.timeLabel.text = [fmt stringFromDate:confromTimesp];
    self.summaryLabel.text = projectRecent.summary;    
}

+ (CGFloat)minHeight
{
    CGFloat height = 0;
    height = height + 56/2 + 30/2 + 30/2 + 70/2 +30/2;
    return height;
}

@end
