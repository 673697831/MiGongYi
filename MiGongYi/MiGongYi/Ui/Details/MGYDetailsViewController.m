//
//  MGYDetailsViewController.m
//  MiGongYi
//
//  Created by megil on 9/18/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYDetailsViewController.h"
#import "MGYProjectDetailsTableViewCell.h"
#import "DataManager.h"
#import "Masonry.h"
#import "MGYProjectDetails.h"
#import "UIImageView+WebCache.h"

@interface MGYDetailsViewController ()

@property(nonatomic, strong) MGYProjectDetails *details;
@property(nonatomic, assign) NSInteger projectId;
@property(nonatomic, weak) UITableView *tableView;

@end

@implementation MGYDetailsViewController

- (instancetype)initWithProjectId:(NSInteger)projectId
{
    self = [super init];
    if (self) {
        self.projectId = projectId;
    }
    
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        MGYProjectDetailsTableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"detailsTableViewCell Cell"
                                               forIndexPath:indexPath];
        if (self.details) {
            [cell update:self.details];
        }
        
        return cell;
        
    }else
    {
        UITableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"tableView Cell"
                                               forIndexPath:indexPath];
        return cell;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
      // NSLog(@"uuuuuuuu %f", [])
        CGFloat height = 0;
        height = height + tableView.bounds.size.width * 0.7;
        height = height + 17;
        height = height + 20;
        height = height + 105;
        height = height + 15;
        //height = height + self.summaryLabel.bounds.size.height;
        if (self.details) {
             CGSize labelSize = [self.details.summary boundingRectWithSize:CGSizeMake(512/2, 5000) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} context:nil].size;
            height = height + labelSize.height;
        }
        height = height + 10;
        height = height + 35;
        height = height + 15;
        height = height + 15 + 10 + 10 + 15 + 52 + 20 + 55 + 40;
        NSLog(@"uuuuuuuuu %f", height);
        return height;
    }
    return 44;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.barView.hidden = YES;
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"< 返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
//    backItem.tintColor = [UIColor whiteColor];
//    self.navigationItem.leftBarButtonItem = backItem;
    
    UITableView *tableView = [UITableView new];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[UITableViewCell class]
      forCellReuseIdentifier:@"tableView Cell"];
    [tableView registerClass:[MGYProjectDetailsTableViewCell class]
      forCellReuseIdentifier:@"detailsTableViewCell Cell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [[DataManager shareInstance] requestForProjectDetails:self.projectId
                                                  success:^(MGYProjectDetails *details) {
                                                      //NSLog(@"ooooooo %@", details);
                                                      self.details = details;
                                                      [self.tableView reloadData];
                                                  }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
