//
//  MGYDonationTableViewCell.m
//  MiGongYi
//
//  Created by megil on 12/2/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYDonationTableViewCell.h"
#import "Masonry.h"
#import "UIColor+Expanded.h"

@interface MGYDonationTableViewCell ()

@property (nonatomic, weak) UILabel *levelLabel;
@property (nonatomic, weak) UILabel *riceDonateLabel;
@property (nonatomic, weak) UILabel *itemCountLabel;
@property (nonatomic, weak) UILabel *itemRiceDonateLabel;
@property (nonatomic, weak) UILabel *liLabel;
@property (nonatomic, weak) UILabel *deLabel;
@property (nonatomic, weak) UIButton *shareButton;
@property (nonatomic, weak) UILabel *donateLabel1;
@property (nonatomic, weak) UILabel *donateLabel2;
@property (nonatomic, weak) UILabel *scaleDonateNumLabel;
@property (nonatomic, weak) UILabel *yueLabel;
@property (nonatomic, weak) UIView *backgroundView1;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UILabel *readmoreLabel;
@property (nonatomic, weak) UIView *backgroundView2;
@property (nonatomic, weak) UILabel *joinNumLabel;
@property (nonatomic, weak) UILabel *joinNameLabel;
@property (nonatomic, weak) UILabel *donateNumLabel;
@property (nonatomic, weak) UILabel *donateNameLabel;
@property (nonatomic, weak) UILabel *itemProgressNumLabel;
@property (nonatomic, weak) UILabel *itemPorgressNameLabel;
@property (nonatomic, weak) UIView *backgroundView3;
@property (nonatomic, weak) UIButton *commentButton;
@property (nonatomic, weak) UIView *lineView1;
@property (nonatomic, weak) UIView *lineView2;

@property (nonatomic, weak) MGYDonationProgressView *progressView;
@property (nonatomic, weak) UIButton *donateButton;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) CGFloat curProgress;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger myRice;


@end

