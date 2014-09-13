//
//  MGYBaseProgressView.h
//  MiGongYi
//
//  Created by megil on 9/12/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGYBaseProgressView : UIView

@property(nonatomic, weak) CAGradientLayer *programLayer;

- (void)drawGradientLayer:(CGRect)rect;
@end
