
//
//  MGYRiceBoxingContentViewController.m
//  MiGongYi
//
//  Created by megil on 11/24/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceBoxingContentViewController.h"
#import "MGYRiceBoxingContentTableViewCell.h"
#import "Masonry.h"
#import "DataManager.h"

@interface MGYRiceBoxingContentViewController ()

@property (nonatomic, strong) MGYMonster *monster;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, assign) BOOL isSuccess;

@end

@implementation MGYRiceBoxingContentViewController

- (instancetype)initWithMonster:(MGYMonster *)monster
                      isSuccess:(BOOL)isSuccess
{
   self = [self init];
    if (self) {
        self.monster = monster;
        self.isSuccess = isSuccess;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [UITableView new];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[MGYRiceBoxingContentTableViewCell class]
      forCellReuseIdentifier:@"tableViewCell"];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // Do any additional setup after loading the view.
}

#pragma MGYGetRiceDisappearDelegate

- (void)disappearFromClickButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGYRiceBoxingContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"
                             forIndexPath:indexPath];
    if (!cell.disappearDelegate) {
        cell.disappearDelegate = self;
    }
    
    [cell setDetails:self.monster isSuccess:self.isSuccess];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"riceBoxingMonster%d", self.monster.monsterId]];
    if (self.monster.monsterType == MGYMonsterTypeLarge) {
        return [MGYRiceBoxingContentTableViewCell minHeight]+image.size.height;
    }
    MGYProtocolRiceBoxingObtain *obtain = [DataManager shareInstance].getRiceDataManager.riceBoxingObtain;
    CGFloat fontSize = [MGYRiceBoxingContentTableViewCell heightForDailyContent];
    CGFloat width = [MGYRiceBoxingContentTableViewCell widthForDailyContent];
    CGSize labelSize = [obtain.dailyTips boundingRectWithSize:CGSizeMake(width, NSNotFound) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]} context:nil].size;
    
    
    return labelSize.height + [MGYRiceBoxingContentTableViewCell minHeight]+image.size.height ;
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
