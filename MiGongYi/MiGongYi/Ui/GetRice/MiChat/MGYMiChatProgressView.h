//
//  MiChatProgressView.h
//  MiGongYi
//
//  Created by megil on 10/8/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MGYMiChatProgressViewType) {
    MGYMiChatProgressViewType0,
    MGYMiChatProgressViewType1,
    MGYMiChatProgressViewType2,
    MGYMiChatProgressViewType3,
    MGYMiChatProgressViewType4,
    MGYMiChatProgressViewType5,
};

@interface MGYMiChatProgressView : UIView

- (void)resetProgress:(CGFloat)progress
                 type:(MGYMiChatProgressViewType)type;

- (void)clearImage;

@end
