//
//  DataManager.h
//  MiGongYi
//
//  Created by megil on 9/6/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "MGYProject.h"
#import "MGYPersonalDetails.h"
#import "MGYProjectDetails.h"
#import "MGYRiceFlow.h"
#import "MGYMyFavList.h"
#import "MGYMiZhi.h"

@interface DataManager : NSObject
{
    NSMutableArray *_childList;
    NSMutableArray *_itemList;
    NSMutableArray *_projectDetailsList;
}

@property(nonatomic, readonly) NSArray* childList;
@property(nonatomic, readonly) NSArray* itemList;
@property(nonatomic, readonly) NSArray* projectDetailsList;
@property(nonatomic, strong) MGYPersonalDetails *personalDetails;
@property(nonatomic, assign) NSInteger uid;

typedef void (^MGYSuccess)();
typedef void (^MGYFailure)(NSError *);

+ (DataManager *)shareInstance;

- (MGYProjectDetails *)getProjectDetailsById:(NSInteger)projectId;
- (AFHTTPRequestOperation *)requestForList:(MGYProjectType)type
                start:(NSInteger)start
                limit:(NSInteger)limit
                reset:(BOOL)reset
              success:(MGYSuccess)success
              failure:(MGYFailure)failure;
- (AFHTTPRequestOperation *)requestForEnterUID;
- (AFHTTPRequestOperation *)requestForPersonalDetails;
- (AFHTTPRequestOperation *)requestForProjectDetails:(NSInteger) projectId
                                             success:(MGYSuccess)success
                                             failure:(MGYFailure)failure;
- (AFHTTPRequestOperation *)requestForAddfav:(NSInteger)projectId
                                     success:(MGYSuccess)success
                                     failure:(MGYFailure)failure;
- (AFHTTPRequestOperation *)requestForCancelFav:(NSInteger)projectId
                                        success:(MGYSuccess)success
                                        failure:(MGYFailure)failure;

- (void)requestForProjectRecent:(NSInteger)projectId
                          start:(NSInteger)start
                          limit:(NSInteger)limit
                        success:(void (^)(NSArray *array))success;
- (void)requestForRiceFlow:(NSInteger)start
                     limit:(NSInteger)limit
                   success:(void (^)(MGYRiceFlow *riceFlow))success
                   failure:(void (^)(MGYRiceFlow *riceFlow))failure;
- (void)requestForMyFavlist:(NSInteger)start
                      limit:(NSInteger)limit
                    success:(void (^)(MGYMyFavList *favList))success
                    failure:(void (^)(MGYMyFavList *favList))failure;
- (void)requestForMiZhi:(void (^)(MGYMiZhi *miZhi))success;


@end
