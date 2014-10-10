//
//  DataManager.m
//  MiGongYi
//
//  Created by megil on 9/6/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "DataManager.h"
#import "MGYTabBarController.h"
#import "MGYProjectDetails.h"
#define fuck 1

#define BaseURL @"http://api.ricedonate.com/ricedonate/htdocs/ricedonate/public"

@interface DataManager ()

@property(nonatomic, strong) MGYRiceFlow *myRiceFlow;
@property(nonatomic, strong) MGYMyFavList *myFavList;

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

- (instancetype)init
{
    self = [super init];
    if (self) {
        _itemList = [NSMutableArray new];
        _childList = [NSMutableArray new];
        _projectDetailsList = [NSMutableArray array];
        //测试专用
#if fuck
#warning 记得删除
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"uid"];
#endif
        self.uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"uid"];
        
        if (!self.uid) {
            [self requestForEnterUID];
        }
        NSData *riceFlowObject = [[NSUserDefaults standardUserDefaults] objectForKey:@"riceFlow"];
        self.myRiceFlow = [NSKeyedUnarchiver unarchiveObjectWithData:riceFlowObject];
        
        NSData *myFavListObject = [[NSUserDefaults standardUserDefaults] objectForKey:@"favList"];
        self.myFavList = [NSKeyedUnarchiver unarchiveObjectWithData:myFavListObject];
        
    }
    return self;
}

#pragma mark - 公益项目
- (void)addProjects:(NSArray *)list
               type:(MGYProjectType)type
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

- (void)setProjects:(NSArray *)list
               type:(MGYProjectType)type
              reset:(BOOL)reset
{
    if (reset) {
        if (type == MGYProjectTypeItem) {
            [_itemList removeAllObjects];
        }
        if (type == MGYProjectTypeChildren) {
            [_childList removeAllObjects];
        }
    }
    [self addProjects:list type:type];
    //[[MGYTabBarController shareInstance] refreshProgramListView:type reset:reset];
}

- (void)setProjectsDetails:(MGYProjectDetails *)details
{
    NSInteger projectId = details.projectId;
    for (MGYProjectDetails* oldDetails in _projectDetailsList) {
        if (oldDetails.projectId == projectId) {
            [_projectDetailsList removeObject:oldDetails];
        }
    }
    [_projectDetailsList addObject:details];
}

- (MGYProjectDetails *)getProjectDetailsById:(NSInteger)projectId
{
    for (MGYProjectDetails *details in _projectDetailsList) {
        if (details.projectId == projectId) {
            return details;
        }
    }
    return nil;
}
- (AFHTTPRequestOperation *)requestForList:(MGYProjectType)type
                                     start:(NSInteger)start
                                     limit:(NSInteger)limit
                                     reset:(BOOL)reset
                                   success:(MGYSuccess)success
                                   failure:(MGYFailure)failure
{
    NSString *url = [[self baseUrl] stringByAppendingString:@"/project.php?type=list"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"start":@(start),
                                 @"limit":@(limit),
                                 @"project_type":@(type)};
    return [manager GET:url
             parameters:parameters
                success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
                        if ([responseObject[@"data"] count] == 0) {
                            failure(nil);
                        }else{
                            [self setProjects:responseObject[@"data"] type:type reset:reset];
                            success();
                        }
                    }
                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                    failure(error);
                    }];
}

