//
//  MGYProgramChildrenViewController.m
//  MiGongYi
//
//  Created by megil on 9/12/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYProgramChildrenViewController.h"
#import "MGYProgramListCell.h"
#import "DataManager.h"
#import "UIColor+Expanded.h"
#import "MGYDetailsViewController.h"
#import "Masonry.h"

@interface MGYProgramChildrenViewController ()
{
    NSMutableArray *__array;
}
@property(nonatomic, assign) BOOL isEnd;//已显示全部
@property(nonatomic, weak) UICollectionView *childrenCollectionView;
@property(nonatomic, weak) UIRefreshControl *refreshControl;
@end

@implementation MGYProgramChildrenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isEnd = false;
    self.title = NSLocalizedString(@"留守儿童", "留守儿童");
    __array = [NSMutableArray array];
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    height = 568;
    layout.itemSize = CGSizeMake((width - 8)/2, (height - 64 - 49 - 16)/2);
    //layout.itemSize = CGSizeMake(316/2, )
    layout.minimumLineSpacing = 8;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UICollectionView *childrenCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    childrenCollectionView.alwaysBounceVertical = YES;
    self.childrenCollectionView = childrenCollectionView;
    self.childrenCollectionView.delegate = self;
    self.childrenCollectionView.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    self.childrenCollectionView.dataSource = self;
    [self.childrenCollectionView registerClass:[MGYProgramListCell class] forCellWithReuseIdentifier:@"Children Cell"];
    [self.view addSubview:self.childrenCollectionView];
    
    [self.childrenCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    //增加刷新控件
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    [self.childrenCollectionView addSubview:refreshControl];
    self.refreshControl = refreshControl;
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self refresh:0 limit:10 reset:YES];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setSelectedIndex:0];
    
}

- (void)refresh:(NSInteger)start
          limit:(NSInteger)limit
          reset:(BOOL)reset
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[DataManager shareInstance] requestForList:MGYProjectTypeChildren
                                          start:start
                                          limit:limit
                                          reset:reset
                                        success:^{
                                            __array = [NSMutableArray arrayWithArray:[DataManager shareInstance].childList];
                                            [self.childrenCollectionView reloadData];
                                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                                        }
                                        failure:^(NSError *error) {
                                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                                            if ([error.domain  isEqual: CustomErrorDomain]) {
                                                if (error.code == MGYMiListErrorEmpty) {
                                                   self.isEnd = YES;
                                                }
                                            }
                                        }];
}

- (void)resetData
{
    __array = [NSMutableArray arrayWithArray:[DataManager shareInstance].childList];
    [self.childrenCollectionView reloadData];
}

#pragma mark - MGYBaseViewControllerProtocol
- (void)refreshView:(UIRefreshControl *)refreshControl
{
    self.isEnd = false;
    [self refresh:0 limit:10 reset:YES];
    [refreshControl endRefreshing];
}

#pragma mark - collectionView delegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MGYProgramListCell *cell = (MGYProgramListCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Children Cell" forIndexPath:indexPath];
    if (indexPath.row >= __array.count) {
        return cell;
    }
    [cell reset:__array[indexPath.row]];
    if (!self.isEnd && __array.count == indexPath.row + 1) {
        [self refresh:__array.count + 1 limit:10 reset:NO];
    }
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return __array.count ;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MGYProject *project =__array[indexPath.row];
    MGYDetailsViewController *view = [[MGYDetailsViewController alloc]initWithProjectId:project.projectId];
    [self.navigationController pushViewController:view animated:YES];
    
}

@end
