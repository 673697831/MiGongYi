//
//  MGYRiceBoxingViewController.h
//  MiGongYi
//
//  Created by megil on 11/13/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGYSubViewController.h"
#import "MGYRiceBoxingMonsterProgressView.h"
#import "MGYRiceBoxingDisConnectView.h"

@interface MGYRiceBoxingViewController : MGYSubViewController<MGYRiceBoxingMonsterProgressViewDelegate, CustomIOS7AlertViewDelegate, MGYRiceBoxingDisconnectDelegate>

@end
