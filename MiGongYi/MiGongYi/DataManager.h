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
@property(nonatomic, readonly) NSMutableArray* projectList;
@property(nonatomic, readonly) NSMutableArray* childList;
@property(nonatomic, readonly) NSMutableArray* itemList;
-(void)AddProjects:(NSArray *)list Type:(int)type;
-(void)SetProjects:(NSArray *)list Type:(int)type Reset:(BOOL)reset;
+(DataManager *)shareInstance;
-(void)RequestForList:(int)type Start:(int)start Limit:(int)limit Reset:(BOOL)reset;
@end
