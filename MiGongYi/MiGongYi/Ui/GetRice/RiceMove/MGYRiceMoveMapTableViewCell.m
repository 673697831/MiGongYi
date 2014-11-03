//
//  TableViewCell.m
//  MiGongYi
//
//  Created by megil on 11/3/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceMoveMapTableViewCell.h"
#import "Masonry.h"

@interface MGYRiceMoveMapTableViewCell ()

@property (nonatomic, weak) UIImageView *mapView;

@end

@implementation MGYRiceMoveMapTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageView *mapView = [UIImageView new];
        [self addSubview:mapView];
        self.mapView = mapView;
        [mapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
    }
    return self;
}

- (void)resetMap:(UIImage *)image
{
    [_mapView setImage:image];
}


@end
