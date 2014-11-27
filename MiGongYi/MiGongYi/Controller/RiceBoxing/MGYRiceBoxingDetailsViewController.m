//
//  MGYRiceBoxingDetailsViewController.m
//  MiGongYi
//
//  Created by megil on 11/14/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceBoxingDetailsViewController.h"
#import "MGYGetRiceDataManager.h"
#import "Masonry.h"
#import "UIColor+Expanded.h"

@interface MGYRiceBoxingDetailsViewController ()

@property (nonatomic, assign) NSInteger monsterId;
@property (nonatomic, copy) NSString *curFamilyName;
@property (nonatomic, assign) NSInteger maxIndex;
@property (nonatomic, assign) NSInteger curIndex;
@property (nonatomic, strong) NSMutableArray *mutableFamilyName;

@property (nonatomic, weak) UILabel *familyLabel;
@property (nonatomic, weak) UIButton *preButton;
@property (nonatomic, weak) UIButton *nextButton;
@property (nonatomic, weak) UITableView *detailsTableView;
@property (nonatomic, weak) MGYGetRiceDataManager *dataManager;

@end

@implementation MGYRiceBoxingDetailsViewController

- (instancetype)initWithMonsterId:(NSInteger)monsterId
{
    self = [self init];
    if (self) {
        
        self.dataManager = [DataManager shareInstance].getRiceDataManager;
        self.monsterId = monsterId;
        self.curIndex = monsterId / 3;
        NSArray *arrayMonster = self.dataManager.arrayRiceBoxingMonster;
        self.maxIndex = arrayMonster.count / 3;
        self.mutableFamilyName = [NSMutableArray array];
        for (int i = 0; i<arrayMonster.count; i++) {
            MGYMonster *monster = arrayMonster[i];
            if (self.mutableFamilyName.count && [self.mutableFamilyName[self.mutableFamilyName.count - 1] isEqualToString:monster.familyName]) {
                continue;
            }
            [self.mutableFamilyName addObject:monster.familyName];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    CGFloat scale = 2;
    UILabel *familyLabel = [UILabel new];
    familyLabel.font = [UIFont systemFontOfSize:32/scale];
    familyLabel.textAlignment = NSTextAlignmentCenter;
    familyLabel.textColor = [UIColor whiteColor];
    familyLabel.backgroundColor = [UIColor colorWithHexString:@"563765"];
    [self.view addSubview:familyLabel];
    self.familyLabel = familyLabel;
    
    UIButton *preButton = [UIButton new];
    [preButton setImage:[UIImage imageNamed:@"riceMoveIconLeft"]
               forState:UIControlStateNormal];
    [preButton addTarget:self
                  action:@selector(click:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:preButton];
    self.preButton = preButton;
    
    UIButton *nextButton = [UIButton new];
    [nextButton setImage:[UIImage imageNamed:@"riceMoveIconRight"]
                forState:UIControlStateNormal];
    [nextButton addTarget:self
                   action:@selector(click:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    self.nextButton = nextButton;
    
    UITableView *detailsTableView = [UITableView new];
    detailsTableView.delegate = self;
    detailsTableView.dataSource = self;
    //[detailsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    detailsTableView.separatorColor = [UIColor orangeColor];
    [detailsTableView registerClass:[MGYRiceBoxingDetailsTableViewCell class]
             forCellReuseIdentifier:@"detailsTableViewCell"];
    [self.view addSubview:detailsTableView];
    self.detailsTableView = detailsTableView;
    
    [self.familyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(92/scale);
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.titleView.mas_bottom);
    }];
    
    [self.preButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.familyLabel);
        make.left.equalTo(self.familyLabel).with.offset(20/scale);
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.familyLabel);
        make.right.equalTo(self.familyLabel).with.offset(-20/scale);
    }];
    
    [self.detailsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.familyLabel.mas_bottom);
        make.bottom.equalTo(self.view);
       // make.edges.equalTo(self.view);
    }];
    
    [self updateButonStatus];
    // Do any additional setup after loading the view.
}

- (void)click:(id)sender
{
    if (sender == self.preButton) {
        if (self.curIndex <= 0) {
            return;
        }
        self.curIndex --;
    }
    
    if (sender == self.nextButton) {
        if (self.curIndex >= self.maxIndex) {
            return;
        }
        self.curIndex ++;
    }
    
    [self updateButonStatus];
}

- (void)updateButonStatus
{
    self.preButton.hidden = NO;
    self.nextButton.hidden = NO;
    if (self.curIndex <= 0) {
        self.preButton.hidden = YES;
    }
    if (self.curIndex >= self.maxIndex) {
        self.nextButton.hidden = YES;
    }
    self.familyLabel.text = self.mutableFamilyName[self.curIndex];
    [self.detailsTableView reloadData];
}

#pragma MGYRiceBoxingDetailsTableViewCellDelegate

- (void)changeFollowMonster:(MGYMonster *)monster
           isSelectedStatus:(BOOL)isSelectedStatus
{
    if (monster.monsterType == MGYMonsterTypeSmall && monster.fightTimes >= 5) {
        NSInteger monsterId = isSelectedStatus? -1:monster.monsterId;
        [[DataManager shareInstance].getRiceDataManager setRiceBoxingFollowId:monsterId];
        [self.detailsTableView reloadData];
    }
}

#pragma tableView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGYRiceBoxingDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailsTableViewCell" forIndexPath:indexPath];
    NSInteger monsterId = self.curIndex * 3 + indexPath.row;
    MGYMonster *monster = self.dataManager.arrayRiceBoxingMonster[monsterId];
    if (!cell.cellDelegate) {
        cell.cellDelegate = self;
    }
    [cell setDetails:monster];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.curIndex == self.maxIndex ? 2 : 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger monsterId = self.curIndex * 3 + indexPath.row;
    MGYMonster *monster = self.dataManager.arrayRiceBoxingMonster[monsterId];
    
    if (monster.monsterStatus == MGYMonsterStatusLocked) {
        return [MGYRiceBoxingDetailsTableViewCell hideHeight];
    }
    
    CGSize labelSize = [monster.storyContent boundingRectWithSize:CGSizeMake(581.0/2, NSNotFound) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size;
    CGFloat skillHeight = 0;
    CGFloat conditionHeight = 0;
    if(monster.skillContent){
        NSString *string = [NSString stringWithFormat:@"跟随技能:%@", monster.skillContent];
        skillHeight = [string boundingRectWithSize:CGSizeMake(581.0/2, NSNotFound) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size.height;
    }
    if(monster.condition){
        NSString *string = [NSString stringWithFormat:@"特殊:%@", monster.condition];
        conditionHeight = [string boundingRectWithSize:CGSizeMake(581.0/2, NSNotFound) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size.height;
    }
    //UIImage *image = [UIImage imageNamed:monster.gayImagePath];
    return [MGYRiceBoxingDetailsTableViewCell minHeight] + labelSize.height + skillHeight + conditionHeight;
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
