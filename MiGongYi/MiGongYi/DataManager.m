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
#import "MGYProjectRecent.h"
#define fuck 1

#define BaseURL @"http://api.ricedonate.com/ricedonate/htdocs/ricedonate/public"

@interface DataManager ()
{
    NSMutableArray *_childList;
    NSMutableArray *_itemList;
    NSMutableArray *_projectDetailsList;
    NSMutableArray *_projectRecentList;
}
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
        _projectRecentList = [NSMutableArray array];
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
        _myRiceFlow = [NSKeyedUnarchiver unarchiveObjectWithData:riceFlowObject];
        
        NSData *myFavListObject = [[NSUserDefaults standardUserDefaults] objectForKey:@"favList"];
        _myFavList = [NSKeyedUnarchiver unarchiveObjectWithData:myFavListObject];
        
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

- (void)setProjectDetails:(MGYProjectDetails *)details
{
    NSInteger projectId = details.projectId;
    for (MGYProjectDetails* oldDetails in _projectDetailsList) {
        if (oldDetails.projectId == projectId) {
            NSInteger index = [_projectDetailsList indexOfObject:oldDetails];
            [_projectDetailsList replaceObjectAtIndex:index withObject:details];
            return;
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

- (void)setProjectRecent:(NSArray *)recentArray
                parentId:(NSInteger)parentId
{
    for (NSDictionary *recent in recentArray) {
        MGYProjectRecent *projectRecent = [MTLJSONAdapter modelOfClass:[MGYProjectRecent class]        fromJSONDictionary:recent error:nil];
        projectRecent.parentId = parentId;
        BOOL isExit = false;
        for (MGYProjectRecent *oldProjectRecent in _projectRecentList) {
            if (oldProjectRecent.projectId == projectRecent.projectId) {
                NSInteger index = [_projectRecentList indexOfObject:oldProjectRecent];
                [_projectRecentList replaceObjectAtIndex:index withObject:projectRecent];
                isExit = true;
                break;
            }
        }
        if (!isExit) {
            [_projectRecentList addObject:projectRecent];
        }
        
    }
}

- (NSArray *)getProjectRectById:(NSInteger)parentId
{
    NSMutableArray *array = [NSMutableArray array];
    for (MGYProjectRecent *projectRecent in _projectRecentList) {
        if (projectRecent.parentId == parentId) {
            [array addObject:projectRecent];
        }
    }
    return array;
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
                    [self setProjectDetails:projectDetails];
                    success();
                }
                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                    failure(error);
                }];
}

- (AFHTTPRequestOperation *)requestForProjectRecent:(NSInteger)projectId
                          start:(NSInteger)start
                          limit:(NSInteger)limit
                        success:(MGYSuccess)success
                        failure:(MGYFailure)failure
{
    NSString *url = [[self baseUrl] stringByAppendingString:@"/project.php?type=recentsituation"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"project_id":@(projectId), @"start":@(start), @"limit":@(limit)};
    return [manager GET:url
             parameters:parameters
                success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
                    if ([responseObject[@"data"] count] == 0) {
                        failure(nil);
                        return ;
                    }else
                    {
                        [self setProjectRecent:responseObject[@"data"]parentId:projectId];
                        success();
                    }
                }
                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                    failure(error);
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

- (AFHTTPRequestOperation *)requestForRiceFlow:(NSInteger)start
                     limit:(NSInteger)limit
                   success:(MGYSuccess)success
                   failure:(MGYFailure)failure
{
    NSString *url = [[self baseUrl] stringByAppendingString:@"/user.php?type=riceflow"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"uid":@(self.uid), @"start":@(start), @"limit":@(limit)};
    return [manager GET:url
             parameters:parameters
                success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
                    MGYRiceFlow *riceFlow = [MTLJSONAdapter modelOfClass:[MGYRiceFlow class] fromJSONDictionary:responseObject[@"data"] error:nil];
                    NSData *udObject = [NSKeyedArchiver archivedDataWithRootObject:riceFlow];
                    [[NSUserDefaults standardUserDefaults]setObject:udObject forKey:@"riceFlow"];
                    _myRiceFlow = riceFlow;
                    success();
                }
                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                    failure(error);
                }];
    
}

- (AFHTTPRequestOperation *)requestForMyFavlist:(NSInteger)start
                      limit:(NSInteger)limit
                    success:(MGYSuccess)success
                    failure:(MGYFailure)failure
{
    NSString *url = [[self baseUrl] stringByAppendingString:@"/user.php?type=favlist"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"uid":@(self.uid), @"start":@(start), @"limit":@(limit)};
    return [manager GET:url
             parameters:parameters
                success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
                    MGYMyFavList *favList = [MTLJSONAdapter modelOfClass:[MGYMyFavList class] fromJSONDictionary:responseObject[@"data"] error:nil];
                    NSData *udObject = [NSKeyedArchiver archivedDataWithRootObject:favList];
                    [[NSUserDefaults standardUserDefaults]setObject:udObject forKey:@"favList"];
                    _myFavList = favList;
                    success();
                }
                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                    failure(error);
                }];
}

#pragma mark - 获得大米
- (AFHTTPRequestOperation *)requestForMiZhi:(MGYSuccess)success
                                    failure:(MGYFailure)failure
{
    NSString *url = [[self baseUrl] stringByAppendingString:@"/daily.php?type=main"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    return [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        //NSLog(@"%@", responseObject);
        _miZhi = [MTLJSONAdapter modelOfClass:[MGYMiZhi class] fromJSONDictionary:responseObject[@"data"] error:nil];
        success();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (NSString *)baseUrl
{
    return @"http://api.ricedonate.com/ricedonate/htdocs/ricedonate/public";
}

@end
