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

@property(nonatomic, weak) UITableView *myTableView;
@property(nonatomic, strong) MGYMiZhi *miZhi;
@property(nonatomic, assign) CGFloat webViewHeight;

@end

@implementation MGYMiZhiViewController

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
    
    [[DataManager shareInstance] requestForMiZhi:^{
        self.miZhi = [DataManager shareInstance].miZhi;
        [myTableView reloadData];
        }
                                         failure:^(NSError *error) {
        
                                         }];
    
    
    
   // NSString * nsDateString= [NSString stringWithFormat:@"M年-月-日",year,month,day];
    // Do any additional setup after loading the view.
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

- (void)updateWebViewHeight:(CGFloat)height
{
    self.webViewHeight = height;
    self.myTableView.scrollEnabled = YES;
    [self.myTableView reloadData];
}

#pragma mark - tableView delegate
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
