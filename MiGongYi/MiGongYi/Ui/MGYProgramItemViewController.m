//
//  MGYProgramItemViewController.m
//  MiGongYi
//
//  Created by megil on 9/13/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYProgramItemViewController.h"
#import "Details/MGYDetailsViewCell.h"
#import "MGYDetailsViewController.h"
#import "DataManager.h"
#import "UIColor+Expanded.h"
#import "Masonry.h"

@interface MGYProgramItemViewController ()
{
    NSMutableArray *__array;
}

@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, weak) UIRefreshControl *refreshControl;
@property(nonatomic, assign) BOOL isLoading;
@property(nonatomic, assign) BOOL isEnd;

@end

@implementation MGYProgramItemViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isEnd = false;
    self.title = NSLocalizedString(@"公益项目", @"公益项目");
    __array = [NSMutableArray array];
    
    UITableView *tableView = [UITableView new];
    [self.view addSubview:tableView];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView registerClass:[MGYDetailsViewCell class] forCellReuseIdentifier:@"Item Cell"];
    
    tableView.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //增加刷新控件
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    self.refreshControl = refreshControl;
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self refresh:0 limit:1 reset:YES];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setSelectedIndex:2];
}

- (void)refresh:(NSInteger)start
          limit:(NSInteger)limit
          reset:(BOOL)reset
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[DataManager shareInstance] requestForList:MGYProjectTypeItem
                                          start:start
                                          limit:limit
                                          reset:reset
                                        success:^{
                                            __array = [NSMutableArray arrayWithArray:[DataManager shareInstance].itemList];
                                            [self.tableView reloadData];
                                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                                        }
                                        failure:^(NSError *error) {
                                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                                            if ([error.domain  isEqual: CustomErrorDomain]) {
                                                if (error.code == MGYMiListErrorEmpty) {
                                                    self.isEnd = YES;
                                                }
                                            }
                                        }];
}

#pragma mark - MGYBaseViewControllerProtocol
- (void)refreshView:(UIRefreshControl *)refreshControl
{
    self.isEnd = NO;
    [self refresh:0 limit:1 reset:YES];
    [refreshControl endRefreshing];
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return __array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cell...
    MGYDetailsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Item Cell" forIndexPath:indexPath];
    [cell reset:__array[indexPath.row]];
    if (!self.isEnd && __array.count - indexPath.row == 1) {
        [self refresh:__array.count + 1 limit:1 reset:NO];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (448 +200 +50)/2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGYProject *project =__array[indexPath.row];
    MGYDetailsViewController *view = [[MGYDetailsViewController alloc]initWithProjectId:project.projectId];
    [self.navigationController pushViewController:view animated:YES];
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
