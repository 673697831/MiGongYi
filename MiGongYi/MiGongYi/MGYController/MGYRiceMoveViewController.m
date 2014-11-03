//
//  MGYRiceMoveViewController.m
//  MiGongYi
//
//  Created by megil on 10/29/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>
#import "MGYRiceMoveViewController.h"
#import "Masonry.h"
#import "MGYRiceMoveProgressView.h"
#import "MGYTotalWalk.h"

@interface MGYRiceMoveViewController ()

@property (nonatomic, strong) MGYStoryPlayer *player;
@property (nonatomic, strong) CMMotionManager *manager;

@property (nonatomic, weak) UIImageView *backgroundImageView;
@property (nonatomic, weak) UIImageView *manImageView;
@property (nonatomic, weak) UIButton *goButton;
@property (nonatomic, weak) UIButton *detailsButton;
@property (nonatomic, weak) MGYRiceMoveProgressView *progressView;
@property (nonatomic, weak) UIView *tipsView;
@property (nonatomic, weak) UILabel *dateTimeLabel;
@property (nonatomic, weak) UILabel *stepAccount;
@property (nonatomic, weak) UILabel *label1;
@property (nonatomic, weak) UILabel *label2;
@property (nonatomic, weak) UILabel *powerAccount;
@property (nonatomic ,weak) UIButton *leftButton;
@property (nonatomic ,weak) UIButton *rightButton;
@property (nonatomic, weak) UILabel *walkAmountLabel;

@end

@implementation MGYRiceMoveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [UIButton new];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor blueColor];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(100);
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
    }];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Config" ofType:@"plist"];
    NSArray *fileNameArray = [NSArray arrayWithContentsOfFile:plistPath];
    
    for (NSString *fileName in fileNameArray) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
        NSArray *nodeArray = [NSArray arrayWithContentsOfFile:filePath];
        NSMutableArray *nodes = [NSMutableArray array];
        for (NSDictionary *dic in nodeArray) {
            MGYStoryNode *node = [MTLJSONAdapter modelOfClass:[MGYStoryNode class] fromJSONDictionary:dic error:nil];
            [nodes addObject:node];
        }
        self.player = [MGYStoryPlayer defaultPlayer];
        [self.player play:^{
            
        }];
        
        
        break;
    }
    
    self.manager = [CMMotionManager new];
    self.manager.accelerometerUpdateInterval = 1./60;
    [self.manager startAccelerometerUpdates];
    [NSTimer scheduledTimerWithTimeInterval:1.0/5.0
                                     target:self
                                   selector:@selector(timerAction)
                                   userInfo:nil
                                    repeats:YES];
    
    UIImageView *backgroundImageView = [UIImageView new];
    [self.view addSubview:backgroundImageView];
    self.backgroundImageView = backgroundImageView;
    UIImageView *manImageView = [UIImageView new];
    [self.view addSubview:manImageView];
    self.manImageView = manImageView;
    UIButton *goButton = [UIButton new];
    [goButton setImage:[UIImage imageNamed:@"go"] forState:UIControlStateNormal];
    [goButton addTarget:self
                 action:@selector(click:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goButton];
    self.goButton = goButton;
    UIButton *detailsButton = [UIButton new];
    [detailsButton addTarget:self
                      action:@selector(click:)
            forControlEvents:UIControlEventTouchUpInside];
    [detailsButton setImage:[UIImage imageNamed:@"button_handbook_normal"] forState:UIControlStateNormal];
    [detailsButton setImage:[UIImage imageNamed:@"button_handbook_warn"] forState:UIControlStateSelected];
    [self.view addSubview:detailsButton];
    self.detailsButton = detailsButton;
    
    MGYRiceMoveProgressView *progressView = [MGYRiceMoveProgressView new];
    [self.view addSubview:progressView];
    self.progressView = progressView;
    
    UIView *tipsView = [UIView new];
    tipsView.backgroundColor = [UIColor blackColor];
    tipsView.alpha = 0.42;
    [self.view addSubview:tipsView];
    self.tipsView = tipsView;
    
    UILabel *dateTimeLabel = [UILabel new];
    dateTimeLabel.text = @"今天";
    dateTimeLabel.textColor = [UIColor whiteColor];
    dateTimeLabel.font = [UIFont systemFontOfSize:11];
    [self.view addSubview:dateTimeLabel];
    self.dateTimeLabel = dateTimeLabel;
    
    UILabel *stepAccount = [UILabel new];
    stepAccount.text = @"0";
    stepAccount.textColor = [UIColor whiteColor];
    stepAccount.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:stepAccount];
    self.stepAccount = stepAccount;
    
    UILabel *label1 = [UILabel new];
    label1.text = @"步";
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont systemFontOfSize:9];
    [self.view addSubview:label1];
    self.label1 = label1;
    
    UILabel *label2 = [UILabel new];
    label2.text = @"米动力";
    label2.textColor = [UIColor whiteColor];
    label2.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:label2];
    self.label2 = label2;
    
    UILabel *powerAccount = [UILabel new];
    powerAccount.text = @"0";
    powerAccount.textColor = [UIColor whiteColor];
    powerAccount.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:powerAccount];
    self.powerAccount = powerAccount;
    
    UIButton *leftButton = [UIButton new];
    leftButton.hidden = YES;
    [leftButton addTarget:self
                   action:@selector(click:)
         forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"button_left arrow_normal"]
                forState:UIControlStateNormal];
    [self.view addSubview:leftButton];
    self.leftButton = leftButton;
    
    UIButton *rightButton = [UIButton new];
    [rightButton addTarget:self
                    action:@selector(click:)
          forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"button_right arrow_normal"]
                 forState:UIControlStateNormal];
    [self.view addSubview:rightButton];
    self.rightButton = rightButton;
    
    UILabel *walkAmountLabel = [UILabel new];
    [self.view addSubview:walkAmountLabel];
    walkAmountLabel.text = @"相当于一条小肠的长度";
    //walkAmountLabel.numberOfLines = 0;
    walkAmountLabel.font = [UIFont systemFontOfSize:9];
    walkAmountLabel.textColor = [UIColor whiteColor];
    self.walkAmountLabel = walkAmountLabel;
    [self setup];
    
