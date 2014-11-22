//
//  MGYRiceBoxingViewController.m
//  MiGongYi
//
//  Created by megil on 11/13/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceBoxingViewController.h"
#import "MGYAccelerometer.h"
#import "MGYGetRiceDataManager.h"
#import "MGYRiceBoxingDetailsViewController.h"
#import "Masonry.h"
#import "MGYGetRiceDataManager.h"
#import "MGYRiceBoxingMonsterProgressView.h"
#import "JEProgressView.h"

@interface MGYRiceBoxingViewController ()

@property (nonatomic, strong) MGYMonster *monster;
@property (nonatomic, weak) UIImageView *backgroundImageView;
@property (nonatomic, weak) UILabel *monsterNameLabel;
@property (nonatomic, weak) JEProgressView *progressView;
@property (nonatomic, weak) UIImageView *monsterImageView;
@property (nonatomic, weak) UIButton *detailsButton;
@property (nonatomic, weak) MGYRiceBoxingMonsterProgressView *monsterTipsView;
@property (nonatomic, weak) UIButton *soundButton;

@property (nonatomic, weak) MGYAccelerometer *accelerometer;
@property (nonatomic, weak) MGYGetRiceDataManager *dataManager;

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
    [backgroundImageView setImage:[UIImage imageNamed:@"riceBoxingBackground6"]];
    self.backgroundImageView = backgroundImageView;
    [self.view addSubview:backgroundImageView];
    
    MGYMonster *monster =  self.dataManager.record.arrayMonster[self.dataManager.record.monsterId];
    self.monster = monster;
    
    MGYRiceBoxingMonsterProgressView *monsterTipsView = [MGYRiceBoxingMonsterProgressView new];
    [self.view addSubview:monsterTipsView];
    self.monsterTipsView = monsterTipsView;
    
    [NSTimer scheduledTimerWithTimeInterval:1.0/5.0
                                     target:self
                                   selector:@selector(timerAction)
                                   userInfo:nil
                                    repeats:YES];
    JEProgressView *progressView = [JEProgressView new] ;
    [progressView setTrackImage:[UIImage imageNamed:@"blood_white"]];
    [progressView setProgressImage:[UIImage imageNamed:@"blood_red"]];
    [progressView sizeToFit];
    progressView.progress = 0.5;
    [self.view addSubview:progressView];
    self.progressView = progressView;
    
    UIImageView *monsterImageView = [UIImageView new];
    monsterImageView.contentMode = UIViewContentModeScaleAspectFit;
    [monsterImageView setImage:[UIImage imageNamed:monster.normalImagePath]];
    [self.view addSubview:monsterImageView];
    self.monsterImageView = monsterImageView;
    
    UILabel *monsterNameLabel = [UILabel new];
    monsterNameLabel.font = [UIFont systemFontOfSize:10];
    monsterNameLabel.textColor = [UIColor whiteColor];
    monsterNameLabel.text = monster.monsterName;
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
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(150);
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
    
    [self.accelerometer start];
}

- (void)click:(id)sender
{
    MGYRiceBoxingDetailsViewController *mvc = [[MGYRiceBoxingDetailsViewController alloc] initWithMonsterId:self.monster.monsterId];
    [self.navigationController pushViewController:mvc animated:NO];
}

- (void)soundStatus
{
    self.soundButton.selected = !self.soundButton.selected;
}

- (void)timerAction
{
    NSLog(@"%f %f %f", self.accelerometer.x, self.accelerometer.y, self.accelerometer.z);
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
