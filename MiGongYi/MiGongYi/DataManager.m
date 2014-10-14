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
#import "MGYMiChatRecord.h"
#import "MGYError.h"
#define fuck 1
#define CustomErrorDomain @"MGYError"

@interface DataManager ()
{
    NSMutableArray *_childList;
    NSMutableArray *_itemList;
    NSMutableArray *_projectDetailsList;
    NSMutableArray *_projectRecentList;
    NSMutableArray *_miChatRecordList;
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
        _miChatRecordList = [NSMutableArray array];
        self.canGainRiceFromMiChat = YES;
        //测试专用
        [self loadSetup];
        if (!self.uid) {
            [self requestForEnterUID];
        }else
        {
            [self checkAccountDirectory];
        }
//        MGYMiChatRecord *record1 = [MTLJSONAdapter modelOfClass:[MGYMiChatRecord class] fromJSONDictionary:@{@"personName": @"abcde", @"totalTimes":@(3), @"currentTimes":@(1), @"phoneList":@[@(11111111111)]} error:nil];
//        MGYMiChatRecord *record2 = [MTLJSONAdapter modelOfClass:[MGYMiChatRecord class] fromJSONDictionary:@{@"personName": @"", @"totalTimes":@(0), @"currentTimes":@(0), @"phoneList":@[]} error:nil];
//        NSArray *array = @[record1, record2];
        //[self saveMiChatRecord:array];
        [self loadMiChatRecord:nil failure:nil];
    }
    return self;
}

#pragma mark - 私有定义

- (NSString *)libraryPath
{
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
}

- (NSString *)filePath
{
    return [[self libraryPath] stringByAppendingString:[NSString stringWithFormat:@"/%d", self.uid]];
}

- (NSString *)baseUrl
{
    return @"http://api.ricedonate.com/ricedonate/htdocs/ricedonate/public";
}

