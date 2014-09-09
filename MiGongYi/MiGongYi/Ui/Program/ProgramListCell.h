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

-(void)setDetails:(Project *)args;
@property(nonatomic, strong) UIImageView *photoView;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *lineLabel1;
@property(nonatomic, strong) UILabel *lineLabel2;
@property(nonatomic, strong) ProgressLabel *progressLabel;
@property(nonatomic, strong) UIImageView *miliView;
@property(nonatomic, strong) UILabel *miliNum;
@property(nonatomic, strong) UILabel *miliLabel;
@property(nonatomic, strong) UIImageView *peopleView;
@property(nonatomic, strong) UILabel *peopleNum;
@property(nonatomic, strong) UILabel *poppleLable;
@property(nonatomic, assign) BOOL hasDrawn;
@end
