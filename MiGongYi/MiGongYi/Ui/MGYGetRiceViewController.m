//
//  MGYGetRiceViewController.m
//  MiGongYi
//
//  Created by megil on 9/15/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYGetRiceViewController.h"
#import "Masonry.h"
#import "MGYMiZhiViewController.h"
#import "MGYMiChatViewController.h"
#define DIS 60

@interface MGYGetRiceViewController ()
@property(nonatomic, weak) UIImageView *backgroundImageView;
@property(nonatomic, weak) UIImageView *knowledgeImageView;
@property(nonatomic, weak) UIImageView *manImageView;
@property(nonatomic, weak) UIButton *boxingView;
@property(nonatomic, weak) UIButton *knowView;
@property(nonatomic, weak) UIButton *shoeView;
@property(nonatomic, weak) UIButton *phoneView;
@property(nonatomic, assign) BOOL isClicked;
@property(nonatomic, assign) NSInteger num;

@end

@implementation MGYGetRiceViewController

- (void)setup
{
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.titleView.mas_bottom);
        make.bottom.equalTo(self.barView.mas_top);
    }];
    
    [self.knowledgeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.manImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.knowledgeImageView.mas_top).with.offset(30);
        make.bottom.equalTo(self.barView.mas_top).with.offset(-30);
        //make.top.equalTo(self.knowledgeImageView.mas_top).with.offset(30 * rate);
        //make.width.mas_equalTo(398/2 * rate);
        //make.height.mas_equalTo(808/2 * rate);
    }];
    
    [self.boxingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom).with.offset(274/2);
        make.left.equalTo(self.view.mas_left).with.offset(20);
    }];
    
    [self.shoeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.barView.mas_top).with.offset(-30);
        make.left.equalTo(self.view.mas_left).with.offset(20);
    }];
    
    
    [self.knowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom).with.offset(30 + DIS/2);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
    
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.barView.mas_top).with.offset(-101 + DIS/2);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
    }];
}

- (UIButton *)creatMoveButton:(NSString *)path
                            tag:(int)tag
{
    UIButton *button = [UIButton new];
    button.tag = tag;
    button.adjustsImageWhenHighlighted = NO;
    [button setImage:[UIImage imageNamed:path] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickEventOnImage:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)clickEventOnImage:(id)sender
{
    
    if (self.isClicked) {
        return;
    }
    
    switch ([sender tag]) {
        case 1:
            [self.manImageView setImage:[UIImage imageNamed:@"page_boxing_selected@2x∏±±æ"]];
            self.boxingView.hidden = YES;
            break;
        case 2:
            [self.manImageView setImage:[UIImage imageNamed:@"page_aerobic exercise_selected@2x∏±±æ"]];
            self.shoeView.hidden = YES;
            break;
        case 3:
        {
            self.knowView.hidden = YES;
            self.knowledgeImageView.hidden = NO;
//            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1
//                                             target:self
//                                           selector:@selector(startTimer:)
//                                           userInfo:nil];
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                              target:self
                                                            selector:@selector(pushView)
                                                            userInfo:nil
                                                             repeats:YES];
            self.num = 0;
            [timer setFireDate:[NSDate distantPast]];
        }
            break;
        case 4:
        {
            self.phoneView.hidden = YES;
            [self.manImageView setImage:[UIImage imageNamed:@"page_call_selected@2x@png"]];
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                              target:self
                                                            selector:@selector(pushView)
                                                            userInfo:nil
                                                             repeats:YES];
            self.num = 0;
            [timer setFireDate:[NSDate distantPast]];
        }
            break;
        default:
            break;
    }
    self.isClicked = YES;
    [self pauseAllAnimation];
    
}

- (void)pushView
{
    if (self.num == 1) {
        MGYMiZhiViewController *miZhiView = [MGYMiZhiViewController new];
        [self.navigationController pushViewController:miZhiView animated:NO];
        //MGYMiChatViewController *miChatView = [MGYMiChatViewController new];
        //[self.navigationController pushViewController:miChatView animated:NO];
    }
    self.num ++;
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
    manImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.manImageView = manImageView;

    UIButton *boxingView = [self creatMoveButton:@"button_boxing_normal" tag:1];
    self.boxingView = boxingView;
    [self.view addSubview:self.boxingView];
    
    UIButton *shoeView = [self creatMoveButton:@"button_aerobic exercise_normal" tag:2];
    self.shoeView = shoeView;
    [self.view addSubview:self.shoeView];
    
    UIButton *knowView = [self creatMoveButton:@"button_knowledge_normal" tag:3];
    self.knowView = knowView;
    [self.view addSubview:self.knowView];
    
    UIButton *phoneView = [self creatMoveButton:@"button_call_normal" tag:4];
    self.phoneView = phoneView;
    [self.view addSubview:self.phoneView];
    
    [self setup];
    [self setSelectedIndex:1];
    
    // Do any additional setup after loading the view.
}

