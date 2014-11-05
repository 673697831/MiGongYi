//
//  MGYNetOperation.m
//  MiGongYi
//
//  Created by megil on 10/21/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYNetOperation.h"

@interface MGYNetOperation ()

@property (nonatomic, copy) MGYNetOperationSuccess success;
@property (nonatomic, copy) MGYNetOperationFailure failure;
@property (nonatomic, strong) NSURLRequest *request;

- (void)start;

@end

@implementation MGYNetOperation

- (instancetype)initWithRequest:(NSURLRequest *)urlRequest
                        success:(MGYNetOperationSuccess)success
                        failure:(MGYNetOperationFailure)failure
{
    NSParameterAssert(urlRequest);
    
    self = [super init];
    if (self) {
		self.request = urlRequest;
        self.success = success;
        self.failure = failure;
    }
    return self;
}

- (void)start
{
    NSURLResponse *reponse;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:self.request returningResponse:&reponse error:&error];
    
    if (error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.failure(self, error);
        });
    }else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.success(self, [NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
        });
    }
    
}

@end
