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

@end

@implementation MGYProgramItemViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    // NSLog(@"%d uuuu", self.array.count);
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
    if (!self.isLoading && __array.count - indexPath.row == 1 ) {
        self.isLoading = YES;
        [[DataManager shareInstance] requestForList:1
                                              start:__array.count
                                              limit:1
                                              reset:NO
                                            success:^{
                                                NSArray *array = [DataManager shareInstance].itemList;
                                                [self resetData:array reset:YES];
                                            }
                                            failure:^(NSError *error) {
            
                                            }];
    }
    //NSLog(@"cellforrowatindexpath");
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (448 +200 +50)/2;
}

- (void)resetData:(NSArray *)array reset:(BOOL)reset
{
    if (reset) {
        [__array removeAllObjects];
    }
    [__array addObjectsFromArray:array];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
    self.isLoading = NO;
}

-(void) refreshView:(UIRefreshControl *)refreshControl
{
    self.isLoading = YES;
    [[DataManager shareInstance] requestForList:1
                                          start:0
                                          limit:3
                                          reset:YES
                                        success:^{
                                            NSArray *array = [DataManager shareInstance].itemList;
                                            [self resetData:array reset:YES];
                                        }
                                        failure:^(NSError *error) {
                                        }];
    [refreshControl endRefreshing];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"公益项目";
    __array = [NSMutableArray array];
    
    //CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49);
    
    //UITableView *tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
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
    
    [[DataManager shareInstance] requestForList:1
                                          start:0
                                          limit:1
                                          reset:YES
                                        success:^{
                                            NSArray *array = [DataManager shareInstance].itemList;
                                            [self resetData:array reset:YES];
                                        }
                                        failure:^(NSError *error) {
        
                                        }];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setSelectedIndex:2];
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