-(void)touchesPoint:(UITapGestureRecognizer *)gestureRecognizer
{
    CGPoint locationInView = [gestureRecognizer locationInView:self.view];
    //presentationLayer layer的动画层
    CALayer *layer1=[[self.boxingView.layer presentationLayer] hitTest:locationInView];
    if (layer1) {
        [self pauseAllAnimation];
        [self.manImageView setImage:[UIImage imageNamed:@"page_boxing_selected@2x∏±±æ"]];
        self.isClicked = YES;
        return;
    }
    
    CALayer *layer2=[[self.shoeView.layer presentationLayer] hitTest:locationInView];
    if (layer2) {
        [self pauseAllAnimation];
        [self.manImageView setImage:[UIImage imageNamed:@"page_aerobic exercise_selected@2x∏±±æ"]];
        self.isClicked = YES;
        return;
    }
    
    CALayer *layer3=[[self.knowView.layer presentationLayer] hitTest:locationInView];
    if (layer3) {
        [self pauseAllAnimation];
        self.knowledgeImageView.hidden = NO;
        self.isClicked = YES;
        return;
    }
    
    CALayer *layer4=[[self.phoneView.layer presentationLayer] hitTest:locationInView];
    if (layer4) {
        [self pauseAllAnimation];
        [self.manImageView setImage:[UIImage imageNamed:@"page_call_selected@2x@png"]];
        self.isClicked = YES;
        return;
    }
    
    //NSLog(@"%f %f", locationInView.x, locationInView.y);
}

- (void)removeAllAnimation
{
    [self.boxingView.layer removeAllAnimations];
    [self.shoeView.layer removeAllAnimations];
    [self.knowView.layer removeAllAnimations];
    [self.phoneView.layer removeAllAnimations];
}

- (void)pauseAllAnimation
{
    [self pauseLayer:self.boxingView.layer];
    [self pauseLayer:self.shoeView.layer];
    [self pauseLayer:self.knowView.layer];
    [self pauseLayer:self.phoneView.layer];
}

- (void)resumeAllAnimation
{
    [self resumeLayer:self.boxingView.layer];
    [self resumeLayer:self.shoeView.layer];
    [self resumeLayer:self.knowView.layer];
    [self resumeLayer:self.phoneView.layer];
}

