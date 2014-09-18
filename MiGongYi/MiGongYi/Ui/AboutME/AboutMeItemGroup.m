//
//  AboutMeItemGroup.m
//  MiGongYi
//
//  Created by megil on 9/18/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "AboutMeItemGroup.h"
#import "AboutMeItemView.h"

@interface AboutMeItemGroup ()
@property(nonatomic, strong) NSMutableArray *group;
@end

@implementation AboutMeItemGroup

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.group = [NSMutableArray array];
        NSLog(@"ttttttttttt");
    }
    return self;
}

- (void)addItems:(NSArray *)objects
{
    [self.group addObjectsFromArray:objects];
}

- (void)selectInIndex:(NSInteger)index
{
    for (int i=0; i < self.group.count; i ++) {
        AboutMeItemView *view = self.group[i];
        [view setSelect:i==index ? YES : NO];
    }
}

@end
