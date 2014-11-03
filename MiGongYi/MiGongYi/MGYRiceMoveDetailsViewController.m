//
//  MGYRiceMoveDetailsViewController.m
//  MiGongYi
//
//  Created by megil on 11/3/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceMoveDetailsViewController.h"
#import "MGYRiceMoveMapTableViewCell.h"
#import "MGYRiceMoveContentTableViewCell.h"
#import "Masonry.h"
#import "MGYStoryPlayer.h"

#define MAX_MAP 8

@interface MGYRiceMoveDetailsViewController ()

@property (nonatomic, weak) UIButton *leftButton;
@property (nonatomic, weak) UIButton *rightButton;
@property (nonatomic, weak) UILabel *mapNameLabel;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIButton *lockButton;

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, assign) NSInteger curMapIndex;
@property (nonatomic, assign) NSInteger storyIndex;

@end

@implementation MGYRiceMoveDetailsViewController

- (instancetype)initWithMap:(NSInteger)index
{
    self = [self init];
    if (self) {
        self.storyIndex = index;
    }
    
    return  self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _imageArray = @[@"story1", @"story2", @"story3", @"story4", @"story5", @"story6", @"story7", @"story8"];
    UITableView *tableView = [UITableView new];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView registerClass:[MGYRiceMoveMapTableViewCell class]
      forCellReuseIdentifier:@"mapCell"];
    
    [tableView registerClass:[MGYRiceMoveContentTableViewCell class]
      forCellReuseIdentifier:@"contentCell"];
    
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tableView.delegate = self;
    tableView.dataSource  = self;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIButton *leftButton = [UIButton new];
    [leftButton setImage:[UIImage imageNamed:@"riceMoveIconLeft"]
                forState:UIControlStateNormal];
    self.leftButton = leftButton;
    [self.view addSubview:leftButton];
    
    UIButton *rightButton = [UIButton new];
    [rightButton setImage:[UIImage imageNamed:@"riceMoveIconRight"]
                 forState:UIControlStateNormal];
    self.rightButton = rightButton;
    [self.view addSubview:rightButton];
    
    UIButton *lockButton = [UIButton new];
    [lockButton addTarget:self
                   action:@selector(clickLock:)
         forControlEvents:UIControlEventTouchUpInside];
    //lockButton.hidden = YES;
    self.lockButton = lockButton;
    [self.view addSubview:lockButton];
    
    [leftButton addTarget:self
                   action:@selector(click:)
         forControlEvents:UIControlEventTouchUpInside];
    
    [rightButton addTarget:self
                    action:@selector(click:)
          forControlEvents:UIControlEventTouchUpInside];
    
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.titleView.mas_bottom).with.offset(50);
    }];
    
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.top.equalTo(self.titleView.mas_bottom).with.offset(50);
    }];
    
    [lockButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    
//    UILabel *mapNameLabel = [UILabel new];
//    mapNameLabel.backgroundColor = [UIColor blueColor];
//    mapNameLabel.textColor = [UIColor whiteColor];
//    mapNameLabel.text = @"abcde";
//    [self.view addSubview:mapNameLabel];
//    self.mapNameLabel = mapNameLabel;
    
    
}

- (void)click:(id)sender
{
    if (sender == self.leftButton) {
        if (_curMapIndex <= 0) {
            return ;
        }
        _curMapIndex = _curMapIndex - 1;
        
        [self refrush];
    }
    
    if (sender == self.rightButton) {
        if (_curMapIndex >= MAX_MAP - 1) {
            return ;
        }
        _curMapIndex = _curMapIndex + 1;
        
        [self refrush];
        
    }
    
}

- (void)clickLock:(id)sender
{
    NSLog(@"jjjjjjjjjjjjjjj");
}

- (void)refrush
{
    [self.tableView reloadData];
    if (_storyIndex < _curMapIndex) {
        [self.lockButton setImage:[UIImage imageNamed:@"lock1"]
                         forState:UIControlStateNormal];
        //self.lockButton.hidden = NO;
    }else
    {
        [self.lockButton setImage:[UIImage new]
                         forState:UIControlStateNormal];
        //self.lockButton.hidden = YES;
    }
}

#pragma mark - TableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MGYRiceMoveMapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mapCell" forIndexPath:indexPath];
        [cell resetMap:[UIImage imageNamed:_imageArray[_curMapIndex]]];
        return cell;
    }else
    {
        MGYRiceMoveContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contentCell" forIndexPath:indexPath];
        NSLog(@"%f", cell.bounds.size.width);
        MGYStoryNode *node = [MGYStoryPlayer defaultPlayer].actionNodeArray[indexPath.row];
        NSLog(@"string2 ===== %@", node.storyContent);
        [cell resetContent:node.storyContent];
        return cell;
    }
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 1136/2;
    }else
    {
        MGYStoryNode *node = [MGYStoryPlayer defaultPlayer].actionNodeArray[indexPath.row];
        NSString *string = node.storyContent;
        NSLog(@"string ===== %@", string);
        CGSize labelSize = [string boundingRectWithSize:CGSizeMake(self.tableView.bounds.size.width, NSNotFound) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} context:nil].size;
        return labelSize.height;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_storyIndex < _curMapIndex) {
        return  0;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else
    {
        return [MGYStoryPlayer defaultPlayer].playNode.identifier;
    }
    
    return 1;
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
