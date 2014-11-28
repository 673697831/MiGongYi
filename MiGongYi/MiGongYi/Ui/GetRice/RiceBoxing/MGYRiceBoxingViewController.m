//
//  MGYRiceBoxingViewController.m
//  MiGongYi
//
//  Created by megil on 11/13/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceBoxingViewController.h"
#import "MGYRiceBoxingContentViewController.h"
#import "MGYAccelerometer.h"
#import "MGYGetRiceDataManager.h"
#import "MGYRiceBoxingDetailsViewController.h"
#import "Masonry.h"
#import "MGYGetRiceDataManager.h"
#import "JEProgressView.h"

@interface MGYRiceBoxingViewController ()

//@property (nonatomic, strong) MGYMonster *monster;
@property (nonatomic, weak) UIImageView *backgroundImageView;
@property (nonatomic, weak) UILabel *monsterNameLabel;
@property (nonatomic, weak) JEProgressView *progressView;
@property (nonatomic, weak) UIImageView *monsterImageView;
@property (nonatomic, weak) UIButton *detailsButton;
@property (nonatomic, weak) MGYRiceBoxingMonsterProgressView *monsterTipsView;
@property (nonatomic, weak) UIButton *soundButton;

@property (nonatomic, weak) MGYAccelerometer *accelerometer;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *alphaTimer;
@property (nonatomic, weak) MGYGetRiceDataManager *dataManager;
@property (nonatomic, assign) BOOL isHiting;
@property (nonatomic, weak) UIView *backgroundView;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, copy) MGYRiceBoxingTimeBlock timerBlock;
@property (nonatomic, assign) BOOL isIncrease;
@property (nonatomic, weak) UILabel *bloodNumLabel;


@end

