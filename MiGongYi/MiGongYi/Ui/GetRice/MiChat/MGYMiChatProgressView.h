//
//  MiChatProgressView.h
//  MiGongYi
//
//  Created by megil on 10/8/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGYMiChatProgressView : UIView

- (instancetype)initWithImage:(NSString *)backgroundImageName
            progressImageName:(NSString *)progressImageName;

- (void)resetProgress:(CGFloat)progress;

@end
