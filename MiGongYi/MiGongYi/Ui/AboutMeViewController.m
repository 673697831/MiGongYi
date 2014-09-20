//
//  AboutMeViewController.m
//  MiGongYi
//
//  Created by megil on 9/19/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "AboutMeViewController.h"
#import "MGYBaseProgressView.h"
#import "Masonry.h"
#import "MGYPersonalDetails.h"
#import "DataManager.h"
#import "AboutMeItemView.h"
#import "AboutMeItemGroup.h"
#import "UIColor+Expanded.h"
#import "AboutME/AboutMeTableViewCell.h"

@interface AboutMeViewController ()

@property(nonatomic, copy) NSDictionary *dic;
@property(nonatomic, copy) NSDictionary *pathDic;
@property(nonatomic, weak) UIView *statusBackgroundView;
@property(nonatomic, weak) UIView *titleBackgroundView;
@property(nonatomic, weak) UILabel *backLabel;
@property(nonatomic, weak) UILabel *titleTextLabel;
@property(nonatomic, weak) UIView *tabView;
@property(nonatomic, weak) AboutMeItemView *riceItemView;
@property(nonatomic, weak) AboutMeItemView *friendItemView;
@property(nonatomic, weak) AboutMeItemView *favItemView;
@property(nonatomic, strong) AboutMeItemGroup *itemGroup;

@end

@implementation AboutMeViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"section0 Cell" forIndexPath:indexPath];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"tableView Cell" forIndexPath:indexPath];
    }
    return cell;
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
    tableView.delegate =self;
    tableView.dataSource = self;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableView Cell"];
    [tableView registerClass:[AboutMeTableViewCell class] forCellReuseIdentifier:@"section0 Cell"];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setSelectedIndex:3];
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
