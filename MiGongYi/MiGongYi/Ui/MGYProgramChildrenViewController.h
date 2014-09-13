//
//  MGYProgramChildrenViewController.h
//  MiGongYi
//
//  Created by megil on 9/12/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGYBaseViewController.h"

@interface MGYProgramChildrenViewController : MGYBaseViewController<UICollectionViewDataSource, UICollectionViewDelegate>

-(void)resetData:(NSArray *)array reset:(BOOL)reset;
@end
