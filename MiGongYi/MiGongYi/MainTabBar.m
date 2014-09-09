//
//  MainTabBar.m
//  MiGongYi
//
//  Created by megil on 9/3/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MainTabBar.h"
#import "DataManager.h"
@interface MainTabBar ()

@end

@implementation MainTabBar

+ (MainTabBar *)shareInstance
{
    static MainTabBar *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MainTabBar alloc] initWithNibName:nil bundle:nil];
    });
    return instance;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // TabBar1
        //tabBarController.tabBar.translucent = NO;
        self.tabBar.translucent = NO;
        [self.tabBar setTintColor:[UIColor orangeColor]];
        self.tab1Nav = [[UINavigationController alloc] init];
        self.tab1Nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"留守儿童" image:[UIImage imageNamed:@"tabbar_Child_normal"] tag:0];
        self.listView = [[ProgramListView alloc] init];
        [self.tab1Nav pushViewController:self.listView animated:YES];
        //ProgramListView *listView = [[ProgramListView alloc] initWithNibName:nil bundle:nil];
        [self.tab1Nav setHidesBottomBarWhenPushed:YES];
        //[tab1Nav pushViewController:tab1 animated:NO];
        // TabBar2
        self.tab2Nav = [[UINavigationController alloc] init];
        self.tab2Nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"获得大米" image:[UIImage imageNamed:@"tabbar_Get rice_normal"] tag:0];
        // TabBar3
        
        self.tab3Nav = [[UINavigationController alloc] init];
        self.tab3Nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"公益项目" image:[UIImage imageNamed:@"tabbar_Commonweal_normal"] tag:0];
        self.detailsView = [[DetailsMainView alloc] initWithStyle:UITableViewStylePlain];
        [self.tab3Nav pushViewController:self.detailsView animated:YES];
        [self.tab3Nav setHidesBottomBarWhenPushed:YES];
        
        // TabBar4
        self.tab4Nav = [[UINavigationController alloc] init];
        self.tab4Nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"tabbar_Me_normal"] tag:0];
        
        //tab1Nav.navigationBar.hidden = YES;
        
        //tab2Nav.navigationBar.hidden = YES;
//tab3Nav.navigationBar.hidden = YES;
        //tab4Nav.navigationBar.hidden = YES;
        // 组装TabBar
        self.viewControllers = [NSArray arrayWithObjects:self.tab1Nav, self.tab2Nav, self.tab3Nav, self.tab4Nav, nil];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[DataManager shareInstance] RequestForList:2 Start:0 Limit:10];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)RefreshProgramListView
{
    [self.listView resetData:[DataManager shareInstance].projectList];
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
