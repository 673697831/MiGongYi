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
@property(nonatomic, assign) BOOL isLoading;
@property(nonatomic, weak) UICollectionView *childrenCollectionView;
@property(nonatomic, weak) UIRefreshControl *refreshControl;
@end

@implementation MGYProgramChildrenViewController

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MGYProgramListCell *cell = (MGYProgramListCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Children Cell" forIndexPath:indexPath];
    //NSInteger index = indexPath.row + indexPath.section * 2;
//    if ( index >= __array.count) {
//        return cell;
//    }
    
    if (indexPath.row >= __array.count) {
        return cell;
    }
    [cell reset:__array[indexPath.row]];
//    
//    if (__array.count - index < 2*2) {
//        if (self.isLoading) {
//            return cell;
//        }
//        self.isLoading = YES;
//        //[[DataManager shareInstance] RequestForList:2 Start:self.array.count Limit:10 Reset:NO];
//    }
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return __array.count ;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //return floor(__array.count/2);
    //return 10;
    //return __array.count;
    return 1;
    
}

-(void) refreshView:(UIRefreshControl *)refreshControl
{
//    if (self.isLoading) {
//        return;
//    }
    self.isLoading = YES;
    [[DataManager shareInstance] requestForList:2 start:0 limit:10 reset:YES success:^(NSArray *array) {
        [self resetData:array reset:YES];
    }];
    //[refreshControl endRefreshing];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"留守儿童", "留守儿童");
    NSLocalizedString(@"我日", nil);
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
    
    [[DataManager shareInstance] requestForList:2 start:0 limit:10 reset:YES success:^(NSArray *array) {
        [self resetData:array reset:YES];
    }];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    // Do any additional setup after loading the view.
}

- (void)resetData:(NSMutableArray *)array reset:(BOOL)reset
{
    if (reset) {
        [__array removeAllObjects];
    }
    [__array addObjectsFromArray:array];
    [self.childrenCollectionView reloadData];
    self.isLoading = NO;
    [self.refreshControl endRefreshing];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MGYProject *project =__array[indexPath.row];
    MGYDetailsViewController *view = [[MGYDetailsViewController alloc]initWithProjectId:project.projectId];
    [self.navigationController pushViewController:view animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setSelectedIndex:0];
    
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    NSLog(@"%f %f", self.titleView.bounds.size.height, self.barView.bounds.size.height);
//}

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
