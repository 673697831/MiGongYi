//
//  MainNav.m
//  MiGongYi
//
//  Created by megil on 9/11/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MainNav.h"
#import "TitleSubLayer.h"

@interface MainNav ()

@end

@implementation MainNav

+ (MainNav*)shareInstance
{
    static MainNav *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MainNav alloc] initWithNibName:nil bundle:nil];
    });
    return instance;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    CGRect frame = self.navigationController.navigationBar.frame;
//    
//    TitleSubLayer *gradient = [[TitleSubLayer alloc] initWithFrame:CGRectMake(0,  -frame.origin.y, frame.size.width, frame.size.height + frame.origin.y)];
//    [self.navigationController.navigationBar.layer insertSublayer:gradient atIndex:0];
//    
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
//                         [UIColor whiteColor], NSForegroundColorAttributeName,nil];
//    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
