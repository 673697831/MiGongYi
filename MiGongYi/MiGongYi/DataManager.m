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

@interface DataManager ()
@end


@implementation DataManager
@synthesize projectList = __projectList;
@synthesize childList = __childList;
@synthesize itemList = __itemList;
+(DataManager *)shareInstance
{
    static DataManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [DataManager new];
    });
    return instance;
}

-(id)init
{
    self = [super init];
    if (self) {
        __projectList = [NSMutableArray new];
        __childList = [NSMutableArray new];
        __itemList = [NSMutableArray new];
    }
    return self;
}

-(void)addProjects:(NSArray *)list type:(ProjectType)type
{
    for (NSDictionary *dic in list) {
        //Project *newProject = [[Project alloc] initWithDictionary:dic error:nil];
        Project *newProject = [MTLJSONAdapter modelOfClass:[Project class] fromJSONDictionary:dic error:nil];
        newProject.type = type;
        
        
        [__projectList addObject:newProject];
        
        if (type == 1) {
            [__itemList addObject:newProject];
        }
        
        if (type == 2) {
            [__childList addObject:newProject];
        }
        
    }
}

-(void)setProjects:(NSArray *)list type:(ProjectType)type reset:(BOOL)reset
{
    if (reset) {
        if (type == 1) {
            [__itemList removeAllObjects];
        }
        if (type == 2) {
            [__childList removeAllObjects];
        }
        [__projectList removeAllObjects];
    }
    [self addProjects:list type:type];
    [[MGYTabBarController shareInstance] refreshProgramListView:type reset:reset];
}

-(void)requestForList:(ProjectType)type start:(NSInteger)start limit:(NSInteger)limit reset:(BOOL)reset
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
        
        [self setProjects:responseObject[@"data"] type:type reset:reset];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
