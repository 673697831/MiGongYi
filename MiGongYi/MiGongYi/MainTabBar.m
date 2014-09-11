//
//  MainTabBar.m
//  MiGongYi
//
//  Created by megil on 9/3/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MainTabBar.h"
#import "DataManager.h"
#import "TitleSubLayer.h"
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
        self.tab1Nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"留守儿童" image:[UIImage imageNamed:@"tabbar_Child_normal"] tag:1];
        self.listView = [[ProgramListView alloc] init];
        [self.tab1Nav pushViewController:self.listView animated:YES];
        //ProgramListView *listView = [[ProgramListView alloc] initWithNibName:nil bundle:nil];
        [self.tab1Nav setHidesBottomBarWhenPushed:YES];
        //[tab1Nav pushViewController:tab1 animated:NO];
        // TabBar2
        self.tab2Nav = [[UINavigationController alloc] init];
        self.tab2Nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"获得大米" image:[UIImage imageNamed:@"tabbar_Get rice_normal"] tag:2];
        // TabBar3
        
        self.tab3Nav = [[UINavigationController alloc] init];
        self.tab3Nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"公益项目" image:[UIImage imageNamed:@"tabbar_Commonweal_normal"] tag:3];
        self.detailsView = [[DetailsMainView alloc] initWithStyle:UITableViewStylePlain];
        [self.tab3Nav pushViewController:self.detailsView animated:YES];
        [self.tab3Nav setHidesBottomBarWhenPushed:YES];
        
        // TabBar4
        self.tab4Nav = [[UINavigationController alloc] init];
        self.tab4Nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"tabbar_Me_normal"] tag:4];
        
//        self.tab1Nav.navigationBar.hidden = YES;
//        
//        self.tab2Nav.navigationBar.hidden = YES;
//        self.tab3Nav.navigationBar.hidden = YES;
//        self.tab4Nav.navigationBar.hidden = YES;
        // 组装TabBar
        self.viewControllers = [NSArray arrayWithObjects:self.tab1Nav, self.tab2Nav, self.tab3Nav, self.tab4Nav, nil];
        
        self.detailsSubView = [[ProgramDetailsView alloc] initWithNibName:nil bundle:nil];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[DataManager shareInstance] RequestForList:2 Start:0 Limit:10 Reset:YES];
    [self.navigationController setHidesBottomBarWhenPushed:YES];
    [self initRecognizer];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)RefreshProgramListView:(int)type Reset:(BOOL)reset
{
    if (type == 1) {
        [self.detailsView resetData:[DataManager shareInstance].itemList Reset:YES];
    }
    if (type == 2) {
        //[self.listView resetData:[DataManager shareInstance].projectList];
        [self.listView resetData:[DataManager shareInstance].childList Reset:YES];
    }
    
}
- (void)OpenDetailsSubView
{
    [self.tab1Nav pushViewController:self.detailsSubView animated:YES];
}

//
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    NSLog(@"%@", sender);
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    // 留守儿童
    [self selectHandle:item.tag];
}

- (void)initRecognizer
{
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view] addGestureRecognizer:recognizer];
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [[self view] addGestureRecognizer:recognizer];
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    //[self inputANumber: -1];
    int index = self.selectedViewController.tabBarItem.tag;
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (index == 4) {
            return;
        }
        [self setSelectedIndex:index];
        
    }
    
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        if (index == 1) {
            return;
        }
        [self setSelectedIndex:index-2];
    }
}

-(void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    [self selectHandle:selectedIndex + 1];
}

-(void)selectHandle:(int)selectedIndex
{
    switch (selectedIndex) {
        case 1:
            [[DataManager shareInstance] RequestForList:2 Start:0 Limit:10 Reset:YES];
            break;
        case 2:
            break;
        case 3:
            [[DataManager shareInstance] RequestForList:1 Start:0 Limit:3 Reset:YES];
            break;
        case 4:
            break;
        default:
            break;
    }
    
}

@end
