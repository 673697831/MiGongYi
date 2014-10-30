//
//  MGYRiceMoveViewController.m
//  MiGongYi
//
//  Created by megil on 10/29/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceMoveViewController.h"
#import "Masonry.h"
#import <CoreMotion/CoreMotion.h>

@interface MGYRiceMoveViewController ()

@property (nonatomic, strong) MGYStoryPlayer *player;
@property (nonatomic, strong) CMMotionManager *manager;

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
        self.player = [MGYStoryPlayer new];
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
    
}

- (void)click:(id)sender
{
    [self.player addPower:14440];
    [self.player goAhead:^(MGYStorySelectCallback selectCallback) {
        if (selectCallback) {
            selectCallback(1);
        }
    }];
}

- (void)timerAction
{
    //NSLog(@"%f %f %f", self.manager.accelerometerData.acceleration.x, self.manager.accelerometerData.acceleration.y, self.manager.accelerometerData.acceleration.z);
    CGFloat x = self.manager.accelerometerData.acceleration.x;
    CGFloat y = self.manager.accelerometerData.acceleration.y;
    CGFloat z = self.manager.accelerometerData.acceleration.z;
    
    if (sqrt(x*x+y*y+z*z) >2) {
        [self.player goAhead:^(MGYStorySelectCallback selectCallback) {
            
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
