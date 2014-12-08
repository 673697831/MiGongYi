//
//  ViewController.m
//  MiGongYi
//
//  Created by megil on 11/28/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYDonationViewController.h"
#import "Masonry.h"
#import "UIColor+Expanded.h"
#import "DataManager.h"
#import "MGYPortocolInstantnews.h"

@interface MGYDonationViewController ()

@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIView *textFieldView;
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UIButton *postButton;

@property (nonatomic, assign) CGRect originFrame;
@property (nonatomic, assign) BOOL setNeedsResetProgress;
@property (nonatomic, assign) NSInteger commentIndex;
@property (nonatomic, strong) MGYDonateDataManager *dataManager;
//
@property (nonatomic, strong) NSMutableArray *mutableComment;
@property (nonatomic, strong) MGYPortocolInstantnewsComment *comment;

@end

@implementation MGYDonationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mutableComment = [NSMutableArray array];
    
    self.setNeedsResetProgress = YES;
    
    UIView *containerView = [UIView new];
    [self.view addSubview:containerView];
    self.containerView = containerView;
    
    UITableView *tableView = [UITableView new];
    //tableView.backgroundColor = [UIColor yellowColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.contentInset = UIEdgeInsetsMake(- 64, 0, -49, 0);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[MGYDonationTableViewCell class]
      forCellReuseIdentifier:@"tableViewCell"];
    [self.containerView addSubview:tableView];
    self.tableView = tableView;
    
    UIView *textFieldView = [UIView new];
    textFieldView.backgroundColor = [UIColor colorWithHexString:@"f3f2f2"];
    [self.containerView addSubview:textFieldView];
    self.textFieldView = textFieldView;
    
    UITextField *textField = [UITextField new];
    textField.delegate = self;
    
    textField.font = [UIFont systemFontOfSize:9];
    textField.textColor = [UIColor colorWithHexString:@"838383"];
    [self.textFieldView addSubview:textField];
    self.textField = textField;
    
    UIButton *postButton = [UIButton new];
    [postButton setImage:[UIImage imageNamed:@"comment_button_normal"]
                forState:UIControlStateNormal];
    [postButton addTarget:self
                   action:@selector(sendComment)
         forControlEvents:UIControlEventTouchUpInside];
    [self.textFieldView addSubview:postButton];
    self.postButton = postButton;
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.titleView.mas_bottom);
        make.bottom.equalTo(self.barView.mas_top);
    }];
    
    [self.textFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView);
        make.right.equalTo(self.containerView);
        make.bottom.equalTo(self.barView.mas_top).with.offset(-7);
        make.height.mas_equalTo(25);
    }];
    
    [self.postButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.containerView).with.offset(-20);
        make.centerY.equalTo(self.textFieldView);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.textFieldView);
        make.height.equalTo(self.textFieldView);
        make.left.equalTo(self.containerView);
        make.right.equalTo(self.postButton.mas_left);
    }];
    
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.edges.equalTo(self.view);
        make.top.equalTo(self.containerView);
        make.left.equalTo(self.containerView);
        make.right.equalTo(self.containerView);
        make.bottom.equalTo(self.containerView);
    }];
    self.title = @"一键捐赠";
    
    self.dataManager = [DataManager shareInstance].donateDataManager;
    
    [MBProgressHUD showHUDAddedTo:self.containerView animated:YES];
//    [self.dataManager requestForMydonate:^{
//        [self.dataManager requestForInstantnews:^{
//            [self.tableView reloadData];
//            [MBProgressHUD hideHUDForView:self.containerView animated:YES];
//        } failure:^(NSError *error) {
//            [MBProgressHUD hideHUDForView:self.containerView animated:YES];
//        }];
//        
//    } failure:^(NSError *error) {
//        [MBProgressHUD hideHUDForView:self.containerView animated:YES];
//    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setSelectedIndex:0];
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.setNeedsResetProgress = YES;
}

- (void)sendComment
{
    if ([self.textField.text isEqualToString:@""]) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.containerView animated:YES];
    [self.dataManager requestForAddInstantnews:self.textField.text
                                       success:^{
                                           [MBProgressHUD hideHUDForView:self.containerView animated:YES];
                                       }
                                       failure:^(NSError *error) {
                                           [MBProgressHUD hideHUDForView:self.containerView animated:YES];
                                       }];
     self.textField.text = @"";
    
}

#pragma mark - MGYDonationCommentViewDelegate

- (void)finishMove
{
    [self.tableView reloadData];
}

#pragma mark - tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGYDonationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    MGYProtocolMyDonate *myDonate = self.dataManager.myDonate;
    MGYPortocolInstantnews *instantnews = self.dataManager.instantnews;
    if (self.setNeedsResetProgress && myDonate) {
        self.setNeedsResetProgress = NO;
        [cell reset:myDonate];
    }
    if (!cell.commentView.commentViewDelegate) {
        cell.commentView.commentViewDelegate = self;
    }
    
    if(!cell.donationCellDelegate){
        cell.donationCellDelegate = self;
    }
    if (instantnews) {
        NSArray *arrayComment = instantnews.rs;
        //显示没够6条
        MGYPortocolInstantnewsComment *comment = self.dataManager.myComment;
        if (self.mutableComment.count < 6) {
            NSInteger i;
            for (i = self.mutableComment.count; i < 6; i ++) {
                [self.mutableComment addObject:arrayComment[i]];
            }
            self.commentIndex = i;
            if (comment) {
                [self.mutableComment addObject:comment];
                self.commentIndex ++;
                self.dataManager.myComment = nil;
            }
        }else
        {
            [self.mutableComment removeObjectAtIndex:0];
            //网络缓存没有数据了 重新循环 
            self.commentIndex = self.commentIndex % arrayComment.count;
            if (comment) {
                [self.mutableComment addObject:comment];
                self.dataManager.myComment = nil;
            }else
            {
                [self.mutableComment addObject:arrayComment[self.commentIndex ++]];
            }
        }

        [cell resetComment:self.mutableComment];
    }
    //[cell move];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1000;
}

#pragma mark - UITextFieldDelegate

//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //CGRect frame = self.textFieldView.frame;
    CGRect frame = [textField convertRect:textField.frame toView:self.containerView];
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0){
        self.originFrame = self.containerView.frame;
        self.containerView.frame = CGRectMake(0.0f, -offset, self.containerView.frame.size.width, self.containerView.frame.size.height);
    }
    [UIView commitAnimations];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.containerView.frame = self.originFrame;
}

#pragma mark - scrollViewDeleagte
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint contentOffsetPoint = self.tableView.contentOffset;
    CGRect frame = self.tableView.frame;
    NSLog(@"%d", self.textField.isEditing);
    if ((contentOffsetPoint.y >= 400 && contentOffsetPoint.y))
    {
        NSLog(@"scroll to the end %f %f", contentOffsetPoint.y, frame.size.height);
        self.textFieldView.hidden = NO;
    }else
    {
        self.textFieldView.hidden = YES;
        [self textFieldShouldReturn:self.textField];
    }
}

#pragma mark - MGYDonationTableViewCellDelegate
- (void)openKeyBoard
{
    [self.tableView setContentOffset:CGPointMake(0, 410) animated:YES];
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
