//
//  MGYAboutMeViewController.m
//  MiGongYi
//
//  Created by megil on 9/14/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYAboutMeViewController.h"
#import "MGYBaseProgressView.h"
#import "Masonry.h"
#import "PersonalDetails.h"
#import "DataManager.h"

@interface MGYAboutMeViewController ()

@property(nonatomic, weak) UIView *statusBackgroundView;
@property(nonatomic, weak) MGYBaseProgressView *titleBackgroundView;
@property(nonatomic, weak) UILabel *backLabel;
@property(nonatomic, weak) UILabel *titleTextLabel;
@property(nonatomic, weak) UIImageView *childImageView;
@property(nonatomic, weak) UILabel *childLabel;
@property(nonatomic, weak) UILabel *nameLabel;
@property(nonatomic, weak) UIImageView *photoBackgroundView;
@property(nonatomic, weak) UIImageView *photoView;
@property(nonatomic, weak) UIImageView *editImageView;
@property(nonatomic, weak) UIImageView *settingImageView;
@property(nonatomic, weak) UITabBar *tabBar;
@end

@implementation MGYAboutMeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setup
{
    [self.statusBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(20);
    }];
    
    [self.titleBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(20);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(552/2);
    }];
    
    [self.backLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleBackgroundView.mas_top).with.offset(15);
        make.left.equalTo(self.titleBackgroundView.mas_left).with.offset(4);
        //make.width.mas_equalTo(15);
        //make.height.mas_equalTo(15);
    }];
    
    [self.titleTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleBackgroundView.mas_top).with.offset(15);
        make.left.equalTo(self.backLabel.mas_right).with.offset(0);
        
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titleBackgroundView.mas_bottom).with.offset(-144/2);
        make.centerX.equalTo(self.titleBackgroundView.mas_centerX);
    }];
    
    [self.childLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.nameLabel.mas_top).with.offset(-10);
        make.centerX.equalTo(self.titleBackgroundView.mas_centerX);
    }];
    
    [self.photoBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.childLabel.mas_top).with.offset(-10);
        make.centerX.equalTo(self.titleBackgroundView.mas_centerX);
    }];
    
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.photoBackgroundView.mas_centerX);
        make.centerY.equalTo(self.photoBackgroundView.mas_centerY);
    }];
    
    [self.editImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleBackgroundView.mas_right).with.offset(-172/2);
        make.top.equalTo(self.titleBackgroundView.mas_top).with.offset(130/2);
    }];
    
    [self.settingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleBackgroundView.mas_top).with.offset(98/2);
        make.right.equalTo(self.titleBackgroundView.mas_right).with.offset(-13);
    }];
    
    [self.tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titleBackgroundView.mas_bottom);
        make.left.equalTo(self.titleBackgroundView.mas_left);
        make.right.equalTo(self.titleBackgroundView);
        make.height.mas_equalTo(55);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //把navBar弄透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    UIView *statusBackgroundView = [UIView new];
    [self.view addSubview:statusBackgroundView];
    statusBackgroundView.backgroundColor = [UIColor blackColor];
    self.statusBackgroundView = statusBackgroundView;
    
    MGYBaseProgressView *titleBackgroundView = [MGYBaseProgressView new];
    [self.view addSubview:titleBackgroundView];
    self.titleBackgroundView = titleBackgroundView;
    
    UILabel *backLabel = [UILabel new];
    [self.view addSubview:backLabel];
    backLabel.font = [UIFont systemFontOfSize:16];
    backLabel.text = @"<";
    backLabel.textColor = [UIColor whiteColor];
    //backLabel.backgroundColor = [UIColor blackColor];
    self.backLabel = backLabel;
    
    UILabel *titleTextLabel = [UILabel new];
    [self.view addSubview:titleTextLabel];
    titleTextLabel.font = [UIFont systemFontOfSize:16];
    titleTextLabel.text = @"个人信息";
    titleTextLabel.textColor = [UIColor whiteColor];
    self.titleTextLabel = titleTextLabel;
    
    UILabel *nameLabel = [UILabel new];
    [self.view addSubview:nameLabel];
    nameLabel.text = @"mouji@ricedonate.com";
    nameLabel.font = [UIFont systemFontOfSize:11];
    nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel = nameLabel;
    
    UILabel *childLabel = [UILabel new];
    [self.view addSubview:childLabel];
    childLabel.font = [UIFont systemFontOfSize:16];
    childLabel.text = @"米公益小天使";
    childLabel.textColor = [UIColor whiteColor];
    self.childLabel = childLabel;
    
    UIImageView *photoBackgroundView = [UIImageView new];
    [self.view addSubview:photoBackgroundView];
    [photoBackgroundView setImage:[UIImage imageNamed:@"page_Photobackground_normal"]];
    self.photoBackgroundView = photoBackgroundView;
    
    UIImageView *photoView = [UIImageView new];
    [self.view addSubview:photoView];
    [photoView setImage:[UIImage imageNamed:@"page_Photo_normal"]];
    self.photoView = photoView;
    
    UIImageView *editImageView = [UIImageView new];
    [self.view addSubview:editImageView];
    [editImageView setImage:[UIImage imageNamed:@"page_edit2_nomal"]];
    self.editImageView = editImageView;
    
    UIImageView *settingImageView = [UIImageView new];
    [self.view addSubview:settingImageView];
    [settingImageView setImage:[UIImage imageNamed:@"page_setting_nomal"]];
    self.settingImageView = settingImageView;
    
    UITabBar *tabBar = [UITabBar new];
   // tabBar.frame = self.tabBar.frame;
    tabBar.tintColor = [UIColor whiteColor];
    [tabBar setBackgroundImage:[UIImage new]];
    [tabBar setShadowImage:[UIImage new]];
    tabBar.translucent = YES;
    tabBar.selectedImageTintColor = [UIColor orangeColor];
    
    UITabBarItem *tab1BarItem = [[UITabBarItem alloc] initWithTitle:@"获得米粒" image:[UIImage imageNamed:@"tab_rice_normal"] selectedImage:[UIImage imageNamed:@"tab_rice_selected"]];
    
    UITabBarItem *tab2BarItem = [[UITabBarItem alloc] initWithTitle:@"好友列表" image:[UIImage imageNamed:@"tabbar_Get rice_normal"] tag:1];
    UITabBarItem *tab3BarItem = [[UITabBarItem alloc] initWithTitle:@"收藏项目" image:[UIImage imageNamed:@"tabbar_Commonweal_normal"] tag:2];
    //UITabBarItem *tab4BarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"tabbar_Me_normal"] tag:3];
    tabBar.items = [NSArray arrayWithObjects:tab1BarItem, tab2BarItem, tab3BarItem, nil];
    tabBar.selectedItem = tab1BarItem;
    //tabBar.delegate = self;
    //tabBar.translucent = NO;
    [self.view addSubview:tabBar];
    self.tabBar = tabBar;
    
    [self setup];
    [[DataManager shareInstance] requestForPersonalDetails];
    //[self updateDetails];
//
//    self.titleBackgroundView = titleBackgroundView;
    // Do any additional setup after loading the view.
}

- (void)updatePersonalDetails
{
//    PersonalDetails *personalDetail = [DataManager shareInstance].personalDetails;
//    self.nameLabel.text = personalDetail.nickname;
//    [self.photoView setImage:[UIImage imageNamed:personalDetail.avatar]];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
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
