//
//  MGYNetManager.m
//  MiGongYi
//
//  Created by megil on 10/21/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYNetManager.h"
#import "MGYNetRequestSerializer.h"

@interface MGYNetManager ()

@property (nonatomic, strong) MGYNetRequestSerializer *requestSerializer;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation MGYNetManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.requestSerializer = [MGYNetRequestSerializer serializer];
        self.operationQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (MGYNetOperation *)GET:(NSString *)URLString
              parameters:(id)parameters
                 success:(MGYNetSuccess)success
                 failure:(MGYNetFailure)failure
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET"
                                                                   URLString:[[NSURL URLWithString:URLString] absoluteString]
                                                                  parameters:parameters];
    MGYNetOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    //[self.operationQueue addOperation:operation];
    return operation;
}

- (MGYNetOperation *)POST:(NSString *)URLString
               parameters:(id)parameters
                  success:(MGYNetSuccess)success
                  failure:(MGYNetFailure)failure
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST"
                                                                   URLString:[[NSURL URLWithString:URLString] absoluteString]
                                                                  parameters:parameters];
    MGYNetOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    //[self.operationQueue addOperation:operation];
    return operation;
}

- (MGYNetOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request
                                                    success:(void (^)(MGYNetOperation *operation, id responseObject))success
                                                    failure:(void (^)(MGYNetOperation *operation, NSError *error))failure
{
    MGYNetOperation *operation = [[MGYNetOperation alloc] initWithRequest:request];
    operation.success = success;
    operation.failure = failure;
    //[operation start];
    
    [self.operationQueue addOperation:operation];
    return operation;
}

+ (instancetype)manager
{
    return [MGYNetManager new];
}

@end