- (AFHTTPRequestOperation *)requestForProjectDetails:(NSInteger)projectId
                                             success:(MGYSuccess)success
                                             failure:(MGYFailure)failure
{
    NSString *url = [[self baseUrl] stringByAppendingString:@"/project.php?type=detail"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    return [manager GET:url
             parameters:@{@"uid": @(self.uid), @"project_id":@(projectId)}
                success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
                    MGYProjectDetails *projectDetails = [MTLJSONAdapter modelOfClass:[MGYProjectDetails class] fromJSONDictionary:responseObject[@"data"] error:nil];
                    [self setProjectsDetails:projectDetails];
                    success();
                }
                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                    failure(error);
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
    [manager GET:url
      parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        
        if ([responseObject[@"data"] count] == 0) {
            return ;
        }
        
        success(responseObject[@"data"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (AFHTTPRequestOperation *)requestForAddfav:(NSInteger)projectId
                                     success:(MGYSuccess)success
                                     failure:(MGYFailure)failure
{
    NSString *url = [[self baseUrl] stringByAppendingString:@"/project.php?type=addfav"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    return [manager GET:url
             parameters:@{@"uid": @(self.uid), @"project_id":@(projectId)}
                success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
                    success();
                }
                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                    failure(error);
                }];
}

- (AFHTTPRequestOperation *)requestForCancelFav:(NSInteger)projectId
                                        success:(MGYSuccess)success
                                        failure:(MGYFailure)failure
{
    NSString *url = [[self baseUrl] stringByAppendingString:@"/project.php?type=cancelfav"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    return [manager GET:url
             parameters:@{@"uid": @(self.uid), @"project_id":@(projectId)}
                success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
                    success();
                }
                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                    failure(error);
                }];
}

//- (void)setProjectFav:(NSInteger)projectId
//                  fav:(BOOL)fav
//{
//    for (NSMutableDictionary *dic in _projectFavList) {
//        if (projectId == [dic[@"projectId"] integerValue]) {
//            dic[@"fav"] = @(fav);
//            return;
//        }
//    }
//    
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    dic[@"projectId"] = @(projectId);
//    dic[@"fav"] = @(fav);
//    [_projectFavList addObject:dic];
//}

#pragma mark - 首次登陆
- (AFHTTPRequestOperation *)requestForEnterUID
{
    NSString *url = [[self baseUrl] stringByAppendingString:@"/user.php?type=reg&reg_type=startup"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    return [manager GET:url
             parameters:nil
                success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
                    self.uid = [responseObject[@"data"][@"uid"] integerValue];
                    [[NSUserDefaults standardUserDefaults] setInteger:self.uid forKey:@"uid"];
                }
                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                }];
}

#pragma mark - 个人信息
- (AFHTTPRequestOperation *)requestForPersonalDetails
{
    NSString *url = [[self baseUrl] stringByAppendingString:@"/user.php?type=detail"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    return [manager GET:url
             parameters:@{@"uid": @(self.uid)}
                success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
                    MGYPersonalDetails *newPersonalDetails = [MTLJSONAdapter modelOfClass:[MGYPersonalDetails class]fromJSONDictionary:responseObject[@"data"] error:nil];
                    self.personalDetails = newPersonalDetails;
                }
                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                }];
}

- (void)requestForRiceFlow:(NSInteger)start
                     limit:(NSInteger)limit
                   success:(void (^)(MGYRiceFlow *))success
                   failure:(void (^)(MGYRiceFlow *))failure
{
    NSString *url = [BaseURL stringByAppendingString:@"/user.php?type=riceflow"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"uid":@(self.uid), @"start":@(start), @"limit":@(limit)};
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        MGYRiceFlow *riceFlow = [MTLJSONAdapter modelOfClass:[MGYRiceFlow class] fromJSONDictionary:responseObject[@"data"] error:nil];
        NSData *udObject = [NSKeyedArchiver archivedDataWithRootObject:riceFlow];
        [[NSUserDefaults standardUserDefaults]setObject:udObject forKey:@"riceFlow"];
        self.myRiceFlow = riceFlow;
        success(riceFlow);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failure(self.myRiceFlow);
    }];
    
}

- (void)requestForMyFavlist:(NSInteger)start
                      limit:(NSInteger)limit
                    success:(void (^)(MGYMyFavList *))success
                    failure:(void (^)(MGYMyFavList *))failure
{
    NSString *url = [BaseURL stringByAppendingString:@"/user.php?type=favlist"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"uid":@(self.uid), @"start":@(start), @"limit":@(limit)};
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        MGYMyFavList *favList = [MTLJSONAdapter modelOfClass:[MGYMyFavList class] fromJSONDictionary:responseObject[@"data"] error:nil];
        NSData *udObject = [NSKeyedArchiver archivedDataWithRootObject:favList];
        [[NSUserDefaults standardUserDefaults]setObject:udObject forKey:@"favList"];
        self.myFavList = favList;
        success(self.myFavList);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failure(self.myFavList);
    }];
}

#pragma mark - 获得大米
- (void)requestForMiZhi:(void (^)(MGYMiZhi *))success
{
    NSString *url = [BaseURL stringByAppendingString:@"/daily.php?type=main"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        //NSLog(@"%@", responseObject);
        MGYMiZhi *miZhi = [MTLJSONAdapter modelOfClass:[MGYMiZhi class] fromJSONDictionary:responseObject[@"data"] error:nil];
        success(miZhi);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (NSString *)baseUrl
{
    return @"http://api.ricedonate.com/ricedonate/htdocs/ricedonate/public";
}

@end
