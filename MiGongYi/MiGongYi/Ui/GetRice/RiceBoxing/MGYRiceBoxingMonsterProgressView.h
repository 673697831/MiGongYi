//
//  MGYRiceBoxingMonsterProgressView.h
//  MiGongYi
//
//  Created by megil on 11/21/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MGYRiceBoxingMonsterProgressViewDelegate <NSObject>

- (void)clickFightButton;

@end

@interface MGYRiceBoxingMonsterProgressView : UIView

@property(nonatomic, weak) id<MGYRiceBoxingMonsterProgressViewDelegate> progressViewDelegate;


- (void)reset;

@end
