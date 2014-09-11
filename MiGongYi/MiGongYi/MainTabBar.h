//
//  MainTabBar.h
//  MiGongYi
//
//  Created by megil on 9/3/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgramListView.h"
#import "DetailsMainView.h"
#import "ProgramDetailsView.h"
@interface MainTabBar : UITabBarController

@property(nonatomic, strong) UINavigationController *tab1Nav;
@property(nonatomic, strong) ProgramListView *listView;
@property(nonatomic, strong) UINavigationController *tab2Nav;
@property(nonatomic, strong) UINavigationController *tab3Nav;
@property(nonatomic, strong) DetailsMainView *detailsView;
@property(nonatomic, strong) UINavigationController *tab4Nav;
@property(nonatomic, strong) ProgramDetailsView *detailsSubView;

- (void)RefreshProgramListView:(int)type Reset:(BOOL)reset;
- (void)OpenDetailsSubView;
+(MainTabBar *)shareInstance;
@end
