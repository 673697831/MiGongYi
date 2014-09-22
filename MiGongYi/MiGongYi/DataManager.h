//
//  DataManager.h
//  MiGongYi
//
//  Created by megil on 9/6/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGYProject.h"
#import "MGYPersonalDetails.h"
#import "MGYProjectDetails.h"

@interface DataManager : NSObject
{
    NSMutableArray *_childList;
    NSMutableArray *_itemList;
    //PersonalDetails *__personalDetails;
}

@property(nonatomic, readonly) NSArray* childList;
@property(nonatomic, readonly) NSArray* itemList;
@property(nonatomic, weak) MGYPersonalDetails *personalDetails;
@property(nonatomic, assign) NSInteger uid;

+ (DataManager *)shareInstance;

- (void)addProjects:(NSArray *)list
              type:(MGYProjectType)type;
- (void)setProjects:(NSArray *)list
              type:(MGYProjectType)type
             reset:(BOOL)reset;
- (void)requestForList:(MGYProjectType)type
                start:(NSInteger)start
                limit:(NSInteger)limit
                reset:(BOOL)reset
               success:(void (^)(NSArray *array))success;
- (void)requestForEnterUID;
- (void)requestForPersonalDetails;
- (void)requestForProjectDetails:(NSInteger) projectId
                         success:(void (^)(MGYProjectDetails *details))success;

@end
