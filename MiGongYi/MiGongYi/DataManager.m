//
//  DataManager.m
//  MiGongYi
//
//  Created by megil on 9/6/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "DataManager.h"
#import "AFNetworking.h"
#import "MGYTabBarController.h"
#import "MGYProjectDetails.h"

#define BaseURL @"http://api.ricedonate.com/ricedonate/htdocs/ricedonate/public"

@interface DataManager ()

@end


@implementation DataManager

//@synthesize personalDetails = __personalDetails;

+ (DataManager *)shareInstance
{
    static DataManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [DataManager new];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _itemList = [NSMutableArray new];
        _childList = [NSMutableArray new];
        
        NSInteger uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"uid"];
        if (uid) {
            self.uid = uid;
        }else
        {
            [self requestForEnterUID];
        }
    }
    return self;
}

- (void)addProjects:(NSArray *)list type:(MGYProjectType)type
{
    for (NSDictionary *dic in list) {
        MGYProject *newProject = [MTLJSONAdapter modelOfClass:[MGYProject class] fromJSONDictionary:dic error:nil];
        newProject.type = type;
        
        if (type == 1) {
            [_itemList addObject:newProject];
        }
        
        if (type == 2) {
            [_childList addObject:newProject];
        }
        
    }
}

- (void)setProjects:(NSArray *)list type:(MGYProjectType)type reset:(BOOL)reset
{
    if (reset) {
        if (type == MGYItemType) {
            [_itemList removeAllObjects];
        }
        if (type == MGYChildrenType) {
            [_childList removeAllObjects];
        }
    }
    [self addProjects:list type:type];
    //[[MGYTabBarController shareInstance] refreshProgramListView:type reset:reset];
}

- (void)requestForList:(MGYProjectType)type start:(NSInteger)start limit:(NSInteger)limit reset:(BOOL)reset success:(void (^)(NSArray *array))success
{
    NSString *url = @"http://api.ricedonate.com/ricedonate/htdocs/ricedonate/public/project.php?type=list";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"start":[NSNumber numberWithInteger:start], @"limit":[NSNumber numberWithInteger:limit], @"project_type":[NSNumber numberWithInteger:type]};
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        if ([responseObject[@"data"] isKindOfClass:[NSArray class]]) {
            //NSLog(@"%@", responseObject[@"data"]);
        }
        if ([responseObject[@"data"] count] == 0) {
            return;
        }
        //NSLog(@"%@", responseObject[@"data"][0]);
        [self setProjects:responseObject[@"data"] type:type reset:reset];
        success(type == MGYChildrenType ? self.childList : self.itemList);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)requestForEnterUID
{
    NSString *url = @"http://api.ricedonate.com/ricedonate/htdocs/ricedonate/public/user.php?type=reg&reg_type=startup";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        self.uid = [responseObject[@"data"][@"uid"] integerValue];
        [[NSUserDefaults standardUserDefaults] setInteger:self.uid forKey:@"uid"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)requestForPersonalDetails
{
    NSString *url = @"http://api.ricedonate.com/ricedonate/htdocs/ricedonate/public/user.php?type=detail";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:@{@"uid": @(self.uid)} success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        MGYPersonalDetails *newPersonalDetails = [MTLJSONAdapter modelOfClass:[MGYPersonalDetails class] fromJSONDictionary:responseObject[@"data"] error:nil];
        self.personalDetails = newPersonalDetails;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (void)requestForProjectDetails:(NSInteger)projectId
                         success:(void (^)(MGYProjectDetails *))success
{
    NSString *url = @"http://api.ricedonate.com/ricedonate/htdocs/ricedonate/public/project.php?type=detail";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:@{@"uid": @(self.uid), @"project_id":@(projectId)} success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        MGYProjectDetails *projectDetails = [MTLJSONAdapter modelOfClass:[MGYProjectDetails class] fromJSONDictionary:responseObject[@"data"] error:nil];
        success(projectDetails);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)requestForAddfav:(NSInteger)projectId success:(void (^)(NSInteger))success
{
    NSString *url = [BaseURL stringByAppendingString:@"/project.php?type=addfav"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:@{@"uid": @(self.uid), @"project_id":@(projectId)} success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        success([responseObject[@"error"] integerValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)requestForCancelFav:(NSInteger)projectId success:(void (^)(NSInteger))success
{
    NSString *url = [BaseURL stringByAppendingString:@"/project.php?type=cancelfav"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:@{@"uid": @(self.uid), @"project_id":@(projectId)} success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        success([responseObject[@"error"] integerValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)requestForProjectRecent:(NSInteger)projectId
                          start:(NSInteger)start
                          limit:(NSInteger)limit
                        success:(void (^)(NSArray *))success
{
    NSString *url = [BaseURL stringByAppendingString:@"/project.php?type=recentsituation"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"project_id":@(projectId), @"start":@(start), @"limit":@(limit)};
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        
        if ([responseObject[@"data"] count] == 0) {
            return ;
        }
        
        success(responseObject[@"data"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
