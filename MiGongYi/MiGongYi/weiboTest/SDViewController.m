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
#import "MGYNetworking.h"

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
    self.token = @"2.00hWmuuB7EELHEdde0c7a9a8pUARcB";
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
    [self requestForWeibo2];
    //[self sendWeibo];
    //[self downloadTest];
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

- (void)requestForWeibo2
{
    [[[SDWebImageManager sharedManager] imageCache] clearDisk];
    [[[SDWebImageManager sharedManager] imageCache] clearMemory];
    [[MGYWebImageManager shareInstance] clearDisk];
    NSString *url = @"https://api.weibo.com/2/statuses/public_timeline.json";
    MGYNetManager *manager = [MGYNetManager manager];
    NSDictionary *parameters = @{@"access_token":self.token, @"count":@(200)};
    [manager GET:url parameters:parameters success:^(MGYNetOperation *operation, NSDictionary * responseObject) {
        NSArray *array = responseObject[@"statuses"];
        for (NSDictionary *dic in array) {
            NSDictionary *user = dic[@"user"];
            [_array addObject:user[@"profile_image_url"]];
        }
        
        [self.tableView reloadData];
    } failure:^(MGYNetOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)sendWeibo
{
    MGYNetManager *manager = [MGYNetManager manager];
    NSString *text = @"无聊";
    NSDictionary *parameters = @{@"access_token":self.token, @"status":text};
    NSString *url = @"https://api.weibo.com/2/statuses/update.json";
    [manager POST:url parameters:parameters success:^(MGYNetOperation *operation, NSDictionary * responseObject) {
        //NSLog(@"yyyyy  %@", responseObject);
    } failure:^(MGYNetOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (void)downloadTest
{
    //NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    MGYURLSessionManager *manager = [MGYURLSessionManager manager];
    
    NSURL *URL = [NSURL URLWithString:@"https://github.com/Volcore/waaaghtv/archive/master.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        if (error) {
            NSLog(@"yyyyyyyy %@", error);
        }
    }];
    [downloadTask resume];
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