- (void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

- (void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

- (void)animationBegin
{
    CGRect originFrame1 = self.boxingView.frame;
    CGRect originFrame2 = self.shoeView.frame;
    CGRect originFrame3 = self.knowView.frame;
    CGRect originFrame4 = self.phoneView.frame;
//    
//    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
//        [UIView setAnimationRepeatCount:NSNotFound];
//        [UIView setAnimationDelegate:self];
//        [UIView setAnimationRepeatAutoreverses:YES];
//        CGRect frame1 = self.shoeView.frame;
//        frame1.origin.y = frame1.origin.y - 30;
//        self.shoeView.frame = frame1;
//        
//        CGRect frame2 = self.boxingView.frame;
//        frame2.origin.y = frame2.origin.y - 30;
//        self.boxingView.frame = frame2;
//        
//        CGRect frame3 = self.knowView.frame;
//        frame3.origin.y = frame3.origin.y - 30;
//        self.knowView.frame = frame3;
//        
//        CGRect frame4 = self.phoneView.frame;
//        frame4.origin.y = frame4.origin.y - 30;
//        self.phoneView.frame = frame4;
//    } completion:^(BOOL finished) {
//        self.boxingView.frame = originFrame1;
//        self.shoeView.frame = originFrame2;
//        self.knowView.frame = originFrame3;
//        self.phoneView.frame = originFrame4;
//    }];
    
//    [UIView transitionWithView:self.view duration:1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
//        [UIView setAnimationRepeatCount:NSNotFound];
//        [UIView setAnimationRepeatAutoreverses:YES];
//        CGRect frame1 = self.shoeView.frame;
//        frame1.origin.y = frame1.origin.y - 30;
//        self.shoeView.frame = frame1;
//        
//        CGRect frame2 = self.boxingView.frame;
//        frame2.origin.y = frame2.origin.y - 30;
//        self.boxingView.frame = frame2;
//        
//        CGRect frame3 = self.knowView.frame;
//        frame3.origin.y = frame3.origin.y - 30;
//        self.knowView.frame = frame3;
//        
//        CGRect frame4 = self.phoneView.frame;
//        frame4.origin.y = frame4.origin.y - 30;
//        self.phoneView.frame = frame4;
//    } completion:^(BOOL finished) {
//        self.boxingView.frame = originFrame1;
//        self.shoeView.frame = originFrame2;
//        self.knowView.frame = originFrame3;
//        self.phoneView.frame = originFrame4;
//    }];
    
//    [UIView animateWithDuration:1 animations:^{
//        [UIView setAnimationRepeatCount:NSNotFound];
//        [UIView setAnimationRepeatAutoreverses:YES];
//        
//        CGRect frame1 = self.shoeView.frame;
//        frame1.origin.y = frame1.origin.y - 30;
//        self.shoeView.frame = frame1;
//        
//        CGRect frame2 = self.boxingView.frame;
//        frame2.origin.y = frame2.origin.y - 30;
//        self.boxingView.frame = frame2;
//        
//        CGRect frame3 = self.knowView.frame;
//        frame3.origin.y = frame3.origin.y - 30;
//        self.knowView.frame = frame3;
//        
//        CGRect frame4 = self.phoneView.frame;
//        frame4.origin.y = frame4.origin.y - 30;
//        self.phoneView.frame = frame4;
//    } completion:^(BOOL finished) {
//        self.shoeView.frame = originFrame1;
//        self.boxingView.frame = originFrame2;
//        self.knowView.frame = originFrame3;
//        self.phoneView.frame = originFrame4;
//    }];
    
    //[self.view.layer removeAllAnimations];
    
//    self.view.alpha = 0.0;
//    
//    [UIView beginAnimations:@"showView" context:nil];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDuration:1.0f];
//    [UIView setAnimationRepeatCount:NSNotFound];
//    [UIView setAnimationRepeatAutoreverses:YES];
//    
//    self.view.alpha = 1.0;
//    CGRect frame1 = self.shoeView.frame;
//    frame1.origin.y = frame1.origin.y - 30;
//    self.shoeView.frame = frame1;
//    //
//    CGRect frame2 = self.boxingView.frame;
//    frame2.origin.y = frame2.origin.y - 30;
//    self.boxingView.frame = frame2;
//    //
//    CGRect frame3 = self.knowView.frame;
//    frame3.origin.y = frame3.origin.y - 30;
//    self.knowView.frame = frame3;
//    //
//    CGRect frame4 = self.phoneView.frame;
//    frame4.origin.y = frame4.origin.y - 30;
//    self.phoneView.frame = frame4;
//    
//    [UIView commitAnimations];
    
//    CABasicAnimation *translation = [CABasicAnimation animationWithKeyPath:@"position"];
//    translation.duration = 1;
//    translation.repeatCount = NSNotFound;
//    translation.removedOnCompletion = NO;
//    translation.fillMode = kCAFillModeForwards;
//    translation.autoreverses = YES;
//    CGRect tmpFrame = originFrame1;
//    
//    translation.toValue = [NSValue valueWithCGPoint:CGPointMake(tmpFrame.origin.x + tmpFrame.size.width / 2, tmpFrame.origin.y - 30 + tmpFrame.size.height / 2)];
//    [self.boxingView.layer addAnimation:translation forKey:@"translation"];
//    
//    tmpFrame = originFrame2;
//    translation.toValue = [NSValue valueWithCGPoint:CGPointMake(tmpFrame.origin.x + tmpFrame.size.width / 2, tmpFrame.origin.y - 30 + tmpFrame.size.height / 2)];
//    [self.shoeView.layer addAnimation:translation forKey:@"translation"];
//    
//    tmpFrame = originFrame3;
//    translation.toValue = [NSValue valueWithCGPoint:CGPointMake(tmpFrame.origin.x + tmpFrame.size.width / 2, tmpFrame.origin.y - 30 + tmpFrame.size.height / 2)];
//    [self.knowView.layer addAnimation:translation forKey:@"translation"];
//    
//    tmpFrame = originFrame4;
//    translation.toValue = [NSValue valueWithCGPoint:CGPointMake(tmpFrame.origin.x + tmpFrame.size.width / 2, tmpFrame.origin.y - 30 + tmpFrame.size.height / 2)];
//    [self.phoneView.layer addAnimation:translation forKey:@"translation"];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];//设置view从初始位置经过一系列点
    CGFloat dis = DIS;
    animation.repeatCount = NSNotFound;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self resetAnimation:animation dis:dis originFrame:originFrame1];
    [self.boxingView.layer addAnimation:animation forKey:@"animation"]; //执行动画

    [self resetAnimation:animation dis:dis originFrame:originFrame2];
    [self.shoeView.layer addAnimation:animation forKey:@"animation"];
    
    [self resetAnimation:animation dis:dis originFrame:originFrame3];
    [self.knowView.layer addAnimation:animation forKey:@"animation"];
    
    [self resetAnimation:animation dis:dis originFrame:originFrame4];
    [self.phoneView.layer addAnimation:animation forKey:@"animation"];
    
}

- (void)resetAnimation:(CAKeyframeAnimation*) animation
                   dis:(NSInteger)dis
           originFrame:(CGRect)originFrame

{
    NSInteger offsetY = dis / 2;
    offsetY = arc4random() % offsetY;
    NSInteger dir = arc4random() % 2;
    CGFloat totalTime = (arc4random() % 300)/100 + 3;
    animation.duration = totalTime;
    animation.keyTimes = [self createTimes:offsetY dis:dis dir:dir];
    [animation setValues:[self createTrack:CGPointMake(originFrame.origin.x + originFrame.size.width / 2, originFrame.origin.y + originFrame.size.height / 2) offsetY:offsetY dis:dis dir:dir]];
}

- (NSArray *)createTrack:(CGPoint) buttomPoint
                 offsetY:(CGFloat) offsetY
                     dis:(CGFloat) dis
                     dir:(NSInteger) dir
{
    //向下
    if (dir == 0) {
        return @[[NSValue valueWithCGPoint:CGPointMake(buttomPoint.x, buttomPoint.y - offsetY)], [NSValue valueWithCGPoint:CGPointMake(buttomPoint.x, buttomPoint.y)], [NSValue valueWithCGPoint:CGPointMake(buttomPoint.x, buttomPoint.y - dis / 2)], [NSValue valueWithCGPoint:CGPointMake(buttomPoint.x, buttomPoint.y - offsetY)]];
    }else
    {
        return @[[NSValue valueWithCGPoint:CGPointMake(buttomPoint.x, buttomPoint.y - offsetY)], [NSValue valueWithCGPoint:CGPointMake(buttomPoint.x, buttomPoint.y - dis / 2)], [NSValue valueWithCGPoint:CGPointMake(buttomPoint.x, buttomPoint.y)], [NSValue valueWithCGPoint:CGPointMake(buttomPoint.x, buttomPoint.y - offsetY)]];
    }
//    return @[[NSValue valueWithCGPoint:CGPointMake(buttomPoint.x, buttomPoint.y)], [NSValue valueWithCGPoint:CGPointMake(buttomPoint.x, buttomPoint.y)], [NSValue valueWithCGPoint:CGPointMake(buttomPoint.x, buttomPoint.y - dis/2)], [NSValue valueWithCGPoint:CGPointMake(buttomPoint.x, buttomPoint.y)]];
}

- (NSArray *)createTimes:(CGFloat) offsetY
                     dis:(CGFloat) dis
                     dir:(NSInteger) dir
{
    //向下
    NSNumber *time1 = [NSNumber numberWithFloat:offsetY / dis ];
    if (dir == 1){
        time1 = [NSNumber numberWithFloat:0.5 - offsetY / dis];
    }
    NSNumber *time2 = [NSNumber numberWithFloat:([time1 floatValue] + 0.5)];
    return @[@0, time1, time2, @1];
   
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self removeAllAnimation];
    [self resumeAllAnimation];
    [self animationBegin];
    self.isClicked = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.knowledgeImageView.hidden = YES;
    [self showAllButton];
    [self.manImageView setImage:[UIImage imageNamed:@"page_boy_normal@2x∏±±æ"]];
    [super viewWillAppear:animated];
    [self setSelectedIndex:1];
}

- (void)showAllButton
{
    self.boxingView.hidden = NO;
    self.shoeView.hidden = NO;
    self.knowView.hidden = NO;
    self.phoneView.hidden = NO;
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
