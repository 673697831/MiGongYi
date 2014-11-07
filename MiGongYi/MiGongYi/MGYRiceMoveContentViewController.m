//
//  MGYRiceMoveContentViewController.m
//  MiGongYi
//
//  Created by megil on 11/4/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceMoveContentViewController.h"
#import "Masonry.h"

@interface MGYRiceMoveContentViewController ()

@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UILabel *getRiceLabel;
@property (nonatomic, weak) UILabel *riceLabel;
@property (nonatomic, weak) UIButton *leftButton;
@property (nonatomic, weak) UIButton *rightButton;

@property (nonatomic, copy) MGYStorySelectCallback selectCallback;
@property (nonatomic, copy) MGYRiceMoveContentViewSelectCallback contentViewSelectCallback;
@property (nonatomic, copy) MGYRiceMoveContentViewDidDisappearCallback contentViewDidDisappearCallback;

@end

@implementation MGYRiceMoveContentViewController

- (instancetype)initWithSelectCallback:(MGYStorySelectCallback)selectCallback
             contentViewSelectCallback:(MGYRiceMoveContentViewSelectCallback)contentViewSelectCallback
       contentViewDidDisappearCallback:(MGYRiceMoveContentViewDidDisappearCallback)contentViewDidDisappearCallback
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
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    MGYStoryNode *_node = [MGYStoryPlayer defaultPlayer].playNode;
    
    UILabel *contentLabel = [UILabel new];
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:13];
    contentLabel.text = _node.storyContent;
    /**
     *  特殊处理 只有一处地方
     */
#warning 剧情
    if ([[MGYStoryPlayer defaultPlayer] isMizhiNode] && false) {
        MGYStoryBranch *branch = _node.branch[0];
        contentLabel.text = branch.content;
    }
    /**
     *  特殊处理 只有一处地方
     */
#warning 剧情
    if ([[MGYStoryPlayer defaultPlayer] isBoxingNode] && ![[MGYStoryPlayer defaultPlayer] isBoxingAndSelectNode] && false) {
        MGYStoryBranch *branch = _node.branch[0];
        contentLabel.text = branch.content;
    }
    
    [self.view addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UILabel *getRiceLabel = [UILabel new];
    getRiceLabel.font = [UIFont systemFontOfSize:15];
    getRiceLabel.text = @"你获得的米数为";
    getRiceLabel.textColor = [UIColor grayColor];
    [self.view addSubview:getRiceLabel];
    self.getRiceLabel = getRiceLabel;
    
    UILabel *riceLabel = [UILabel new];
    riceLabel.font = [UIFont systemFontOfSize:20];
    riceLabel.text = [NSString stringWithFormat:@"%d", _node.riceNum];
    riceLabel.textColor = [UIColor orangeColor];
    [self.view addSubview:riceLabel];
    self.riceLabel = riceLabel;
    
    UIButton *leftButton = [UIButton new];
    leftButton.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:leftButton];
    self.leftButton = leftButton;
    
    UIButton *rightButton = [UIButton new];
    rightButton.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:rightButton];
    self.rightButton = rightButton;
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(512/2);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.titleView.mas_bottom).with.offset(50);
    }];
    
    [getRiceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentLabel.mas_bottom).with.offset(50);
        make.centerX.equalTo(self.view);
    }];
    
    [riceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(getRiceLabel.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.view);
    }];
    
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
        make.left.equalTo(self.view).with.offset(20);
        make.bottom.equalTo(self.view).with.offset(-20);
    }];
    
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
        make.right.equalTo(self.view).with.offset(-20);
        make.bottom.equalTo(self.view).with.offset(-20);
    }];
    
    if (self.selectCallback && _node.branch.count > 1) {
        MGYStoryBranch *branch0 = _node.branch[0];
        MGYStoryBranch *branch1 = _node.branch[1];
        [leftButton addTarget:self
                       action:@selector(click:)
             forControlEvents:UIControlEventTouchUpInside];
        [leftButton setTitle:branch0.title
                    forState:UIControlStateNormal];
        [rightButton addTarget:self
                       action:@selector(click:)
             forControlEvents:UIControlEventTouchUpInside];
        [rightButton setTitle:branch1.title
                     forState:UIControlStateNormal];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (self.contentViewDidDisappearCallback) {
        self.contentViewDidDisappearCallback();
    }
}

- (void)click:(id)sender
{
    MGYStoryNode *_node = [MGYStoryPlayer defaultPlayer].playNode;
    
    if (self.selectCallback && _node.branch.count > 1) {
        MGYStoryBranch *branch0 = _node.branch[0];
        MGYStoryBranch *branch1 = _node.branch[1];
        
#warning 剧情
        if ([[MGYStoryPlayer defaultPlayer] isBoxingNode] ) {
            branch1 = _node.branch[2];
        }
        
        if (sender == self.leftButton) {
            self.selectCallback(branch0.identifier);
            if (self.contentViewSelectCallback) {
                self.contentViewSelectCallback(branch0.content);
            }
        }
        if (sender == self.rightButton) {
            self.selectCallback(branch1.identifier);
            if (self.contentViewSelectCallback) {
                self.contentViewSelectCallback(branch1.content);
            }
        }
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
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
