//
//  AboutMeItemGroup.m
//  MiGongYi
//
//  Created by megil on 9/18/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYAboutMeItemGroup.h"
#import "MGYAboutMeItemView.h"

@interface MGYAboutMeItemGroup ()
@property(nonatomic, strong) NSMutableArray *group;
@end

@implementation MGYAboutMeItemGroup

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.group = [NSMutableArray array];
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
        MGYAboutMeItemView *view = self.group[i];
        [view setSelect:i==index ? YES : NO];
    }
}

@end
