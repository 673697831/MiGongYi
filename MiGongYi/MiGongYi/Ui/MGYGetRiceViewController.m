//
//  MGYGetRiceViewController.m
//  MiGongYi
//
//  Created by megil on 9/15/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYGetRiceViewController.h"
#import "Masonry.h"

@interface MGYGetRiceViewController ()
@property(nonatomic, weak) UIImageView *backgroundImageView;
@property(nonatomic, weak) UIImageView *knowledgeImageView;
@property(nonatomic, weak) UIImageView *manImageView;
@property(nonatomic, weak) UIImageView *boxingView;
@property(nonatomic, weak) UIImageView *knowView;
@property(nonatomic, weak) UIImageView *shoeView;
@property(nonatomic, weak) UIImageView *phoneView;

@end

@implementation MGYGetRiceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setup:(CGFloat) offsetY
{
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    
    [self.knowledgeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.manImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.knowledgeImageView.mas_top).with.offset(30);
        make.width.mas_equalTo(398/2);
        make.height.mas_equalTo(808/2);
    }];
    
    [self.boxingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom).with.offset(274/2);
        make.left.equalTo(self.view.mas_left).with.offset(20);
    }];
    
    [self.shoeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom).with.offset(702/2 - offsetY);
        make.left.equalTo(self.view.mas_left).with.offset(20);
    }];
    
    
    [self.knowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom).with.offset(30);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom).with.offset(488/2);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.title = @"获取大米";
    
    UIImageView *backgroundImageView = [UIImageView new];
    [self.view addSubview:backgroundImageView];
    [backgroundImageView setImage:[UIImage imageNamed:@"page_background_normal"]];
    self.backgroundImageView = backgroundImageView;
    
    UIImageView *knowledgeImageView = [UIImageView new];
    [self.view addSubview:knowledgeImageView];
    [knowledgeImageView setImage:[UIImage imageNamed:@"page_knowledge_selected"]];
    self.knowledgeImageView = knowledgeImageView;
    
    UIImageView *manImageView = [UIImageView new];
    [self.view addSubview:manImageView];
    [manImageView setImage:[UIImage imageNamed:@"page_boy_normal@2x∏±±æ"]];
    self.manImageView = manImageView;
    
    UIImageView *boxingView = [UIImageView new];
    [self.view addSubview:boxingView];
    [boxingView setImage:[UIImage imageNamed:@"button_boxing_normal"]];
    self.boxingView = boxingView;
    
    UIImageView *shoeView = [UIImageView new];
    [self.view addSubview:shoeView];
    [shoeView setImage:[UIImage imageNamed:@"button_aerobic exercise_normal"]];
    self.shoeView = shoeView;
    
    UIImageView *knowView = [UIImageView new];
    [self.view addSubview:knowView];
    [knowView setImage:[UIImage imageNamed:@"button_knowledge_normal"]];
    self.knowView = knowView;
    
    UIImageView *phoneView = [UIImageView new];
    [self.view addSubview:phoneView];
    [phoneView setImage:[UIImage imageNamed:@"button_call_normal"]];
    self.phoneView = phoneView;
    [self setup:0];
    
    // Do any additional setup after loading the view.
}

- (void)animationBegin
{
    CGRect originFrame1 = self.shoeView.frame;
    CGRect originFrame2 = self.boxingView.frame;
    CGRect originFrame3 = self.knowView.frame;
    CGRect originFrame4 = self.phoneView.frame;
    
    [UIView animateWithDuration:1 animations:^{
        
        [UIView setAnimationRepeatCount:NSNotFound];
        [UIView setAnimationRepeatAutoreverses:YES];
        
        CGRect frame1 = self.shoeView.frame;
        frame1.origin.y = frame1.origin.y - 30;
        self.shoeView.frame = frame1;
        
        CGRect frame2 = self.boxingView.frame;
        frame2.origin.y = frame2.origin.y - 30;
        self.boxingView.frame = frame2;
        
        CGRect frame3 = self.knowView.frame;
        frame3.origin.y = frame3.origin.y - 30;
        self.knowView.frame = frame3;
        
        CGRect frame4 = self.phoneView.frame;
        frame4.origin.y = frame4.origin.y - 30;
        self.phoneView.frame = frame4;
    } completion:^(BOOL finished) {
        self.shoeView.frame = originFrame1;
        self.boxingView.frame = originFrame2;
        self.knowView.frame = originFrame3;
        self.phoneView.frame = originFrame4;
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    self.knowledgeImageView.hidden = YES;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [self animationBegin];
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
