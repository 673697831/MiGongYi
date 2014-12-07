//
//  MGYDonateDataManager.h
//  MiGongYi
//
//  Created by megil on 12/4/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataManager.h"
#import "MGYPublicFunction.h"

#import "MGYProtocolMyDonate.h"
#import "MGYPortocolInstantnews.h"

@class DataManager;

@interface MGYDonateDataManager : NSObject

@property (nonatomic, strong, readonly) MGYProtocolMyDonate *myDonate;
@property (nonatomic, strong, readonly) MGYPortocolInstantnews *instantnews;
@property (nonatomic, strong) MGYPortocolInstantnewsComment *myComment;

- (AFHTTPRequestOperation *)requestForMydonate:(MGYSuccess)success
                                       failure:(MGYFailure)failure;

- (AFHTTPRequestOperation *)requestForInstantnews:(MGYSuccess)success
                                          failure:(MGYFailure)failure;

- (AFHTTPRequestOperation *)requestForAddInstantnews:(NSString *)content
                                             success:(MGYSuccess)success
                                             failure:(MGYFailure)failure;

@end
