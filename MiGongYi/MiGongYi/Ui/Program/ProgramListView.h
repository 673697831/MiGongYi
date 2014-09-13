//
//  ProgramListView.h
//  MiGongYi
//
//  Created by megil on 9/3/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgramDetailsView.h"

@interface ProgramListView : UICollectionViewController
@property(nonatomic, strong) UIButton *whiteButton;
@property(nonatomic, strong) ProgramDetailsView *programDetailsView;
-(void)resetData:(NSMutableArray *)array Reset:(BOOL)reset;
@end
