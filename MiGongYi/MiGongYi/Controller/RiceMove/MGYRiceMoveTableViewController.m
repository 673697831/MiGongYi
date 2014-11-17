//
//  MGYRiceMoveTableViewController.m
//  MiGongYi
//
//  Created by megil on 11/17/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceMoveTableViewController.h"
#import "MGYStoryPlayer.h"
#import "Masonry.h"

@interface MGYRiceMoveTableViewController ()

@property (nonatomic, assign) MGYRiceMoveTableViewType viewType;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, copy) MGYStorySelectCallback selectCallback;
@property (nonatomic, copy) MGYRiceMoveContentViewSelectCallback contentViewSelectCallback;
@property (nonatomic, copy) MGYRiceMoveContentViewDidDisappearCallback contentViewDidDisappearCallback;

@end

@implementation MGYRiceMoveTableViewController

- (instancetype)initWithSelectCallback:(MGYStorySelectCallback)selectCallback contentViewSelectCallback:(MGYRiceMoveContentViewSelectCallback)contentViewSelectCallback contentViewDidDisappearCallback:(MGYRiceMoveContentViewDidDisappearCallback)contentViewDidDisappearCallback
{
    self = [self init];
    if (self) {
        self.selectCallback = selectCallback;
        self.contentViewSelectCallback = contentViewSelectCallback;
        self.contentViewDidDisappearCallback = contentViewDidDisappearCallback;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITableView *tableView = [UITableView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[MGYRiceMoveContentTableViewCell class]
      forCellReuseIdentifier:@"ContentCell"];
    [tableView registerClass:[MGYRiceMoveSelectTableViewCell class]
      forCellReuseIdentifier:@"SelectCell"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.titleView);
        make.bottom.equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (self.contentViewDidDisappearCallback) {
        self.contentViewDidDisappearCallback();
    }
}

#pragma MGYRiceMoveTableViewCellDelegate

- (void)disappearFromClickButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)selectBranch:(MGYStoryBranch *)branch
{
    self.selectCallback(branch.identifier);
    self.contentViewSelectCallback(branch.content);
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //id cell;
    if (!self.contentViewSelectCallback) {
        MGYRiceMoveContentTableViewCell *tableViewCell =
        tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"ContentCell"
                                                        forIndexPath:indexPath];
        [tableViewCell reset];
        
        if (!tableViewCell.cellDelegate) {
            tableViewCell.cellDelegate = self;
        }
        return tableViewCell;
    }else
    {
        MGYRiceMoveSelectTableViewCell *tableViewCell =
        tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"SelectCell"
                                                        forIndexPath:indexPath];
        [tableViewCell reset];
        if (!tableViewCell.cellDelegate) {
            tableViewCell.cellDelegate = self;
        }
        return tableViewCell;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return CGRectGetHeight(self.view.bounds);
    MGYStoryNode *node = [MGYStoryPlayer defaultPlayer].playNode;
    CGSize labelSize = [node.storyContent boundingRectWithSize:CGSizeMake(552/2, NSNotFound) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} context:nil].size;
    NSLog(@"%f", labelSize.height);
    
    return [MGYRiceMoveTableViewCell minHeight] + labelSize.height;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
