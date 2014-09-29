//
//  MGYMiZhiViewController.m
//  MiGongYi
//
//  Created by megil on 9/29/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYMiZhiViewController.h"
#import "Masonry.h"
#import "DataManager.h"

@interface MGYMiZhiViewController ()

@property(nonatomic, weak) UILabel *timerLabel;
@property(nonatomic, strong) NSTimer *myTimer;
@property(nonatomic, assign) NSInteger num;

@end

@implementation MGYMiZhiViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.barView.hidden = YES;
    
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                    target:self
                                                  selector:@selector(startTimer:)
                                                  userInfo:nil
                                                   repeats:YES];
    self.num = 0;
    
    UILabel *timerLabel = [UILabel new];
    timerLabel.backgroundColor = [UIColor grayColor];
    timerLabel.alpha = 0.5;
    [self.view addSubview:timerLabel];
    self.timerLabel = timerLabel;
    
    [self setup];
    
    [[DataManager shareInstance] requestForMiZhi:^(MGYMiZhi *miZhi) {
        NSLog(@"mizhi~~~~~~ %@", miZhi);
    }];
    // Do any additional setup after loading the view.
}

- (void)startTimer:(NSTimer *)theTimer
{
    self.num ++;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.myTimer setFireDate:[NSDate distantPast]];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.myTimer setFireDate:[NSDate distantFuture]];
}

- (void)setup
{
    [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.titleView.mas_bottom);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(self.view.bounds.size.width);
    }];
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
