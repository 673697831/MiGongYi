//
//  DetailsMainView.m
//  MiGongYi
//
//  Created by megil on 9/5/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "DetailsMainView.h"
#import "DetailsViewCell.h"
#import "UIColor+Expanded.h"
#import "TitleSubLayer.h"
#import "Project.h"
#import "DataManager.h"

@interface DetailsMainView ()
@property (nonatomic, strong) NSMutableArray* array;
@property(nonatomic, assign) BOOL isLoading;
@end

@implementation DetailsMainView

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.array = [NSMutableArray array];
        //self.refreshControl.hidden = YES;
        //self.tableView.contentInset = UIEdgeInsetsMake(64.f, 0.f, 0.f, 0.f);
        //self.refreshControl = [[UIRefreshControl alloc]init];
        //self.refreshControl.frame = CGRectMake(0, 0, 0, 0);
        //self.refreshControl.layer.zPosition = self.navigationController.navigationBar.layer.zPosition + 100;
        //self.refreshControl.backgroundColor = [UIColor clearColor];
        //self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
        //[self.refreshControl addTarget:self action:@selector(handleData) forControlEvents:UIControlEventValueChanged];
        
    }
    return self;
}

- (void) handleData
{
    if (self.isLoading) {
        return;
    }
    self.isLoading = YES;
    [[DataManager shareInstance] RequestForList:1 Start:0 Limit:3 Reset:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.title = @"公益项目";
    [self.tableView registerClass:[DetailsViewCell class] forCellReuseIdentifier:@"Details Cell"];
    
    CGRect frame = self.navigationController.navigationBar.frame;
    
    TitleSubLayer *gradient = [[TitleSubLayer alloc] initWithFrame:CGRectMake(0, -frame.origin.y, frame.size.width, frame.size.height + frame.origin.y)];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    [self.navigationController.navigationBar.layer insertSublayer:gradient atIndex:0];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [UIColor whiteColor], NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
   // NSLog(@"%d uuuu", self.array.count);
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    DetailsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Details Cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[DetailsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Details Cell" ];
       // cell = [[DetailsViewCell alloc] initwi];
    }
    
    [cell setDetails:self.array[indexPath.row]];
    if (!self.isLoading && self.array.count - indexPath.row > 1) {
        self.isLoading = YES;
        [[DataManager shareInstance] RequestForList:1 Start:self.array.count Limit:3 Reset:NO];
    }
    //NSLog(@"cellforrowatindexpath");
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (448 +200 +50)/2;
}

-(void)resetData:(NSMutableArray *)array Reset:(BOOL)reset
{
    if (reset) {
        [self.array removeAllObjects];
    }
    [self.array addObjectsFromArray:array];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
    self.isLoading = NO;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
