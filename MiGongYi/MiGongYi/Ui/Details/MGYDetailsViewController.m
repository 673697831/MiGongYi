//
//  MGYDetailsViewController.m
//  MiGongYi
//
//  Created by megil on 9/18/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYDetailsViewController.h"
#import "MGYProjectDetailsTableViewCell.h"
#import "MGYProjectDevelopmentsTableViewCell.h"
#import "DataManager.h"
#import "Masonry.h"
#import "MGYProjectDetails.h"
#import "UIImageView+WebCache.h"
#import "UIColor+Expanded.h"
#import "MGYProjectRecent.h"

@interface MGYDetailsViewController ()
{
    NSMutableArray *_developmentList;
}

@property(nonatomic, strong) NSArray *developmentList;
@property(nonatomic, assign) BOOL isLoading;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.barView.hidden = YES;
    
    _developmentList = [NSMutableArray array];
    UITableView *tableView = [UITableView new];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView registerClass:[MGYProjectDevelopmentsTableViewCell class]
      forCellReuseIdentifier:@"developmentsTableView Cell"];
    [tableView registerClass:[MGYProjectDetailsTableViewCell class]
      forCellReuseIdentifier:@"detailsTableView Cell"];
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
    exchangeLabel.text = NSLocalizedString(@"立即兑换", @"立即兑换");
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
                                                  success:^{
                                                      MGYProjectDetails *details = [[DataManager shareInstance] getProjectDetailsById:self.projectId];
                                                      if (!details) {
                                                        #warning 未处理
                                                          return;
                                                      }
                                                      self.details = details;
                                                      self.title = details.title;
                                                      [self.tableView reloadData];
                                                      [self resetButtonStatus];
                                                  }
                                                  failure:^(NSError *error) {
                                                      
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
    if (sender == self.favButton) {
        if (self.details.fav == 0) {
            [[DataManager shareInstance] requestForAddfav:self.projectId
                                                  success:^{
                                                      self.details.fav = 1;
                                                      self.favButton.selected = YES;
                                                  } failure:^(NSError *error) {
                                                      
                                                  }];
        }else
        {
            [[DataManager shareInstance] requestForCancelFav:self.projectId
                                                     success:^{
                                                         self.details.fav = 0;
                                                         self.favButton.selected = NO;
                                                     } failure:^(NSError *error) {
                                                         
                                                     }];
        }

    }
}

- (void)resetButtonStatus
{
    self.favButton.selected = self.details.fav == 1 ? YES : NO;
    self.messageButton.selected = self.details.commentExist == 1 ? YES : NO;
    if (self.details.status == 0) {
        self.exchangeLabel.text = NSLocalizedString(@"项目已结束", @"项目已结束");
    }
    
}

- (CGFloat)labelHeightWithString:(NSString *)string
{
    CGSize labelSize = [string boundingRectWithSize:CGSizeMake(552/2, NSNotFound) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} context:nil].size;
    return labelSize.height;
}

- (void)requestForProjectRecent:(NSInteger)start
{
    self.isLoading = YES;
    [[DataManager shareInstance] requestForProjectRecent:self.projectId
                                                   start:start
                                                   limit:1
                                                 success:^{
                                                     self.isLoading = NO;
                                                     NSArray *array = [[DataManager shareInstance]getProjectRectById:self.projectId];
                                                     //NSLog(@"%@", array);
                                                     [_developmentList removeAllObjects];
                                                     [_developmentList addObjectsFromArray:array];
                                                     [self.tableView reloadData];
                                                 }
                                                 failure:^(NSError *error) {
                                                     
                                                 }];
}

#pragma mark - tableView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        MGYProjectDetailsTableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"detailsTableView Cell"
                                               forIndexPath:indexPath];
        if (self.details) {
            [cell reset:self.details];
        }
        
        if (self.developmentList.count == 0 && !self.isLoading && self.details) {
            [self requestForProjectRecent:0];
        }
        return cell;
        
    }else
    {
        MGYProjectDevelopmentsTableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"developmentsTableView Cell"
                                               forIndexPath:indexPath];
        if (self.developmentList[indexPath.row - 1]) {
            MGYProjectRecent *projectRecent = self.developmentList[indexPath.row - 1];
            [cell reset:projectRecent];
        }
        
        if (self.developmentList.count == indexPath.row && !self.isLoading) {
            [self requestForProjectRecent:indexPath.row];
        }
        return cell;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.developmentList.count + 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    height = height + tableView.bounds.size.width * 0.7;
    
    if (indexPath.row == 0) {
        height = height + [MGYProjectDetailsTableViewCell minHeight];
        
        if (self.details) {
            height = height + [self labelHeightWithString:self.details.summary];
        }
    }
    else
    {
        height = height + [MGYProjectDevelopmentsTableViewCell minHeight];
        
        if (self.developmentList[indexPath.row - 1]) {
            MGYProjectRecent *projectRecent = self.developmentList[indexPath.row - 1];
            height = height + [self labelHeightWithString:projectRecent.summary];
        }
    }
    return height;
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
