//
//  MGYProgramItemViewController.m
//  MiGongYi
//
//  Created by megil on 9/13/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYProgramItemViewController.h"
#import "Details/DetailsViewCell.h"
#import "DataManager.h"
#import "UIColor+Expanded.h"

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
    DetailsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Item Cell" forIndexPath:indexPath];
 
    [cell updateDetails:__array[indexPath.row]];
    if (!self.isLoading && __array.count - indexPath.row == 1 ) {
        self.isLoading = YES;
        [[DataManager shareInstance] requestForList:1 start:__array.count limit:3 reset:NO];
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
    NSLog(@"resetData~~~~~~");
    [__array addObjectsFromArray:array];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
    self.isLoading = NO;
}

-(void) refreshView:(UIRefreshControl *)refreshControl
{
    
//    NSLog(@"iiiiiiiiiiii");
//    if (self.isLoading) {
//        return;
//    }
    
    [[DataManager shareInstance] requestForList:1 start:0 limit:3 reset:YES];
    //[refreshControl endRefreshing];
}

- (void)viewDidLoad
{
    self.title = @"公益项目";
    __array = [NSMutableArray array];
    
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49);
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView registerClass:[DetailsViewCell class] forCellReuseIdentifier:@"Item Cell"];

    tableView.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    
    //增加刷新控件
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    self.refreshControl = refreshControl;
    
    [[DataManager shareInstance] requestForList:1 start:0 limit:3 reset:YES];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
