//
//  MGYBaseViewController.m
//  MiGongYi
//
//  Created by megil on 9/12/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYBaseViewController.h"
#import "Masonry.h"

@interface MGYBaseViewController ()

@property(nonatomic, readonly) NSArray *itemList;

@end

@implementation MGYBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //把navBar弄透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    MGYBaseProgressView *titleView = [MGYBaseProgressView new];
    [self.view addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(CGRectGetHeight(self.navigationController.navigationBar.bounds) + 20);
        //make.height.mas_equalTo(64);
    }];
    self.titleView = titleView;
    
    // Do any additional setup after loading the view.
    //NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         //[UIColor whiteColor], NSForegroundColorAttributeName,nil];
    NSDictionary *dic = @{ NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    UITabBarItem *tab1BarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"首页TabBarItem1", @"留守儿童")
                                                              image:[[UIImage imageNamed:@"tabbar_Child_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_Child_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    tab1BarItem.tag = 0;
    UITabBarItem *tab2BarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"首页TabBarItem2", @"获得大米")
                                                              image:[[UIImage imageNamed:@"tabbar_Get rice_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"icon_get rice_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    tab2BarItem.tag = 1;
    UITabBarItem *tab3BarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"首页TabBarItem3", @"公益项目")
                                                              image:[[UIImage imageNamed:@"tabbar_Commonweal_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_Commonweal_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    tab3BarItem.tag = 2;
    UITabBarItem *tab4BarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"首页TabBarItem4", @"我")
                                                              image:[[UIImage imageNamed:@"tabbar_Me_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_Me_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    tab4BarItem.tag = 3;
    UITabBar *tabbar = [UITabBar new];
    //tabbar.frame = self.tabBarController.tabBar.frame;
    tabbar.tintColor = [UIColor whiteColor];
    _itemList = [NSArray arrayWithObjects:tab1BarItem, tab2BarItem, tab3BarItem, tab4BarItem, nil];
    tabbar.items = _itemList;
    tabbar.selectedItem = tab1BarItem;
    tabbar.delegate = self;
    tabbar.translucent = NO;
    [self.view addSubview:tabbar];
    self.barView = tabbar;

    [self.barView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(49);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.titleView];
    [self.view bringSubviewToFront:self.barView];
}

- (void)share:(id)sender
{
    
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    self.barView.selectedItem = self.barView.items[selectedIndex];
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    [self.tabBarController setSelectedIndex:item.tag];
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