@implementation MGYDonationTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UILabel *levelLabel = [UILabel new];
        levelLabel.font = [UIFont systemFontOfSize:22/2];
        levelLabel.textColor = [UIColor colorWithHexString:@"BABABA"];
        levelLabel.text = @"LV:18";
        [self addSubview:levelLabel];
        self.levelLabel = levelLabel;
        
        UILabel *riceDonateLabel = [UILabel new];
        riceDonateLabel.font = [UIFont systemFontOfSize:9];
        riceDonateLabel.textColor = [UIColor colorWithHexString:@"BABABA"];
        riceDonateLabel.text = @"捐赠总米数:87878";
        [self addSubview:riceDonateLabel];
        self.riceDonateLabel = riceDonateLabel;
        
        UILabel *itemCountLabel = [UILabel new];
        itemCountLabel.font = [UIFont systemFontOfSize:9];
        itemCountLabel.textColor = [UIColor colorWithHexString:@"BABABA"];
        itemCountLabel.text = @"捐赠项目数:8";
        [self addSubview:itemCountLabel];
        self.itemCountLabel = itemCountLabel;
        
        UILabel *itemRiceDonateLabel = [UILabel new];
        itemRiceDonateLabel.font = [UIFont systemFontOfSize:24];
        itemRiceDonateLabel.textColor = [UIColor colorWithHexString:@"BABABA"];
        itemRiceDonateLabel.text = @"987";
        [self addSubview:itemRiceDonateLabel];
        self.itemRiceDonateLabel = itemRiceDonateLabel;
        
        UILabel *liLabel = [UILabel new];
        liLabel.font = [UIFont systemFontOfSize:8];
        liLabel.textColor = [UIColor colorWithHexString:@"BABABA"];
        liLabel.text = @"粒";
        [self addSubview:liLabel];
        self.liLabel = liLabel;
        
        UILabel *deLabel = [UILabel new];
        deLabel.font = [UIFont systemFontOfSize:8];
        deLabel.textColor = [UIColor colorWithHexString:@"676767"];
        deLabel.text = @"本项目贡献";
        [self addSubview:deLabel];
        self.deLabel = deLabel;
        
        MGYDonationProgressView *progressView = [MGYDonationProgressView new];
        [self addSubview:progressView];
        self.progressView = progressView;
        
        UIButton *donateButton = [UIButton new];
        [donateButton setImage:[UIImage imageNamed:@"donate_button_normal"] forState:UIControlStateNormal];
        [donateButton setImage:[UIImage imageNamed:@"donate_button_disable"] forState:UIControlStateHighlighted];
        [self addSubview:donateButton];
        self.donateButton = donateButton;
        
        UILabel *donateLabel1 = [UILabel new];
        donateLabel1.font = [UIFont systemFontOfSize:7];
        donateLabel1.textColor = [UIColor colorWithHexString:@"BABABA"];
        donateLabel1.text = @"当前米粒";
        [self addSubview:donateLabel1];
        self.donateLabel1 = donateLabel1;
        
        UILabel *donateLabel2 = [UILabel new];
        donateLabel2.font = [UIFont systemFontOfSize:9];
        donateLabel2.textColor = [UIColor colorWithHexString:@"676767"];
        donateLabel2.text = @"立即捐赠";
        [self addSubview:donateLabel2];
        self.donateLabel2 = donateLabel2;
        
        UILabel *scaleDonateNumLabel = [UILabel new];
        scaleDonateNumLabel.textAlignment = NSTextAlignmentCenter;
        scaleDonateNumLabel.font = [UIFont systemFontOfSize:26];
        scaleDonateNumLabel.textColor = [UIColor colorWithHexString:@"F37d18"];
        scaleDonateNumLabel.text = @"871";
        [self addSubview:scaleDonateNumLabel];
        self.scaleDonateNumLabel = scaleDonateNumLabel;
        
        // Do any additional setup after loading the view.
        
        UILabel *yueLabel = [UILabel new];
        yueLabel.font = [UIFont systemFontOfSize:9];
        yueLabel.textColor = [UIColor colorWithHexString:@"BABABA"];
        yueLabel.text = @"约一套文具";
        [self addSubview:yueLabel];
        self.yueLabel = yueLabel;
        
        UIView *backgroundView1 = [UIView new];
        backgroundView1.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
        [self addSubview:backgroundView1];
        self.backgroundView1 = backgroundView1;
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textColor = [UIColor colorWithHexString:@"676767"];
        titleLabel.text = @"为张刚小学的孩子们捐校服";
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *contentLabel = [UILabel new];
        contentLabel.numberOfLines = 0;
        contentLabel.font = [UIFont systemFontOfSize:9];
        contentLabel.textColor = [UIColor colorWithHexString:@"313131"];
        contentLabel.text = @"苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦苦";
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        UILabel *readmoreLabel = [UILabel new];
        readmoreLabel.font = [UIFont systemFontOfSize:9];
        readmoreLabel.textColor = [UIColor colorWithHexString:@"f16400"];
        readmoreLabel.text = @"阅读详情";
        [self addSubview:readmoreLabel];
        self.readmoreLabel = readmoreLabel;
        
        UIView *backgroundView2 = [UIView new];
        backgroundView2.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
        [self addSubview:backgroundView2];
        self.backgroundView2 = backgroundView2;
        
        UILabel *joinNumLabel = [UILabel new];
        joinNumLabel.font = [UIFont systemFontOfSize:20];
        joinNumLabel.textColor = [UIColor colorWithHexString:@"BABABA"];
        joinNumLabel.text = @"9870";
        [self addSubview:joinNumLabel];
        self.joinNumLabel = joinNumLabel;
        
        UILabel *joinNameLabel = [UILabel new];
        joinNameLabel.font = [UIFont systemFontOfSize:9];
        joinNameLabel.textColor = [UIColor colorWithHexString:@"676767"];
        joinNameLabel.text = @"参与人数";
        [self addSubview:joinNameLabel];
        self.joinNameLabel = joinNameLabel;
        
        UILabel *donateNumLabel = [UILabel new];
        donateNumLabel.font = [UIFont systemFontOfSize:20];
        donateNumLabel.textColor = [UIColor colorWithHexString:@"BABABA"];
        donateNumLabel.text = @"100000";
        [self addSubview:donateNumLabel];
        self.donateNumLabel = donateNumLabel;
        
        UILabel *donateNameLabel = [UILabel new];
        donateNameLabel.font = [UIFont systemFontOfSize:9];
        donateNameLabel.textColor = [UIColor colorWithHexString:@"676767"];
        donateNameLabel.text = @"捐赠目标";
        [self addSubview:donateNameLabel];
        self.donateNameLabel = donateNameLabel;
        
        UILabel *itemProgressNumLabel = [UILabel new];
        itemProgressNumLabel.font = [UIFont systemFontOfSize:20];
        itemProgressNumLabel.textColor = [UIColor colorWithHexString:@"BABABA"];
        itemProgressNumLabel.text = @"75%";
        [self addSubview:itemProgressNumLabel];
        self.itemProgressNumLabel = itemProgressNumLabel;
        
        UILabel *itemPorgressNameLabel = [UILabel new];
        itemPorgressNameLabel.font = [UIFont systemFontOfSize:9];
        itemPorgressNameLabel.textColor = [UIColor colorWithHexString:@"676767"];
        itemPorgressNameLabel.text = @"项目进度";
        [self addSubview:itemPorgressNameLabel];
        self.itemPorgressNameLabel = itemPorgressNameLabel;
        
        UIView *backgroundView3 = [UIView new];
        backgroundView3.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
        [self addSubview:backgroundView3];
        self.backgroundView3 = backgroundView3;
        
        UIButton *commentButton = [UIButton new];
        [commentButton addTarget:self
                          action:@selector(openKeyBoard)
                forControlEvents:UIControlEventTouchUpInside];
        commentButton.backgroundColor = [UIColor yellowColor];
        //commentButton.titleLabel.font = [UIFont systemFontOfSize:12];
        //commentButton.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [commentButton setTitleColor:[UIColor colorWithHexString:@"676767"]
                            forState:UIControlStateNormal];
        [commentButton setImage:[UIImage imageNamed:@"comment_button_normal"]
                       forState:UIControlStateNormal];
        [commentButton setImage:[UIImage imageNamed:@"comment_button_highlight"]
                       forState:UIControlStateHighlighted];
        
        [self addSubview:commentButton];
        self.commentButton = commentButton;
        
        [self addSubview:commentButton];
        self.commentButton = commentButton;
        
        MGYDonationCommentView *commentView = [MGYDonationCommentView new];
        [self addSubview:commentView];
        self.commentView = commentView;
        
        
        [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(36/2);
            make.top.equalTo(self.mas_top).with.offset(20);
        }];
        
        [self.riceDonateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.levelLabel.mas_right).with.offset(20);
            make.top.equalTo(self.levelLabel);
        }];
        
        [self.itemCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.riceDonateLabel.mas_right).with.offset(20);
            make.top.equalTo(self.riceDonateLabel);
        }];
        
        [self.itemRiceDonateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.levelLabel);
            make.top.equalTo(self.levelLabel.mas_bottom).with.offset(20);
        }];
        
        [self.liLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.itemRiceDonateLabel.mas_right);
            make.bottom.equalTo(self.itemRiceDonateLabel).with.offset(-5);
        }];
        
        [self.deLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.levelLabel);
            make.top.equalTo(self.itemRiceDonateLabel.mas_bottom).with.offset(7);
        }];
        
        [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(282/2);
            make.height.mas_equalTo(282/2);
            make.centerX.equalTo(self);
            make.top.equalTo(self.itemCountLabel.mas_bottom).with.offset(20);
        }];
        
        [self.donateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.progressView);
            make.centerY.equalTo(self.progressView);
        }];
        
        [self.donateLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.donateButton);
            make.bottom.equalTo(self.donateButton.mas_centerY).with.offset(-20);
        }];
        
        [self.donateLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.donateButton);
            make.top.equalTo(self.donateButton.mas_centerY).with.offset(10);
        }];
        
        [self.scaleDonateNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.progressView);
            make.centerX.equalTo(self.donateButton);
            make.centerY.equalTo(self.donateButton).with.offset(-5);
        }];
        
        [self.yueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.progressView.mas_bottom).with.offset(13);
        }];
        
        [self.backgroundView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self);
            make.height.mas_equalTo(15);
            make.centerX.equalTo(self);
            make.top.equalTo(self.yueLabel.mas_bottom).with.offset(13);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.backgroundView1.mas_bottom).with.offset(13);
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.mas_equalTo(320-68);
            make.top.equalTo(self.titleLabel.mas_bottom).with.offset(13);
        }];
        
        [self.readmoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentLabel);
            make.top.equalTo(self.contentLabel.mas_bottom);
        }];
        
        [self.backgroundView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.equalTo(self);
            make.height.mas_equalTo(15);
            make.top.equalTo(self.readmoreLabel.mas_bottom).with.offset(13);
        }];
        
        [self.joinNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentLabel);
            make.top.equalTo(self.backgroundView2.mas_bottom).with.offset(12);
        }];
        
        [self.joinNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.joinNumLabel);
            make.top.equalTo(self.joinNumLabel.mas_bottom).with.offset(10);
        }];
        
        [self.donateNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.backgroundView2.mas_bottom).with.offset(12);
        }];
        
        [self.donateNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.donateNumLabel.mas_bottom).with.offset(10);
        }];
        
        [self.itemProgressNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentLabel);
            make.top.equalTo(self.backgroundView2.mas_bottom).with.offset(12);
        }];
        
        [self.itemPorgressNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.itemProgressNumLabel);
            make.top.equalTo(self.itemProgressNumLabel.mas_bottom).with.offset(10);
        }];
        
        [self.backgroundView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.equalTo(self);
            make.height.mas_equalTo(15);
            make.top.equalTo(self.itemPorgressNameLabel.mas_bottom).with.offset(15);
        }];
        
        [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            //make.width.mas_equalTo(44);
            make.top.equalTo(self.backgroundView3.mas_bottom).with.offset(10);
        }];
    
        [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self);
            make.centerX.equalTo(self);
            make.top.equalTo(self.commentButton.mas_bottom);
            make.height.mas_equalTo(44 * 5);
        }];
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)openKeyBoard
{
    //[self.textView becomeFirstResponder];
    if(self.donationCellDelegate)
    {
        [self.donationCellDelegate openKeyBoard];
    }
    
}

