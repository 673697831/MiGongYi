//
//  MGYRiceBoxingDisConnectView.h
//  MiGongYi
//
//  Created by megil on 12/1/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"

@protocol MGYRiceBoxingDisconnectDelegate <NSObject>

- (void)riceBoxingCansel;

- (void)riceBoxingConnect;

@end

@interface MGYRiceBoxingDisConnectView : UIView

@property (nonatomic, weak) id<MGYRiceBoxingDisconnectDelegate> disconnectDelegate;

- (void)show;

- (void)close;

@end
