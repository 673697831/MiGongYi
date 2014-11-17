//
//  MGYRiceBoxingDataManager.m
//  MiGongYi
//
//  Created by megil on 11/14/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYGetRiceDataManager.h"
#import "MGYBoxingRecord.h"
#define test 1

@interface MGYGetRiceDataManager ()

@end

@implementation MGYGetRiceDataManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (!self.record){
            _record = [MGYBoxingRecord new];
            _record.monsterId = 0;
            _record.curHp = 200;
            _record.timesp = [[NSDate date] timeIntervalSince1970];
            _record.fightTimes = 0;
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Monster" ofType:@"plist"];
            NSArray *arrayMonster = [NSArray arrayWithContentsOfFile:filePath];
            _record.arrayMonster = [MTLJSONAdapter modelsOfClass:[MGYMonster class]
                                                   fromJSONArray:arrayMonster
                                                           error:nil];
        }
    }
    return self;
}

- (AFHTTPRequestOperation *)requestForRiceBoxing:(NSInteger)family
                                     monsterType:(MGYMonsterType)monsterType
                                     coefficient:(CGFloat)coefficient
{
    NSString *url = [[self baseUrl] stringByAppendingString:@"/gain.php?type=boxing"];
    NSDictionary *parameters = @{@"uid":self.uid, @"family":@(family + 1), @"monster":@(monsterType + 1)};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    return [manager GET:url
             parameters:parameters
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSLog(@"%@", responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
}

+ (instancetype)manager
{
    static MGYGetRiceDataManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [MGYGetRiceDataManager new];
    });
    return instance;
}

@end