- (void)resetProgress
{
    [self.scaleDonateNumLabel.layer removeAllAnimations];
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerProgress) userInfo:nil repeats:YES];
    self.curProgress = 0;
    self.donateLabel2.hidden = YES;
    self.donateLabel1.text = @"当前进度";
}

- (void)reset:(MGYProtocolMyDonate*)donate
{
    //[self.commentView reset:index];
    self.levelLabel.text = [NSString stringWithFormat:@"LV:%ld", (long)donate.userLevel];
    self.riceDonateLabel.text = [NSString stringWithFormat:@"捐赠总米数:%ld", (long)donate.riceTotal];
    self.itemCountLabel.text = [NSString stringWithFormat:@"捐赠项目数:%ld", (long)donate.myDonateProject];
    self.itemRiceDonateLabel.text = [NSString stringWithFormat:@"%ld", (long)donate.myDonateProjectRice];
    self.myRice = donate.myRice;
    self.progress = donate.progress / 100;
    self.yueLabel.text = donate.aboutItemDesc;
    self.titleLabel.text = donate.title;
    self.contentLabel.text = donate.summary;
    self.joinNumLabel.text = [NSString stringWithFormat:@"%ld", (long)donate.joinMemberNum];
    self.donateNumLabel.text = [NSString stringWithFormat:@"%ld", (long)donate.riceTotal];
    self.itemProgressNumLabel.text = [NSString stringWithFormat:@"%.2f%%", donate.progress];
    [self resetProgress];
}

