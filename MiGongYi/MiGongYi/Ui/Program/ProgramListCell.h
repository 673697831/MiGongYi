//
//  ProgramListCell.h
//  MiGongYi
//
//  Created by megil on 9/4/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressLabel.h"
#import "Project.h"

@interface ProgramListCell : UICollectionViewCell

-(void)update:(Project *)args;
@end
