//
//  DataManager.h
//  MiGongYi
//
//  Created by megil on 9/6/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"

@interface DataManager : NSObject
{
    NSMutableArray *__projectList;
    NSMutableArray *__childList;
    NSMutableArray *__itemList;
}
@property(nonatomic, readonly) NSArray* projectList;
@property(nonatomic, readonly) NSArray* childList;
@property(nonatomic, readonly) NSArray* itemList;

+ (DataManager *)shareInstance;

- (void)addProjects:(NSArray *)list
              type:(ProjectType)type;
- (void)setProjects:(NSArray *)list
              type:(ProjectType)type
             reset:(BOOL)reset;
- (void)requestForList:(ProjectType)type
                start:(NSInteger)start
                limit:(NSInteger)limit
                reset:(BOOL)reset;

@end
