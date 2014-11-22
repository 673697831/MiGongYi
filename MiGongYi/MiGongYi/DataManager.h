//
//  DataManager.h
//  MiGongYi
//
//  Created by megil on 9/6/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "MGYGetRiceDataManager.h"
#import "MGYProject.h"
#import "MGYPersonalDetails.h"
#import "MGYProjectDetails.h"
#import "MGYRiceFlow.h"
#import "MGYMyFavList.h"
#import "MGYMiZhi.h"
#import "MGYError.h"
#import "MGYTotalWalk.h"

@class MGYGetRiceDataManager;

@interface DataManager : NSObject

@property(nonatomic, readonly) NSArray* childList;
@property(nonatomic, readonly) NSArray* itemList;
@property(nonatomic, readonly) NSArray* projectDetailsList;
@property(nonatomic, strong) MGYPersonalDetails *personalDetails;
@property(nonatomic, readonly) MGYMiZhi* miZhi;
@property(nonatomic, copy) NSString *uid;
@property(nonatomic, readonly) MGYRiceFlow *myRiceFlow;
@property(nonatomic, readonly) MGYMyFavList *myFavList;
@property(nonatomic, readonly) NSArray* miChatRecordList;
@property(nonatomic, assign) BOOL canGainRiceFromMiChat;
@property(nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property(nonatomic, strong, readonly) NSDictionary *walkAmount;
@property(nonatomic, strong) MGYTotalWalk *totalWalk;
@property(nonatomic, strong) AFHTTPRequestOperationManager *requestManager;
@property (nonatomic, strong) MGYGetRiceDataManager *getRiceDataManager;

typedef void (^MGYSuccess)();
typedef void (^MGYGainRiceSuccess)(NSInteger);
typedef void (^MGYFailure)(NSError *);

+ (DataManager *)shareInstance;

- (MGYProjectDetails *)getProjectDetailsById:(NSInteger)parentId;
- (NSArray *)getProjectRectById:(NSInteger)projectId;
- (void)saveMiChatRecord:(NSArray *)miChatRecordList;
- (void)loadMiChatRecord:(MGYSuccess)success
                 failure:(MGYFailure)failure;
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
- (AFHTTPRequestOperation *)requestForProjectRecent:(NSInteger)projectId
                          start:(NSInteger)start
                          limit:(NSInteger)limit
                        success:(MGYSuccess)success
                        failure:(MGYFailure)failure;
- (AFHTTPRequestOperation *)requestForRiceFlow:(NSInteger)start
                     limit:(NSInteger)limit
                   success:(MGYSuccess)success
                   failure:(MGYFailure)failure;
- (AFHTTPRequestOperation *)requestForMyFavlist:(NSInteger)start
                      limit:(NSInteger)limit
                    success:(MGYSuccess)success
                    failure:(MGYFailure)failure;
- (AFHTTPRequestOperation *)requestForMiZhi:(MGYSuccess)success
                                    failure:(MGYFailure)failure;

- (AFHTTPRequestOperation *)gainRiceFromMiChat:(MGYGainRiceSuccess)success
                                    failure:(MGYFailure)failure;

- (void)saveRiceWalk:(MGYTotalWalk *)totalWalk;

- (NSString *)baseUrl;

- (NSString *)libraryPath;

- (NSString *)filePath;

//- (AFHTTPRequestOperation *)requestForWeibo:(MGYSuccess)success
//                                    failure:(MGYFailure)failure;


@end
