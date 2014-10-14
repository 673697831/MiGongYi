//
//  MGYMiZhiTableViewCell.m
//  MiGongYi
//
//  Created by megil on 9/29/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYMiZhiTableViewCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "MGYMiZhi.h"

@interface MGYMiZhiTableViewCell ()

@property(nonatomic, weak) UIImageView *dailyImgView;
@property(nonatomic, weak) UILabel *timerLabel;
@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UIButton *showContentButton;
@property(nonatomic, weak) UIButton *shareButton;
@property(nonatomic, weak) UIWebView *contentLable;
@property(nonatomic, strong) NSTimer *myTimer;
@property(nonatomic, strong) MGYMiZhi *miZhi;
@property(nonatomic, assign) CGFloat webViewHeight;
@property(nonatomic, assign) BOOL isLoadingFinished;

@end

@implementation MGYMiZhiTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.webViewHeight = 0;
        
        UIImageView *dailyImgView = [UIImageView new];
        [self addSubview:dailyImgView];
        self.dailyImgView = dailyImgView;
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:21];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UIWebView *contentLable = [UIWebView new];
        contentLable.tintColor = [UIColor blueColor];
        contentLable.hidden = YES;
        contentLable.delegate = self;
        [contentLable setScalesPageToFit:NO];
        contentLable.scrollView.bounces = NO;
        contentLable.scrollView.scrollEnabled = NO;
        contentLable.scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:contentLable];
        self.contentLable = contentLable;
        
        UIButton *showContentButton = [UIButton new];
        showContentButton.tag = 0;
        [showContentButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        showContentButton.backgroundColor = [UIColor orangeColor];
        [self addSubview:showContentButton];
        self.showContentButton = showContentButton;
        
        UIButton *shareButton = [UIButton new];
        shareButton.hidden = YES;
        shareButton.backgroundColor = [UIColor orangeColor];
        [self addSubview:shareButton];
        self.shareButton = shareButton;
        
        UILabel *timerLabel = [UILabel new];
        timerLabel.textAlignment  = NSTextAlignmentCenter;
        timerLabel.backgroundColor = [UIColor grayColor];
        timerLabel.alpha = 0.5;
        [self addSubview:timerLabel];
        self.timerLabel = timerLabel;
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                        target:self
                                                        selector:@selector(startTimer:)
                                                        userInfo:nil
                                                        repeats:YES];
        //[self.myTimer setFireDate:[NSDate distantPast]];
        [self setUp];
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)hideContent:(BOOL)isHide
{
    self.titleLabel.hidden = !isHide;
    self.showContentButton.hidden = !isHide;
    self.contentLable.hidden = isHide;
    self.shareButton.hidden = isHide;
}

- (void)clickButton:(id)sender
{
    [self.clickDelegate updateWebViewHeight:self.contentLable.bounds.size.height + 40 + self.bounds.size.width * 0.7 - self.bounds.size.height + self.shareButton.bounds.size.height];
    [self hideContent:NO];
}

- (void)setUp
{
    [self.dailyImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(self);
        make.height.mas_equalTo(self.bounds.size.width * 0.7);
    }];
    
    [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_equalTo(40);
        make.width.equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dailyImgView.mas_bottom).with.offset(40);
        make.centerX.equalTo(self);
    }];
    
    [self.showContentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(40);
        make.centerX.equalTo(self);
    }];
    
    [self.contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dailyImgView.mas_bottom).with.offset(40);
        make.centerX.equalTo(self);
        //make.height.mas_equalTo(300);
        make.width.mas_equalTo(552/2);
    }];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.centerX.equalTo(self);
    }];
    
}

- (void)startTimer:(NSTimer *)theTimer
{
    NSDate *confromTimesp = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:confromTimesp];
    NSInteger second = -[comps second];
    NSInteger minute = - [comps minute];
    NSInteger hour = 24 - [comps hour];
    if (second < 0) {
        minute = minute - 1;
        second = second + 60;
    }
    if (minute < 0) {
        hour = hour - 1;
        minute = minute + 60;
    }
    
    NSString *st1 = [NSString stringWithFormat:@"%d", hour];
    NSString *st2 = NSLocalizedString(@"时", @"米知时间显示");
    NSString *st3 = [NSString stringWithFormat:@"%d", minute];
    NSString *st4 = NSLocalizedString(@"分", @"米知时间显示");
    NSString *st5 = [NSString stringWithFormat:@"%d", second];
    NSString *st6 = NSLocalizedString(@"秒", @"米知时间显示");
    //NSLog(@"%d %d %d", st1.length, st2.length, st3.length);
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@%@%@%@", st1, st2, st3, st4, st5, st6]];
    NSInteger lengthCount = 0;
    
    [self addAttribute:str
                 color:[UIColor orangeColor]
              fontSize:21
                 start:lengthCount
                 limit:st1.length];
    
    lengthCount = lengthCount + st1.length;
    [self addAttribute:str
                 color:[UIColor whiteColor]
              fontSize:14
                 start:lengthCount
                 limit:st2.length];
    
    lengthCount = lengthCount + st2.length;
    [self addAttribute:str
                 color:[UIColor orangeColor]
              fontSize:21
                 start:lengthCount
                 limit:st3.length];
    
    lengthCount = lengthCount + st3.length;
    [self addAttribute:str
                 color:[UIColor whiteColor]
              fontSize:14
                 start:lengthCount
                 limit:st4.length];
    
    lengthCount = lengthCount + st4.length;
    [self addAttribute:str
                 color:[UIColor orangeColor]
              fontSize:21
                 start:lengthCount
                 limit:st5.length];
    
    lengthCount = lengthCount + st5.length;
    [self addAttribute:str
                 color:[UIColor whiteColor]
              fontSize:14
                 start:lengthCount
                 limit:st6.length];
    
    self.timerLabel.attributedText = str;
}

- (void)addAttribute:(NSMutableAttributedString *)str
               color:(UIColor *)color
            fontSize:(NSInteger)fontSize
               start:(NSInteger)start
               limit:(NSInteger)limit
{
    [str addAttribute:NSForegroundColorAttributeName
                value:color
                range:NSMakeRange(start, limit)];
    [str addAttribute:NSFontAttributeName
                value:[UIFont systemFontOfSize:fontSize]
                range:NSMakeRange(start, limit)];
}

- (void)reset:(MGYMiZhi *)miZhi
{
    self.miZhi = miZhi;
    [self.dailyImgView sd_setImageWithURL:[NSURL URLWithString:miZhi.dailyImg]];
    self.titleLabel.text = miZhi.dailyTitle;
    [self.contentLable loadHTMLString:miZhi.content baseURL:nil];
    
}

#pragma mark - UIWebView delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    CGFloat height = [height_str floatValue];
    CGRect frame = webView.frame;
    frame.size.height = height;
    webView.frame = frame;
    
}

@end