@implementation MGYRiceBoxingViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataManager = [DataManager shareInstance].getRiceDataManager;
        self.accelerometer = [MGYAccelerometer shareInstance];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *backgroundImageView = [UIImageView new];
    self.backgroundImageView = backgroundImageView;
    [self.view addSubview:backgroundImageView];
    
    MGYRiceBoxingMonsterProgressView *monsterTipsView = [MGYRiceBoxingMonsterProgressView new];
    monsterTipsView.progressViewDelegate = self;
    [self.view addSubview:monsterTipsView];
    self.monsterTipsView = monsterTipsView;
    
    JEProgressView *progressView = [JEProgressView new] ;
    [progressView setTrackImage:[UIImage imageNamed:@"blood_white"]];
    [progressView setProgressImage:[UIImage imageNamed:@"blood_red"]];
    [progressView sizeToFit];
    
    [self.view addSubview:progressView];
    self.progressView = progressView;
    
    UIImageView *monsterImageView = [UIImageView new];
    monsterImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:monsterImageView];
    self.monsterImageView = monsterImageView;
    
    UILabel *monsterNameLabel = [UILabel new];
    monsterNameLabel.font = [UIFont systemFontOfSize:12];
    monsterNameLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:monsterNameLabel];
    self.monsterNameLabel = monsterNameLabel;
    
    UIButton *detailsButton = [UIButton new];
    [detailsButton addTarget:self
                      action:@selector(click:)
            forControlEvents:UIControlEventTouchUpInside];
    [detailsButton setImage:[UIImage imageNamed:@"btn_clan"]
                   forState:UIControlStateNormal];
    [self.view addSubview:detailsButton];
    self.detailsButton = detailsButton;
    
    UIButton *soundButton = [UIButton new];
    [soundButton addTarget:self
                    action:@selector(soundStatus)
          forControlEvents:UIControlEventTouchUpInside];
    [soundButton setImage:[UIImage imageNamed:@"sound_open"]
                 forState:UIControlStateNormal];
    [soundButton setImage:[UIImage imageNamed:@"sound_close"]
                 forState:UIControlStateSelected];
    [self.view addSubview:soundButton];
    self.soundButton = soundButton;
    
    UIView *backgroundView = [UIView new];
    backgroundView.userInteractionEnabled = NO;
    backgroundView.backgroundColor = [UIColor redColor];
    backgroundView.hidden = YES;
    [self.view addSubview:backgroundView];
    self.backgroundView = backgroundView;
    
    UILabel *timeLabel = [UILabel new];
    timeLabel.font = [UIFont systemFontOfSize:50];
    //timeLabel.backgroundColor = [UIColor redColor];
    timeLabel.textColor = [UIColor whiteColor];
    //timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.hidden = YES;
    [self.view addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel *bloodNumLabel = [UILabel new];
    bloodNumLabel.font = [UIFont systemFontOfSize:30];
    bloodNumLabel.textColor = [UIColor whiteColor];
    bloodNumLabel.text = @"20";
    [self.view addSubview:bloodNumLabel];
    self.bloodNumLabel = bloodNumLabel;
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.monsterTipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.mas_equalTo(42);
        make.top.equalTo(self.titleView.mas_bottom);
        make.centerX.equalTo(self.view);
    }];
    
    [self.monsterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        //make.width.mas_equalTo(150);
        //make.height.mas_equalTo(150);
        //make.top.equalTo(self.progressView.mas_bottom).with.offset(10);
        make.bottom.equalTo(self.view).with.offset(-25);
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(192/2);
        make.height.mas_equalTo(14/2);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.monsterImageView.mas_top).with.offset(-47/2);
    }];
    
    [self.monsterNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.progressView.mas_top).with.offset(-10);
    }];
    
    [self.detailsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).with.offset(-10);
        make.right.equalTo(self.view).with.offset(-10);
    }];
    
    [self.soundButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.monsterTipsView.mas_bottom).with.offset(32/2);
        make.right.equalTo(self.view).with.offset(-75/2);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
    }];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.bloodNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.monsterNameLabel.mas_top).with.offset(0);
        make.centerX.equalTo(self.view);
    }];
    
    self.bloodNumLabel.hidden = YES;
    [self.accelerometer start];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    __weak typeof(self)wself = self;
    self.timerBlock = ^(void)
    {
        dispatch_main_async_safe((^{
            __strong typeof(self)sself = wself;
            if(sself){
                //NSLog(@"ewfwf %ld", (long)[sself.dataManager getRiceBoxingBossRemainTime]);
                sself.timeLabel.hidden = NO;
                NSInteger remainTime = [sself.dataManager getRiceBoxingBossRemainTime]/10;
                sself.timeLabel.text = [NSString stringWithFormat:@"%ld", (long)remainTime];
                
                if(remainTime <= 0)
                {
                    sself.timeLabel.hidden = YES;
                    MGYMonster *monster = sself.dataManager.riceBoxingCurMonster;
                    MGYRiceBoxingContentViewController *mvc = [[MGYRiceBoxingContentViewController alloc] initWithMonster:monster isSuccess:NO];
                    [sself.navigationController pushViewController:mvc animated:YES];
                    
                }
            }
        }));
    };
    
    [self.dataManager setRiceRiceBoxingTimeBlock:self.timerBlock];
    
    [self reflush];
    
    MGYMonster *monster =  self.dataManager.riceBoxingCurMonster;
    if (monster.monsterType == MGYMonsterTypeLarge) {
        self.backgroundView.hidden = NO;
    }else
    {
        self.backgroundView.hidden = YES;
    }
    [self.timer invalidate];
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/5.0
                                                  target:self
                                                selector:@selector(timerAction)
                                                userInfo:nil
                                                 repeats:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.timerBlock = nil;
    [self.timer invalidate];
    self.timer = nil;
    [self.alphaTimer invalidate];
    self.alphaTimer = nil;
    self.timeLabel.hidden = YES;
}

- (void)click:(id)sender
{
    MGYMonster *monster = self.dataManager.riceBoxingCurMonster;
    
    MGYRiceBoxingDetailsViewController *mvc = [[MGYRiceBoxingDetailsViewController alloc] initWithMonsterId:monster.monsterId];
    [self.navigationController pushViewController:mvc animated:NO];
}

- (void)soundStatus
{
    self.soundButton.selected = !self.soundButton.selected;
}