- (void)checkAccountDirectory
{
    BOOL isDic = YES;
    BOOL existed = [[NSFileManager defaultManager] fileExistsAtPath:[self filePath]
                                                        isDirectory:&isDic];
    if (!existed) {
        [[NSFileManager defaultManager] createDirectoryAtPath:[self filePath]
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    }
}

#pragma mark - 读写公有信息
- (void)setupAccount
{
    if (!self.uid) {
        return;
    }
    
    NSString *fileName = [[self libraryPath] stringByAppendingString:@"/defaultUid.plist"];
    NSArray *array = @[@(self.uid)];
    [array writeToFile:fileName atomically:YES];
}

- (void)loadSetup
{
    NSString* fileName = [[self libraryPath] stringByAppendingString:@"/defaultUid.plist"];
    if ([[NSFileManager defaultManager]fileExistsAtPath:fileName]) {
        NSArray *data = [NSArray arrayWithContentsOfFile:fileName];
        self.uid = [data[0] integerValue];
        //NSLog(@"cccccccccccc %@",fileName);
    }
}

- (void)saveMiZhi
{
    if (_miZhi) {
        NSDictionary *dicMiZhi = [MTLJSONAdapter JSONDictionaryFromModel:_miZhi];
        NSString* fileName = [[self libraryPath] stringByAppendingString:@"/miZhi.plist"];
        NSMutableArray *data = [NSMutableArray array];
        [data addObject:dicMiZhi];
        [data writeToFile:fileName atomically:YES];
    }
}

- (void)loadMiZhi
{
    NSString* fileName = [[self libraryPath] stringByAppendingString:@"/miZhi.plist"];
    if ([[NSFileManager defaultManager]fileExistsAtPath:fileName]) {
        NSArray *data = [NSArray arrayWithContentsOfFile:fileName];
        _miZhi = [MTLJSONAdapter modelOfClass:[MGYMiZhi class]
                               fromJSONDictionary:data[0]                                            error:nil];
    }
}

#pragma mark - 读写用户信息

- (void)saveUserInfo
{
    NSString* fileName = [[self filePath] stringByAppendingString:@"/userInfo.plist"];
    NSMutableArray *data = [NSMutableArray array];
    if (!_uid) {
        return;
    }
    NSDictionary *dicRiceFlow;
    NSDictionary *dicFavList;
    if (_myFavList) {
        dicFavList = [MTLJSONAdapter JSONDictionaryFromModel:_myFavList];
    }
    if (_myRiceFlow) {
        dicRiceFlow = [MTLJSONAdapter JSONDictionaryFromModel:_myRiceFlow];
    }
    [data addObject:@(_uid)];
    [data addObject:dicRiceFlow];
    [data addObject:dicFavList];
    [data writeToFile:fileName atomically:YES];
}

- (void)loadUserInfo
{
    NSString* fileName = [[self filePath] stringByAppendingString:@"/userInfo.plist"];
    if ([[NSFileManager defaultManager]fileExistsAtPath:fileName]) {
        //NSArray *data = [NSArray arrayWithContentsOfFile:fileName];
    }
}

- (void)saveMyRiceFlow
{
    if (_myRiceFlow) {
        NSDictionary *dicRiceFlow = [MTLJSONAdapter JSONDictionaryFromModel:_myRiceFlow];
        NSString* fileName = [[self filePath] stringByAppendingString:@"/riceFlow.plist"];
        NSArray *data = @[dicRiceFlow];
        [data writeToFile:fileName atomically:YES];
    }
}

- (void)loadMyRiceFlow
{
    NSString* fileName = [[self filePath] stringByAppendingString:@"/riceFlow.plist"];
    if ([[NSFileManager defaultManager]fileExistsAtPath:fileName]) {
        NSArray *data = [NSArray arrayWithContentsOfFile:fileName];
        MGYRiceFlow *riceFlow = [MTLJSONAdapter modelOfClass:[MGYRiceFlow class] fromJSONDictionary:data[0] error:nil];
        _myRiceFlow = riceFlow;
    }
}

- (void)saveMyFavlist
{
    if (_myFavList) {
        NSDictionary *dicFavList = [MTLJSONAdapter JSONDictionaryFromModel:_myFavList];
        NSString* fileName = [[self filePath] stringByAppendingString:@"/favList.plist"];
        NSArray *data = @[dicFavList];
        [data writeToFile:fileName atomically:YES];
    }
}

- (void)loadMyFavlist
{
    NSString* fileName = [[self filePath] stringByAppendingString:@"/favList.plist"];
    if ([[NSFileManager defaultManager]fileExistsAtPath:fileName]) {
        NSArray *data = [NSArray arrayWithContentsOfFile:fileName];
        _myFavList = [MTLJSONAdapter modelOfClass:[MGYMyFavList class] fromJSONDictionary:data[0] error:nil];
    }
}

- (void)saveMiChatRecord:(NSArray *)miChatRecordList
{
    _miChatRecordList = [NSMutableArray arrayWithArray:miChatRecordList];
    NSArray *array = [MTLJSONAdapter JSONArrayFromModels:miChatRecordList];
    NSString* fileName = [[self filePath] stringByAppendingString:@"/miChatRecordList.plist"];
    [array writeToFile:fileName atomically:YES];
}

- (void)loadMiChatRecord:(MGYSuccess)success
                 failure:(MGYFailure)failure
{
    NSArray *array;
    NSString* fileName = [[self filePath] stringByAppendingString:@"/miChatRecordList.plist"];
    //[[NSFileManager defaultManager] removeItemAtPath:fileName error:nil];
    if ([[NSFileManager defaultManager]fileExistsAtPath:fileName]) {
        array = [MTLJSONAdapter modelsOfClass:[MGYMiChatRecord class]
                                         fromJSONArray:[NSArray arrayWithContentsOfFile:fileName]
                                                 error:nil];
        if (success) {
            success();
        }
    }
    else
    {
        NSDictionary *dic = @{@"personName": @"", @"totalTimes":@(0), @"currentTimes":@(0), @"phoneList":@[], @"hasWarning": @NO};
        array = [MTLJSONAdapter modelsOfClass:[MGYMiChatRecord class]
                                fromJSONArray:@[dic,dic,dic,dic,dic,dic]
                                        error:nil];
        if (failure) {
            failure(nil);
        }
    }
    _miChatRecordList = [NSMutableArray arrayWithArray:array];
}

#pragma mark - 公益项目
- (void)addProjects:(NSArray *)list
               type:(MGYProjectType)type
{
    for (NSDictionary *dic in list) {
        MGYProject *newProject = [MTLJSONAdapter modelOfClass:[MGYProject class] fromJSONDictionary:dic error:nil];
        newProject.type = type;
        
        if (type == MGYProjectTypeItem) {
            [_itemList addObject:newProject];
        }
        
        if (type == MGYProjectTypeChildren) {
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
#if fuck
#warning 仅测试用     
                    self.uid = 1;
#endif
                    
                    [self setupAccount];
                    [self checkAccountDirectory];
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
                    _myRiceFlow = riceFlow;
                    [self saveMyRiceFlow];
                    //[self loadMyRiceFlow];
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
                    _myFavList = favList;
                    [self saveMyFavlist];
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
        _miZhi = [MTLJSONAdapter modelOfClass:[MGYMiZhi class] fromJSONDictionary:responseObject[@"data"] error:nil];
        [self saveMiZhi];
        success();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (AFHTTPRequestOperation *)gainRiceFromMiChat:(MGYGainRiceSuccess)success
                                       failure:(MGYFailure)failure
{
    NSString *url = [[self baseUrl] stringByAppendingString:@"/gain.php?type=chat"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    return [manager GET:url parameters:@{@"uid": @(self.uid)}
                success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
                    NSInteger errorCode = [responseObject[@"error"] integerValue];
                    if (errorCode == 0) {
                        success([responseObject[@"data"][@"rice"] integerValue]);
                    }else{
                        NSError *mgyError = [NSError errorWithDomain:CustomErrorDomain
                                                                code:errorCode
                                                            userInfo:nil];
                        failure(mgyError);
                        if (errorCode == MGYMiChatErrorGainFull) {
                            self.canGainRiceFromMiChat = NO;
                        }

                    }
                    
                }
                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                    failure(error);
                }];
}

@end
