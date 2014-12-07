//
//  MGYDonateDataManager.m
//  MiGongYi
//
//  Created by megil on 12/4/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYDonateDataManager.h"

@interface MGYDonateDataManager ()

@property (nonatomic, assign) NSInteger progressId;
@property (nonatomic, strong) NSTimer *commentTimer;

@end

@implementation MGYDonateDataManager

- (NSString *)uid
{
    return [DataManager shareInstance].uid;
}

- (NSString *)baseUrl
{
    return [DataManager shareInstance].baseUrl;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.commentTimer = [NSTimer scheduledTimerWithTimeInterval:100
                                                             target:self
                                                           selector:@selector(requestForInstantnews)
                                                           userInfo:nil
                                                            repeats:YES];
    }
    return self;
}

- (AFHTTPRequestOperationManager *)requestManager
{
    return [DataManager shareInstance].requestManager;
}

- (AFHTTPRequestOperation *)requestForMydonate:(MGYSuccess)success
                                       failure:(MGYFailure)failure
{
    NSString *url = [[self baseUrl] stringByAppendingString:@"/project.php?type=mydonate"];
    AFHTTPRequestOperationManager *manager = self.requestManager;
    NSInteger progressId = 0;
    if (self.myDonate) {
        progressId = self.myDonate.projectId;
    }
    NSDictionary *parameters = @{@"uid":self.uid, @"project_id":@(progressId)};
    NSDictionary *md5Parameters = [MGYPublicFunction md5Parameters:parameters];
    return [manager GET:url
             parameters:md5Parameters
                success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                    if (![responseObject[@"error"] integerValue]) {
                        _myDonate = [MTLJSONAdapter modelOfClass:[MGYProtocolMyDonate class]
                                              fromJSONDictionary:responseObject[@"data"]
                                                           error:nil];
                        self.progressId = _myDonate.projectId;
                        if (success) {
                            success();
                        }
                    }
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    if (failure) {
                        failure(error);
                    }
                }];
}

- (AFHTTPRequestOperation *)requestForInstantnews:(MGYSuccess)success
                                          failure:(MGYFailure)failure
{
    NSString *url = [[self baseUrl] stringByAppendingString:@"/instantnews.php?type=list"];
    AFHTTPRequestOperationManager *manager = self.requestManager;
    if (!self.progressId) {
        return nil;
    }
    long long time = 0;
    if (self.instantnews) {
        time = self.instantnews.lastGetTime;
    }
    NSDictionary *parameters = @{@"uid":self.uid, @"project_id":@(self.progressId), @"last_get_time": @(time)};
    NSDictionary *md5Parameters = [MGYPublicFunction md5Parameters:parameters];
    return [manager GET:url
             parameters:md5Parameters
                success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                    if (![responseObject[@"error"] integerValue]) {
                        MGYPortocolInstantnews *instantnews = [MTLJSONAdapter modelOfClass:[MGYPortocolInstantnews class]
                                                                        fromJSONDictionary:responseObject[@"data"]
                                                                                     error:nil];
                        NSMutableArray *mutabelComment = [NSMutableArray arrayWithArray:instantnews.rs];
                        if (self.instantnews) {
                            [mutabelComment addObjectsFromArray:self.instantnews.rs];
                        }
                        
                        if (mutabelComment.count > 20) {
                            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(20, mutabelComment.count - 20)];
                            [mutabelComment removeObjectsAtIndexes:indexSet];
                        }
                        
                        instantnews.rs = mutabelComment;
                        
                        _instantnews = instantnews;
                        
                        if (success) {
                            success();
                        }
                        
                    }
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    if (failure) {
                        failure(error);
                    }
                }];
}

- (AFHTTPRequestOperation *)requestForAddInstantnews:(NSString *)content
                                             success:(MGYSuccess)success
                                             failure:(MGYFailure)failure
{
    NSString *url = [[self baseUrl] stringByAppendingString:@"/instantnews.php?type=add"];
    AFHTTPRequestOperationManager *manager = self.requestManager;
    NSInteger progressId = 0;
    if (self.myDonate) {
        progressId = self.myDonate.projectId;
    }
    NSDictionary *parameters = @{@"uid":self.uid, @"project_id":@(progressId), @"content":content};
    NSDictionary *md5Parameters = [MGYPublicFunction md5Parameters:parameters];
    return [manager GET:url
             parameters:md5Parameters
                success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                    if (![responseObject[@"error"] integerValue]) {
                        
                        _myComment = [MTLJSONAdapter modelOfClass:[MGYPortocolInstantnewsComment class]
                                               fromJSONDictionary:responseObject[@"data"]
                                                            error:nil];
                        NSLog(@"%@", _myComment);
                        if (success) {
                            success();
                        }
                    }
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    if (failure) {
                        failure(error);
                    }
                }];
}

- (void)requestForInstantnews
{
    [self requestForInstantnews:nil failure:nil];
}

@end
