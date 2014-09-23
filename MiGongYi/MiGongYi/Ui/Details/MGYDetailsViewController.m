//
//  MGYDetailsViewController.m
//  MiGongYi
//
//  Created by megil on 9/18/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYDetailsViewController.h"
#import "MGYProjectDetailsTableViewCell.h"
#import "DataManager.h"
#import "Masonry.h"
#import "MGYProjectDetails.h"
#import "UIImageView+WebCache.h"
#import "UIColor+Expanded.h"

@interface MGYDetailsViewController ()

@property(nonatomic, strong) MGYProjectDetails *details;
@property(nonatomic, assign) NSInteger projectId;
@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, weak) UIView *exchangeBackground;
@property(nonatomic, weak) UIButton *favButton;
@property(nonatomic, weak) UIButton *messageButton;
@property(nonatomic, weak) MGYBaseProgressView *exchangeButtonView;
@property(nonatomic, weak) UILabel *exchangeLabel;

@end

@implementation MGYDetailsViewController

- (instancetype)initWithProjectId:(NSInteger)projectId
{
    self = [super init];
    if (self) {
        self.projectId = projectId;
    }
    
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        MGYProjectDetailsTableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"detailsTableViewCell Cell"
                                               forIndexPath:indexPath];
        if (self.details) {
            [cell update:self.details];
        }
        
        return cell;
        
    }else
    {
        UITableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"tableView Cell"
                                               forIndexPath:indexPath];
        return cell;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
      // NSLog(@"uuuuuuuu %f", [])
        CGFloat height = 0;
        height = height + tableView.bounds.size.width * 0.7;
        height = height + 17;
        height = height + 20;
        height = height + 105;
        height = height + 15;
        //height = height + self.summaryLabel.bounds.size.height;
        if (self.details) {
             CGSize labelSize = [self.details.summary boundingRectWithSize:CGSizeMake(512/2, 5000) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} context:nil].size;
            height = height + labelSize.height;
        }
        height = height + 10;
        height = height + 35;
        height = height + 15;
        height = height + 15 + 10 + 10 + 15 + 52 + 20 + 55 + 40;
        return height;
    }
    return 44;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.barView.hidden = YES;
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"< 返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
//    backItem.tintColor = [UIColor whiteColor];
//    self.navigationItem.leftBarButtonItem = backItem;
    
    UITableView *tableView = [UITableView new];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[UITableViewCell class]
      forCellReuseIdentifier:@"tableView Cell"];
    [tableView registerClass:[MGYProjectDetailsTableViewCell class]
      forCellReuseIdentifier:@"detailsTableViewCell Cell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
   
    UIView *exchangeBackground = [UIView new];
    //exchangeBackground.layer.cornerRadius = 5;
    exchangeBackground.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    [self.view addSubview:exchangeBackground];
    self.exchangeBackground = exchangeBackground;
    
    UIButton *favButton = [UIButton new];
    favButton.tag = 1;
    [favButton addTarget:self action:@selector(selectButton:)
        forControlEvents:UIControlEventTouchUpInside];
    [favButton setImage:[UIImage imageNamed:@"tab_fav_selected"] forState:UIControlStateSelected];
    [favButton setImage:[UIImage imageNamed:@"tabbar_ fav_normal@"] forState:UIControlStateNormal];
    [self.view addSubview:favButton];
    self.favButton = favButton;
    
    MGYBaseProgressView *exchangeButtonView = [MGYBaseProgressView new];
    exchangeButtonView.cornerRadius = 10;
    exchangeButtonView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:exchangeButtonView];
    self.exchangeButtonView = exchangeButtonView;
    
    UILabel *exchangeLabel = [UILabel new];
    exchangeLabel.text = @"立即兑换";
    exchangeLabel.font = [UIFont systemFontOfSize:16];
    exchangeLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:exchangeLabel];
    self.exchangeLabel = exchangeLabel;
    
    UIButton *messageButton = [UIButton new];
    messageButton.tag = 2;
    [messageButton addTarget:self action:@selector(selectButton:)
            forControlEvents:UIControlEventTouchUpInside];
    [messageButton setImage:[UIImage imageNamed:@"tabbar_ message_normal"]
                   forState:UIControlStateNormal];
    [messageButton setImage:[UIImage imageNamed:@"tabbar_ message_selected"]
                   forState:UIControlStateSelected];
    [self.view addSubview:messageButton];
    self.messageButton = messageButton;
    
    [self setup];
    [[DataManager shareInstance] requestForProjectDetails:self.projectId
                                                  success:^(MGYProjectDetails *details) {
                                                      //NSLog(@"ooooooo %@", details);
                                                      self.details = details;
                                                      [self.tableView reloadData];
                                                  }];
}

- (void)setup
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.exchangeBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(40);
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    [self.favButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(24);
        make.height.mas_equalTo(24);
        make.centerY.equalTo(self.exchangeBackground.mas_centerY);
        make.left.equalTo(self.exchangeBackground.mas_left).with.offset(self.view.bounds.size.width/2 - 552/2/2);
    }];
    
    [self.exchangeButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(286/2);
        make.height.mas_equalTo(72/2);
        make.centerX.equalTo(self.exchangeBackground);
        make.centerY.equalTo(self.exchangeBackground);
    }];
    
    [self.exchangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.exchangeButtonView);
        make.centerY.equalTo(self.exchangeButtonView);
    }];
    
    [self.messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(24);
        make.height.mas_equalTo(24);
        make.centerY.equalTo(self.exchangeBackground.mas_centerY);
        make.right.equalTo(self.exchangeBackground.mas_right).with.offset(- self.view.bounds.size.width/2 + 552/2/2);
    }];
    
}

- (void)selectButton:(id)sender
{
    switch ([sender tag]) {
        case 1:
            if (self.details.fav == 0) {
                [[DataManager shareInstance] requestForAddfav:self.details.projectId];
            }else
            {
            
            }
            break;
        case 2:
            break;
        default:
            break;
    }
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
