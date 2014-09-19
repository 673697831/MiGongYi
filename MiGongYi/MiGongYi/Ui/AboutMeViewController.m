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

@interface AboutMeViewController ()

@property(nonatomic, copy) NSDictionary *dic;
@property(nonatomic, copy) NSDictionary *pathDic;
@property(nonatomic, weak) UIView *statusBackgroundView;
@property(nonatomic, weak) UIView *titleBackgroundView;
@property(nonatomic, weak) UILabel *backLabel;
@property(nonatomic, weak) UILabel *titleTextLabel;
@property(nonatomic, weak) UIImageView *childImageView;
@property(nonatomic, weak) UILabel *childLabel;
@property(nonatomic, weak) UILabel *nameLabel;
@property(nonatomic, weak) UIImageView *photoBackgroundView;
@property(nonatomic, weak) UIImageView *photoView;
@property(nonatomic, weak) UIImageView *editImageView;
@property(nonatomic, weak) UIImageView *settingImageView;
@property(nonatomic, weak) UIView *tabView;
@property(nonatomic, weak) AboutMeItemView *riceItemView;
@property(nonatomic, weak) AboutMeItemView *friendItemView;
@property(nonatomic, weak) AboutMeItemView *favItemView;
@property(nonatomic, strong) AboutMeItemGroup *itemGroup;

@end

@implementation AboutMeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.titleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(552/2);
    }];
    
    UITableView *tableView = [UITableView new];
    [self.view addSubview:tableView];
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
