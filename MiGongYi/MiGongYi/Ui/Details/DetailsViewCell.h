//
//  DetailsViewCell.h
//  MiGongYi
//
//  Created by megil on 9/5/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressLabel.h"
#import "DetailsIcon.h"
#import "Project.h"

@interface DetailsViewCell : UITableViewCell
-(void)setDetails:(Project *)args;
@property(nonatomic, strong) UIImageView *photoView;
@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) ProgressLabel *progressLabel;
@property(nonatomic, strong) DetailsIcon *detailsIconLeft;
@property(nonatomic, strong) DetailsIcon *detailsIconMiddle;
@property(nonatomic, strong) DetailsIcon *detailsIconRight;
@property(nonatomic, strong) UILabel *line1;
@property(nonatomic, strong) UILabel *line2;
@property(nonatomic, strong) UILabel *buttomLabel;
@end
