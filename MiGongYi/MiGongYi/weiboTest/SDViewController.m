//
//  SDViewController.m
//  Ricedonate
//
//  Created by megil on 10/14/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "SDViewController.h"
#import "SDTableViewCell.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

@interface SDViewController ()
{
    NSMutableArray *_array;
}

@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, copy) NSString *token;

@end

@implementation SDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.token = @"2.00hWmuuB7EELHEbb4349f6c00kQwR8";
    _array = [NSMutableArray array];
    UITableView *tableView = [UITableView new];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.delegate =self;
    tableView.dataSource = self;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [tableView registerClass:[SDTableViewCell class] forCellReuseIdentifier:@"normal Cell"];
    [self requestForWeibo];
    // Do any additional setup after loading the view.
}

- (void)requestForWeibo
{
#warning 每次请求数据把缓存清空
    [[[SDWebImageManager sharedManager] imageCache] clearDisk];
    [[[SDWebImageManager sharedManager] imageCache] clearMemory];
    
    NSString *url = @"https://api.weibo.com/2/statuses/public_timeline.json";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"access_token":self.token, @"count":@(200)};
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        NSArray *array = responseObject[@"statuses"];
        for (NSDictionary *dic in array) {
            NSDictionary *user = dic[@"user"];
            [_array addObject:user[@"profile_image_url"]];
        }
        
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

#pragma mark - tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normal Cell"
                             forIndexPath:indexPath];
    if (indexPath.row < _array.count) {
        [cell reset:_array[indexPath.row]];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1000;
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
