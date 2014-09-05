//
//  MainTabBar.m
//  MiGongYi
//
//  Created by megil on 9/3/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MainTabBar.h"
#import "ProgramListView.h"
#import "DetailsMainView.h"
@interface MainTabBar ()

@end

@implementation MainTabBar

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // TabBar1
        //tabBarController.tabBar.translucent = NO;
        self.tabBar.translucent = NO;
        [self.tabBar setTintColor:[UIColor orangeColor]];
        UINavigationController *tab1Nav = [[UINavigationController alloc] init];
        tab1Nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"留守儿童" image:[UIImage imageNamed:@"tabbar_Child_normal"] tag:0];
        
        ProgramListView *listView = [[ProgramListView alloc] init];
        //ProgramListView *listView = [[ProgramListView alloc] initWithNibName:nil bundle:nil];
        [tab1Nav pushViewController:listView animated:YES];
        [tab1Nav setHidesBottomBarWhenPushed:YES];
        //[tab1Nav pushViewController:tab1 animated:NO];
        
        // TabBar2

        UINavigationController *tab2Nav = [[UINavigationController alloc] init];
        tab2Nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"获得大米" image:[UIImage imageNamed:@"tabbar_Get rice_normal"] tag:0];
        // TabBar3
        
        UINavigationController *tab3Nav = [[UINavigationController alloc] init];
        tab3Nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"公益项目" image:[UIImage imageNamed:@"tabbar_Commonweal_normal"] tag:0];
        DetailsMainView *detailsView = [[DetailsMainView alloc] initWithStyle:UITableViewStylePlain];
        [tab3Nav pushViewController:detailsView animated:YES];
        [tab3Nav setHidesBottomBarWhenPushed:YES];
        
        // TabBar4
        UINavigationController *tab4Nav = [[UINavigationController alloc] init];
        tab4Nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"tabbar_Me_normal"] tag:0];
        
        //tab1Nav.navigationBar.hidden = YES;
        
        //tab2Nav.navigationBar.hidden = YES;
//tab3Nav.navigationBar.hidden = YES;
        //tab4Nav.navigationBar.hidden = YES;
        // 组装TabBar
        self.viewControllers = [NSArray arrayWithObjects:tab1Nav, tab2Nav, tab3Nav, tab4Nav, nil];

    }
    return self;
}

- (void)viewDidLoad
{
    self.navigationController.navigationBar.hidden = YES;
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
