//
//  MGYRiceMoveContentTableViewCell.m
//  MiGongYi
//
//  Created by megil on 11/3/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYRiceMoveContentTableViewCell.h"
#import "Masonry.h"

@interface MGYRiceMoveContentTableViewCell ()

@property (nonatomic, weak) UILabel *contentLabel;

@end

@implementation MGYRiceMoveContentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UILabel *contentLabel = [UILabel new];
        contentLabel.numberOfLines = 0;
        contentLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.edges.equalTo(self);
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
            make.width.equalTo(self);
        }];
        
    }
    return self;
}

- (void)resetContent:(NSString *)content
{
    self.contentLabel.text = content;
}

@end
