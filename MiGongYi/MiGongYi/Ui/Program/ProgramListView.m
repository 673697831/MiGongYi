//
//  ProgramListView.m
//  MiGongYi
//
//  Created by megil on 9/3/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "ProgramListView.h"
#import "UIColor+Expanded.h"
#import "Masonry.h"
#import "ProgramListCell.h"
#import <QuartzCore/QuartzCore.h>
#import "TitleSubLayer.h"

@interface ProgramListView ()

@end

@implementation ProgramListView
@synthesize whiteButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 每一个网格的尺寸
    int tmp = 10;
    
    //NSLog(@"%f %f %f %f", frame.size.width, frame.size.height, frame.origin.x, frame.origin.y);
   // NSLog(@"%f", [UITabBar appearance].frame.size.height);
    //layout.itemSize = CGSizeMake((size.width-tmp)/2, (size.height-49-40) /2- tmp-1);
    layout.itemSize = CGSizeMake((320 - tmp)/2, (548 - 48 - 40)/2 - tmp -2);
    //layout.itemSize = CGSizeMake(150, 180);
    // 每一行之间的间距
    
    layout.minimumLineSpacing = 0;
    
    // 上下左右的间距
    
    layout.sectionInset = UIEdgeInsetsMake(0, 0, tmp, 0);
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title =@"留守儿童";
    
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    
    [self.collectionView registerClass:[ProgramListCell class] forCellWithReuseIdentifier:@"Programe Cell"];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    CGRect frame = self.navigationController.navigationBar.frame;
    
    TitleSubLayer *gradient = [[TitleSubLayer alloc] initWithFrame:CGRectMake(0,  -frame.origin.y, frame.size.width, frame.size.height + frame.origin.y)];
    [self.navigationController.navigationBar.layer insertSublayer:gradient atIndex:0];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [UIColor whiteColor], NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
//    CGFloat verticalOffset = -5;
//    [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:verticalOffset forBarMetrics:UIBarMetricsDefault];
    
    self.whiteButton = [[UIButton alloc] init];
    self.whiteButton.backgroundColor = [UIColor whiteColor];
    self.whiteButton.frame = CGRectMake(frame.size.width - 24 - 10, frame.size.height - 24 -10, 24, 24);
    [self.navigationController.navigationBar addSubview:self.whiteButton];
    
    NSLog(@"%f %f", self.view.frame.size.height, self.view.frame.size.width);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProgramListCell *cell = (ProgramListCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Programe Cell" forIndexPath:indexPath];
    //cell.backgroundColor = [UIColor orangeColor];
    return cell;
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
