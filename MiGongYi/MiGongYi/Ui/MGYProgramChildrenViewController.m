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
    NSInteger index = indexPath.row + indexPath.section * 2;
    if ( index >= __array.count) {
        return cell;
    }
    
    [cell update:__array[index]];
    
    if (__array.count - index < 2*2) {
        if (self.isLoading) {
            return cell;
        }
        self.isLoading = YES;
        //[[DataManager shareInstance] RequestForList:2 Start:self.array.count Limit:10 Reset:NO];
    }
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return floor(__array.count/2);
    //return 10;
}

-(void) refreshView:(UIRefreshControl *)refreshControl
{
//    if (self.isLoading) {
//        return;
//    }
    self.isLoading = YES;
    [[DataManager shareInstance] requestForList:2 start:0 limit:10 reset:YES];
    //[refreshControl endRefreshing];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"留守儿童";
    __array = [NSMutableArray array];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake((320 - 10)/2, (548 - 48 - 40)/2 - 10 -2);
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 10, 0);
    
    UICollectionView *childrenCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + 20, self.view.frame.size.width, self.view.frame.size.height-49-self.navigationController.navigationBar.frame.size.height - 20) collectionViewLayout:layout];
    self.childrenCollectionView = childrenCollectionView;
    self.childrenCollectionView.delegate = self;
    self.childrenCollectionView.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    self.childrenCollectionView.dataSource = self;
    [self.childrenCollectionView registerClass:[MGYProgramListCell class] forCellWithReuseIdentifier:@"Children Cell"];
    [self.view addSubview:self.childrenCollectionView];
   
    //增加刷新控件
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    [self.childrenCollectionView addSubview:refreshControl];
    self.refreshControl = refreshControl;
    
    [[DataManager shareInstance] requestForList:2 start:0 limit:10 reset:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
