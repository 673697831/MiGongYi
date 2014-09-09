//
//  DataManager.m
//  MiGongYi
//
//  Created by megil on 9/6/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "DataManager.h"
#import "AFNetworking.h"
#import "MainTabBar.h"
#define URI "http://api.ricedonate.com/ricedonate/htdocs/ricedonate/public/project.php?type=list"

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
        instance = [[DataManager alloc] init];
    });
    return instance;
}

-(id)init
{
    self = [super init];
    __projectList = [[NSMutableArray alloc] init];
    __childList = [[NSMutableArray alloc] init];
    __itemList = [[NSMutableArray alloc] init];
    return self;
}

-(void)AddProjects:(NSArray *)list Type:(int)type
{
    for (NSDictionary *dic in list) {
        Project *newProject = [[Project alloc] initWithKeys:type ProjectId:[dic[@"type"] intValue] CoverImg:dic[@"cover_img"] Title:dic[@"title"] RiceDonate:[dic[@"rice_donate"] intValue] Progress:[dic[@"progress"] intValue] FayNum:[dic[@"fay_num"] intValue] JoinMemberNum:[dic[@"join_member_num"] intValue] Status:[dic[@"status"] intValue]];
        
        [self.projectList addObject:newProject];
        
        if (type == 1) {
            [self.itemList addObject:newProject];
        }
        
        if (type == 2) {
            [self.childList addObject:newProject];
        }
        
    }
}

-(void)SetProjects:(NSArray *)list Type:(int)type
{
    [self.projectList removeAllObjects];
    [self.itemList removeAllObjects];
    [self.childList removeAllObjects];
    [self AddProjects:list Type:type];
}

-(void)RequestForList:(int)type Start:(int)start Limit:(int)limit
{
    NSString *url = @"http://api.ricedonate.com/ricedonate/htdocs/ricedonate/public/project.php?type=list";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"start":[NSNumber numberWithInt:start], @"limit":[NSNumber numberWithInt:limit], @"project_type":[NSNumber numberWithInt:type]};
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        if ([responseObject[@"data"] isKindOfClass:[NSArray class]]) {
            //NSLog(@"%@", responseObject[@"data"]);
        }
        [self SetProjects:responseObject[@"data"] Type:type];
        [[MainTabBar shareInstance] RefreshProgramListView:type];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
