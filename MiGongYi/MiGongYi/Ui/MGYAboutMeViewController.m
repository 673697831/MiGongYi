//
//  AboutMeViewController.m
//  MiGongYi
//
//  Created by megil on 9/19/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYAboutMeViewController.h"
#import "MGYBaseProgressView.h"
#import "Masonry.h"
#import "MGYPersonalDetails.h"
#import "DataManager.h"
#import "UIColor+Expanded.h"
#import "DataManager.h"
#import "MGYRiceFlow.h"
#import "MGYMyFavList.h"

@interface MGYAboutMeViewController ()

@property(nonatomic, assign) BOOL isLoading;
@property(nonatomic, strong) MGYRiceFlow *riceFlow;
@property(nonatomic, strong) MGYMyFavList *favList;
@property(nonatomic, assign) NSInteger selectedTableSourceIndex;
@property(nonatomic, weak) UIView *statusBackgroundView;
@property(nonatomic, weak) UIView *titleBackgroundView;
@property(nonatomic, weak) UILabel *backLabel;
@property(nonatomic, weak) UILabel *titleTextLabel;
@property(nonatomic, weak) UITableView *tableView;

@end

@implementation MGYAboutMeViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        MGYAboutMeTableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"section0 Cell" forIndexPath:indexPath];
        if (!cell.clickDelegate) {
            cell.clickDelegate = self;
        }
        
        NSInteger num = 0;
        switch (self.selectedTableSourceIndex) {
            case 0:
                num = self.riceFlow ? self.riceFlow.riceRemain : 0 ;
                break;
            case 1:
                //好友列表 暂无此功能
                //[cell resetNum:0];
                break;
            case 2:
                num = self.favList? self.favList.count : 0;
                break;
            default:
                break;
        }
        [cell resetNum:num];
        return cell;
    }
    else
    {
        UITableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"tableView Cell" forIndexPath:indexPath];
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else
    {
        return 10;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return (552/2 - 40 + 134/2);
    }
    return 44;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITableView *tableView = [UITableView new];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableView Cell"];
    [tableView registerClass:[MGYAboutMeTableViewCell class] forCellReuseIdentifier:@"section0 Cell"];
    self.tableView = tableView;
    
    [self refreshData:0];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setSelectedIndex:3];
    
    //[self refreshData:0];
    
}

- (void)refreshData:(NSInteger)type
{
    self.selectedTableSourceIndex = type;
    switch (type) {
        case 0:
        {
            if (!self.riceFlow) {
                [[DataManager shareInstance] requestForRiceFlow:0 limit:10 success:^() {
                    self.riceFlow = [DataManager shareInstance].myRiceFlow;
                    [self.tableView reloadData];
                    
                } failure:^(NSError *error) {
                    self.riceFlow = [DataManager shareInstance].myRiceFlow;
                    [self.tableView reloadData];
                }];
            }else
            {
                [self.tableView reloadData];
            }
            
        }
            break;
        case 1:
            [self.tableView reloadData];
            break;
        case 2:
        {
            if (!self.favList) {
                [[DataManager shareInstance] requestForMyFavlist:0 limit:10 success:^() {
                    self.favList = [DataManager shareInstance].myFavList;
                    [self.tableView reloadData];
                } failure:^(NSError *error) {
                    self.favList = [DataManager shareInstance].myFavList;
                    [self.tableView reloadData];
                }];
            }else
            {
                [self.tableView reloadData];
            }
            
        }
            break;
        default:
            break;
    }
}

- (void)click:(NSInteger)type
{
    //NSLog(@"uuuuuuuuuu %d", type);
    [self refreshData:type];
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