- (void)timerAction
{
    //NSLog(@"%f %f %f", self.accelerometer.x, self.accelerometer.y, self.accelerometer.z);
    CGFloat x = self.accelerometer.x;
    CGFloat y = self.accelerometer.y;
    CGFloat z = self.accelerometer.z;
    if (sqrt(x*x+y*y+z*z) > 2 && !self.isHiting){
        @synchronized(self)
        {
            self.isHiting = YES;
            CGRect originFrame = self.monsterImageView.frame;
            CGRect originBloodFrame = self.bloodNumLabel.frame;
            [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn |UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
                             animations:^(void) {
                                 [UIView setAnimationRepeatCount:1];
                                 CGRect frame = self.monsterImageView.frame;
                                 frame.origin.x= frame.origin.x + 100;
                                 self.monsterImageView.frame = frame;
                                 
                                 self.backgroundView.hidden = NO;
                                 
                                 }
                             completion:^(BOOL finished){
                                 
                                 [UIView animateWithDuration:0.2 delay:0.0 options:
                                  UIViewAnimationOptionCurveEaseIn animations:^{
                                      self.monsterImageView.frame = originFrame;
                                      
                                  } completion:^ (BOOL completed) {
                                      self.isHiting = NO;
                                      
                                      MGYMonster *monster = self.dataManager.riceBoxingCurMonster;
                                      if (monster.monsterType != MGYMonsterTypeLarge) {
                                           self.backgroundView.hidden = YES;
                                      }
                                     
                                      
                                  }];
                             }];
            [UIView animateWithDuration:0.5
                             animations:^{
                                 self.bloodNumLabel.hidden = NO;
                                 CGRect frame = self.bloodNumLabel.frame;
                                 frame = self.bloodNumLabel.frame;
                                 frame.origin.y = frame.origin.y - 50;
                                 self.bloodNumLabel.frame = frame;
                            } completion:^(BOOL finished) {
                                 self.bloodNumLabel.frame = originBloodFrame;
                                 self.bloodNumLabel.hidden = YES;
                            }];
            MGYMonster *monster = self.dataManager.riceBoxingCurMonster;
            [self.dataManager hitMonster:^{
                MGYRiceBoxingContentViewController *mvc = [[MGYRiceBoxingContentViewController alloc] initWithMonster:monster isSuccess:YES];
                [self.navigationController pushViewController:mvc animated:YES];
                
            } failure:^(NSError *error){
                if([error.domain isEqualToString:MGYRiceBoxingErrorDomain]&& error.code == MGYRiceBoxingErrorRiceNull){
                    self.progressView.progress = [self.dataManager riceBoxingMonsterProgress];
                }
                
                if (error.userInfo[NSUnderlyingErrorKey]) {
                    self.progressView.progress = [self.dataManager riceBoxingMonsterProgress];
                }
                
            } timeoutFailure:^{
                MGYRiceBoxingContentViewController *mvc = [[MGYRiceBoxingContentViewController alloc] initWithMonster:monster isSuccess:NO];
                [self.navigationController pushViewController:mvc animated:YES];
            }];
            self.progressView.progress = [self.dataManager riceBoxingMonsterProgress];
        }
    }

}

- (void)timerAlpha
{
    if (self.backgroundView.alpha < 0.1) {
        self.isIncrease = YES;
    }
    
    if (self.backgroundView.alpha > 0.5) {
        self.isIncrease = NO;
    }
    
    NSInteger index = self.isIncrease ? 1: -1;
    NSInteger int_alpha = (long)(self.backgroundView.alpha * 10);
    CGFloat alpha = (int_alpha + index)/10.0;
    dispatch_main_async_safe(^{
        self.backgroundView.alpha = alpha;
    })
    
}

- (void)clickFightButton
{
    [self.dataManager riceBoxingResetBoss];
    [self reflush];
}

- (void)reflush
{
    MGYMonster *monster =  self.dataManager.riceBoxingCurMonster;
    if (monster.monsterStatus == MGYMonsterStatusLocked) {
        [self.dataManager riceBoxingUnLockMonster:monster.monsterId];
    }
    [self.backgroundImageView setImage:[UIImage imageNamed:monster.backgroundImagePath]];
    [self.monsterImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"riceBoxingMonster%ld", (long)monster.monsterId]]];
    self.monsterNameLabel.text = monster.monsterName;
    self.timeLabel.text = @"";
    
    self.progressView.progress = [self.dataManager riceBoxingMonsterProgress];
    
    [self.monsterTipsView reset];
    
    if (monster.monsterType == MGYMonsterTypeLarge || true) {
        //self.backgroundView.hidden = NO;
        [self.alphaTimer invalidate];
        self.alphaTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/5.0
                                                           target:self
                                                         selector:@selector(timerAlpha)
                                                         userInfo:nil
                                                          repeats:YES];
    }else
    {
        [self.alphaTimer invalidate];
        self.alphaTimer = nil;
        self.backgroundView.hidden = YES;
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
