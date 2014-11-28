//
//  MainTabBar.m
//  MiGongYi
//
//  Created by megil on 9/3/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYTabBarController.h"
#import "MGYProgramChildrenViewController.h"
#import "MGYProgramItemViewController.h"
#import "MGYAboutMeViewController.h"
#import "MGYAboutMeViewController.h"
#import "MGYGetRiceViewController.h"
#import "MGYBaseViewController.h"
#import "MGYDonationViewController.h"

@interface MGYTabBarController ()

@property(nonatomic, weak) MGYProgramChildrenViewController *listView;
@property(nonatomic, weak) MGYProgramItemViewController *detailsView;
//@property(nonatomic, weak) MGYAboutMeViewController *aboutMeView;
@property(nonatomic, weak) MGYAboutMeViewController *aboutMeView;
@property(nonatomic, weak) MGYGetRiceViewController *getRiceView;

@end

@implementation MGYTabBarController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // TabBar1
        //tabBarController.tabBar.translucent = NO;
        
        //self.tabBar.translucent = NO;
        [self.tabBar setTintColor:[UIColor orangeColor]];
        UINavigationController *tab1Nav = [UINavigationController new];

//        MGYProgramChildrenViewController *listView = [MGYProgramChildrenViewController new];
//        //MGYBaseViewController *listView = [MGYBaseViewController new];
//        self.listView = listView;
        
        MGYDonationViewController *dvc = [MGYDonationViewController new];
        
        [tab1Nav pushViewController:dvc animated:YES];
        
        UINavigationController *tab2Nav = [UINavigationController new];
        MGYGetRiceViewController *getRiceView = [MGYGetRiceViewController new];
        [tab2Nav pushViewController:getRiceView animated:YES];
        self.getRiceView = getRiceView;
        
        UINavigationController *tab3Nav = [UINavigationController new];
        MGYProgramItemViewController *detailsView = [MGYProgramItemViewController new];
        [tab3Nav pushViewController:detailsView animated:YES];
        self.detailsView = detailsView;
        
        UINavigationController *tab4Nav = [UINavigationController new];
        //MGYAboutMeViewController *aboutMeView = [MGYAboutMeViewController new];
        MGYAboutMeViewController *aboutMeView = [MGYAboutMeViewController new];
        [tab4Nav pushViewController:aboutMeView animated:YES];
        self.aboutMeView = aboutMeView;
        
        
        
        self.tabBar.hidden = YES;
        self.viewControllers = [NSArray arrayWithObjects:tab1Nav, tab2Nav, tab3Nav, tab4Nav, nil];
       // NSLog(@"iiiiiiiii %@", tab1BarItem.);

    }
    return self;
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
    [self setSelectedIndex:item.tag];
}

@end
