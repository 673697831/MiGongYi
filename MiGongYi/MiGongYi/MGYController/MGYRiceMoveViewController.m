//
//  MGYRiceMoveViewController.m
//  MiGongYi
//
//  Created by megil on 10/29/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>
#import "MGYRiceMoveViewController.h"
#import "MGYRiceMoveContentViewController.h"
#import "Masonry.h"
#import "MGYRiceMoveProgressView.h"
#import "MGYTotalWalk.h"

@interface MGYRiceMoveViewController ()

//@property (nonatomic, strong) MGYStoryPlayer *player;
//@property (nonatomic, strong) CMMotionManager *manager;

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
@property (nonatomic, copy) MGYStoryAddPowerCallback addPowerCallback;

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

    [self.manImageView setImage:[UIImage imageNamed:@"manImage1"]];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    MGYStoryAddPowerCallback addPowerCallback = ^() {
        MGYTotalWalk *totalWalk = [MGYStoryPlayer defaultPlayer].totalWalk;
        _powerAccount.text = [NSString stringWithFormat:@"%d", (int)totalWalk.power];
        
        if (_leftButton.isHidden) {
            _dateTimeLabel.text = @"今日";
            _stepAccount.text = [NSString stringWithFormat:@"%lld", totalWalk.curStep];
        }else
        {
            _dateTimeLabel.text = @"总共";
            _stepAccount.text = [NSString stringWithFormat:@"%lld", totalWalk.totalStep];
        }
    };
    _addPowerCallback = addPowerCallback;
    [MGYStoryPlayer defaultPlayer].addPowerCallback = _addPowerCallback;
    
    [[MGYStoryPlayer defaultPlayer] play:^{
        MGYTotalWalk *totalWalk = [MGYStoryPlayer defaultPlayer].totalWalk;
        NSArray *progressArray = [MGYStoryPlayer defaultPlayer].progressArray;
        
        
        //剧情相关
        if (progressArray) {
            [_progressView resetProgress:progressArray];
        }
        
        //步数相关
        if (totalWalk) {
            _powerAccount.text = [NSString stringWithFormat:@"%d", (int)totalWalk.power];
            _stepAccount.text = [NSString stringWithFormat:@"%lld", totalWalk.curStep];
        }
        [self.backgroundImageView setImage:[UIImage imageNamed:[[MGYStoryPlayer defaultPlayer] getCurStoryName]]];
        
    }];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.addPowerCallback = nil;
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
        [[MGYStoryPlayer defaultPlayer] goAhead:^(MGYStoryNode *node, MGYStorySelectCallback selectCallback) {
            if (selectCallback && node) {
                MGYRiceMoveContentViewController *viewController = [[MGYRiceMoveContentViewController alloc] initWithNode:node
                                                                                                           selectCallback:selectCallback];
                [self.navigationController pushViewController:viewController animated:YES];
            }
            else if(node)
            {
                MGYRiceMoveContentViewController *viewController = [[MGYRiceMoveContentViewController alloc] initWithNode:node
                                                            selectCallback:nil];
                [self.navigationController pushViewController:viewController animated:YES];
            }
            MGYTotalWalk *totalWalk = [MGYStoryPlayer defaultPlayer].totalWalk;
            NSArray *progressArray = [MGYStoryPlayer defaultPlayer].progressArray;
            
            if (progressArray) {
                [_progressView resetProgress:progressArray];
            }
            
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
        MGYRiceMoveDetailsViewController *viewController = [[MGYRiceMoveDetailsViewController alloc] initWithMapName:[[MGYStoryPlayer defaultPlayer] getCurStoryName]];
        
        [self.navigationController pushViewController:viewController animated:YES];
        
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
