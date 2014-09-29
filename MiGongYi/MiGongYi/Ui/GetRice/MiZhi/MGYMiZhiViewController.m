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
#import "UIColor+Expanded.h"
#import "MGYMiZhi.h"

@interface MGYMiZhiViewController ()

@property(nonatomic, weak) UILabel *timerLabel;
@property(nonatomic, strong) NSTimer *myTimer;
@property(nonatomic, weak) UITableView *myTableView;
@property(nonatomic, strong) MGYMiZhi *miZhi;
@property(nonatomic, assign) CGFloat webViewHeight;

@end

@implementation MGYMiZhiViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGYMiZhiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MiZhiTableView Cell" forIndexPath:indexPath];
    
    if (self.miZhi) {
        [cell reset:self.miZhi];
    }
    
    if (!cell.clickDelegate) {
        cell.clickDelegate = self;
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.myTableView.bounds.size.height + self.webViewHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.barView.hidden = YES;
    self.webViewHeight = 0;
    UITableView *myTableView = [UITableView new];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [myTableView registerClass:[MGYMiZhiTableViewCell class] forCellReuseIdentifier:@"MiZhiTableView Cell"];
    [self.view addSubview:myTableView];
    self.myTableView = myTableView;
    myTableView.scrollEnabled = NO;
    [myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    
    
//    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1
//                                                    target:self
//                                                  selector:@selector(startTimer:)
//                                                  userInfo:nil
//                                                   repeats:YES];
//    
//    UILabel *timerLabel = [UILabel new];
//    timerLabel.textAlignment  = NSTextAlignmentCenter;
//    timerLabel.backgroundColor = [UIColor grayColor];
//    timerLabel.alpha = 0.5;
//    
//    [self.view addSubview:timerLabel];
//    self.timerLabel = timerLabel;
    
    //[self setup];
    
    [[DataManager shareInstance] requestForMiZhi:^(MGYMiZhi *miZhi) {
        //NSLog(@"mizhi~~~~~~ %@", miZhi);
        self.miZhi = miZhi;
        [myTableView reloadData];
    }];
    
    
    
   // NSString * nsDateString= [NSString stringWithFormat:@"M年-月-日",year,month,day];
    // Do any additional setup after loading the view.
}

//- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

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
    NSString *st2 = @"时";
    NSString *st3 = [NSString stringWithFormat:@"%d", minute];
    NSString *st4 = @"分";
    NSString *st5 = [NSString stringWithFormat:@"%d", second];
    NSString *st6 = @"秒";
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self.myTimer setFireDate:[NSDate distantPast]];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //[self.myTimer setFireDate:[NSDate distantFuture]];
}

- (void)updateWebViewHeight:(CGFloat)height
{
    NSLog(@"height ===== %f", height);
    self.webViewHeight = height;
    self.myTableView.scrollEnabled = YES;
    [self.myTableView reloadData];
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