- (void)resetComment:(NSArray *)arrayComment
{
    [self.commentView reset:arrayComment];
}

- (void)timerProgress
{
    [self.progressView resetProgress:self.curProgress];
    self.scaleDonateNumLabel.text = [NSString stringWithFormat:@"%.2f%%", self.curProgress * 100];
    self.curProgress = self.curProgress + 0.05 * self.progress;
    if(self.curProgress > self.progress){
        [self.timer invalidate];
        self.timer = nil;
        CGAffineTransform originTransForm = self.scaleDonateNumLabel.transform;
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            CGAffineTransform transform = CGAffineTransformScale(self.scaleDonateNumLabel.transform, 2, 2);
            self.scaleDonateNumLabel.transform = transform;
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:1 animations:^{
                self.scaleDonateNumLabel.transform = originTransForm;
            } completion:^(BOOL finished) {
                self.donateLabel2.hidden = NO;
                self.donateLabel1.text = @"我的米粒";
                self.scaleDonateNumLabel.text = [NSString stringWithFormat:@"%ld", (long)self.myRice];
            }];
        }];
    }

}

#pragma mark - MGYDonationCommentViewDelegate

- (void)finishMove
{
    
}

- (void)move
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.commentView move];
    });
}

+ (CGFloat)minHeight
{
    return 20 + 9 + 20 + 282/2 + 26/2 + 9 + 13 + 15 + 13 + 9 + 13 + 15 + 12 + 20 + 10 + 9 + 15 + 15;
}

@end