#warning 米有氧测试
    [self.backgroundImageView setImage:[UIImage imageNamed:@"story1"]];
    [self.manImageView setImage:[UIImage imageNamed:@"manImage1"]];
    
}

- (void)setup
{
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.manImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-10);
    }];
    
    [self.goButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(15);
        make.bottom.equalTo(self.view).with.offset(-9);
    }];
    
    [self.detailsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).with.offset(-10);
        make.right.equalTo(self.view).with.offset(-10);
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.manImageView);
        make.bottom.equalTo(self.goButton.mas_top);
        make.width.mas_equalTo(4);
        make.centerX.equalTo(self.goButton);
    }];
    
    [self.tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(27);
        make.right.equalTo(self.view).with.offset(-27);
        make.height.mas_equalTo(91);
        make.top.equalTo(self.titleView.mas_bottom).with.offset(4);
    }];
    
    [self.dateTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tipsView).with.offset(8);
        make.top.equalTo(self.tipsView).with.offset(13);
    }];
    
    [self.stepAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.dateTimeLabel);
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.stepAccount);
        make.left.equalTo(self.stepAccount.mas_right).with.offset(10);
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tipsView).with.offset(-10);
        make.right.equalTo(self.stepAccount);
    }];
    
    [self.powerAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tipsView).with.offset(-8);
        make.left.equalTo(self.label2.mas_right).with.offset(10);
    }];
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.tipsView);
        make.left.equalTo(self.tipsView).with.offset(42);
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.tipsView);
        make.right.equalTo(self.tipsView).with.offset(-42);
    }];
    
    [self.walkAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.tipsView);
        make.centerX.equalTo(self.tipsView);
    }];
}

- (void)click:(id)sender
{
    if (self.goButton == sender) {
        //[self.player addPower:14440];
        [self.player goAhead:^(MGYStorySelectCallback selectCallback, NSArray *array, MGYTotalWalk *totalWalk) {
            if (selectCallback) {
                selectCallback(1);
            }
            [self.progressView resetProgress:array];
            if (totalWalk) {
                _powerAccount.text = [NSString stringWithFormat:@"%d", (int)totalWalk.power];
            }
        }];
    }
    
    if (self.leftButton == sender) {
        self.leftButton.hidden = YES;
        self.rightButton.hidden = NO;
        self.dateTimeLabel.text = @"今天";
    }
    
    if (self.rightButton == sender) {
        self.leftButton.hidden = NO;
        self.rightButton.hidden = YES;
        self.dateTimeLabel.text = @"总共";
    }
    
    if (self.detailsButton == sender) {
        MGYRiceMoveDetailsViewController *viewController = [[MGYRiceMoveDetailsViewController alloc] initWithMap:0];
        
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
}

- (void)timerAction
{
    //NSLog(@"%f %f %f", self.manager.accelerometerData.acceleration.x, self.manager.accelerometerData.acceleration.y, self.manager.accelerometerData.acceleration.z);
    CGFloat x = self.manager.accelerometerData.acceleration.x;
    CGFloat y = self.manager.accelerometerData.acceleration.y;
    CGFloat z = self.manager.accelerometerData.acceleration.z;
    
    __block typeof(_leftButton)leftButton = _leftButton;
    //__block typeof(_rightButton)rightButton = _rightButton;
    __block typeof(_powerAccount)powerAccount = _powerAccount;
    __block typeof(_dateTimeLabel)dateTimeLabel = _dateTimeLabel;
    __block typeof(_stepAccount)stepAccount = _stepAccount;
    
    if (sqrt(x*x+y*y+z*z) >2) {
        [_player addPower:1110 callback:^(MGYTotalWalk *totalWalk) {
            powerAccount.text = [NSString stringWithFormat:@"%d", (int)totalWalk.power];
            if (leftButton.isHidden) {
                dateTimeLabel.text = @"今日";
                stepAccount.text = [NSString stringWithFormat:@"%lld", totalWalk.curStep];
            }else
            {
                dateTimeLabel.text = @"总共";
                stepAccount.text = [NSString stringWithFormat:@"%lld", totalWalk.totalStep];
            }
        }];
        //self.player.progress = self.player.progress + 500;
    }
    //self.player.progress = self.player.progress + 1;
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
