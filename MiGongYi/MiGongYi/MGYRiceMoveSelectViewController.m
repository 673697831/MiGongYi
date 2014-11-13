//
//  MGYRiceMoveSelectViewController.m
//  MiGongYi
//
//  Created by megil on 11/10/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceMoveSelectViewController.h"

@interface MGYRiceMoveSelectViewController ()

@property (nonatomic, weak) IBOutlet UILabel *contentLabel;
@property (nonatomic, weak) IBOutlet UILabel *riceLabel;

@property (nonatomic, copy) MGYStorySelectCallback storySelectCallback;
@property (nonatomic, copy) MGYRiceMoveSelectViewSelectCallback selectViewSelectCallback;
@property (nonatomic, copy) MGYRiceMoveSelectViewDidDisappearCallback selectViewDidDisappearCallback;

@end

@implementation MGYRiceMoveSelectViewController

- (IBAction)leftClick:(id)sender {
    MGYStoryNode *node = [MGYStoryPlayer defaultPlayer].playNode;
    MGYStoryBranch *branch0 = node.branch[0];
    self.storySelectCallback(branch0.identifier);
    if (self.selectViewSelectCallback) {
        self.selectViewSelectCallback(branch0.content);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)rightClick:(id)sender {
    MGYStoryNode *node = [MGYStoryPlayer defaultPlayer].playNode;
    MGYStoryBranch *branch1 = node.branch[1];
    self.storySelectCallback(branch1.identifier);
    if (self.selectViewSelectCallback) {
        self.selectViewSelectCallback(branch1.content);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
    
    MGYStoryNode *node = [MGYStoryPlayer defaultPlayer].playNode;
    if(node.branch.count > 1 && self.storySelectCallback)
    {
        MGYStoryBranch *branch0 = node.branch[0];
        MGYStoryBranch *branch1 = node.branch[1];
        [self.leftButton setTitle:branch0.title
                    forState:UIControlStateNormal];
        [self.rightButton setTitle:branch1.title
                     forState:UIControlStateNormal];
    }
    self.contentLabel.text = node.storyContent;
    self.riceLabel.text = [NSString stringWithFormat:@"%ld", (long)node.riceNum];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if(self.selectViewDidDisappearCallback)
    {
        self.selectViewDidDisappearCallback();
    }
}

- (void)setCallback:(MGYStorySelectCallback)storySelectCallback selectViewSelectCallback:(MGYRiceMoveSelectViewSelectCallback)selectViewSelectCallback selectViewDidDisappearCallback:(MGYRiceMoveSelectViewDidDisappearCallback)selectViewDidDisappearCallback
{
    self.storySelectCallback = storySelectCallback;
    self.selectViewSelectCallback = selectViewSelectCallback;
    self.selectViewDidDisappearCallback = selectViewDidDisappearCallback;
}

@end
