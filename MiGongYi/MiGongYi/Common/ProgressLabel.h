//
//  ProgressLabel.h
//  MiGongYi
//
//  Created by megil on 9/5/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressLabel : UILabel
@property(nonatomic, strong) CAGradientLayer* blackgroundLayer;
@property(nonatomic, strong) CAGradientLayer* progressLayer;
- (id)initWithFrame:(CGRect)frame BackgroundFrame:(CGRect)backgroundFrame;
- (void)resetProgress:(CGRect)frame;
@end
