//
//  DataManager.h
//  MiGongYi
//
//  Created by megil on 9/6/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"
#import "PersonalDetails.h"

@interface DataManager : NSObject
{
    NSMutableArray *__projectList;
    NSMutableArray *__childList;
    NSMutableArray *__itemList;
    //PersonalDetails *__personalDetails;
}
@property(nonatomic, readonly) NSArray* projectList;
@property(nonatomic, readonly) NSArray* childList;
@property(nonatomic, readonly) NSArray* itemList;
@property(nonatomic, weak) PersonalDetails *personalDetails;
@property(nonatomic, assign) NSInteger uid;

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
- (void)requestForEnterUID;
- (void)requestForPersonalDetails;
@end
