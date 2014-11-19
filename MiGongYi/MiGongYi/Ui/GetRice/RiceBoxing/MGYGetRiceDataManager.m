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

@property (nonatomic, strong) NSMutableDictionary *mutableRiceMoveLevelRecord;
@property (nonatomic, strong) MGYTotalWalk *personalTotalWalk;

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

//- (AFHTTPRequestOperation *)requestForRiceMove:(NSInteger)storyIndex nodeIndex:(NSInteger)nodeIndex
//{
//    NSMutableArray *mutableRecord = [NSMutableArray arrayWithArray:[self arrayRiceMoveRecordFromLocal]?:@[]];
//    NSString *url = [[self baseUrl] stringByAppendingString:@"/gain.php?type=walk"];
//    NSDictionary *parameters = @{@"uid":self.uid, @"family":@(family + 1), @"monster":@(monsterType + 1)};
//}

//- (AFHTTPRequestOperation *)requestForRiceMoveFromLocal
//{
//
//}

- (void)saveRiceMoveLevelRecord:(NSInteger)storyIndex
                      nodeIndex:(NSInteger)nodeIndex
{
    MGYRiceMoveLevelRecord *record = [MGYRiceMoveLevelRecord new];
    record.storyIndex = storyIndex;
    record.nodeIndex = nodeIndex;
    record.levelString = [NSString stringWithFormat:@"%d-%d", storyIndex + 1, nodeIndex];
    record.timeSp = [[NSDate date] timeIntervalSince1970];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[self filePath] stringByAppendingString:@"/riceMoveLevelRecord.plist"]];
    self.mutableRiceMoveLevelRecord = [NSMutableDictionary dictionaryWithDictionary:dic];
    [self.mutableRiceMoveLevelRecord setValue:[MTLJSONAdapter JSONDictionaryFromModel:record]
                                   forKey:record.levelString];
    
    [self.mutableRiceMoveLevelRecord writeToFile:[[self filePath] stringByAppendingString:@"/riceMoveLevelRecord.plist"]
                                  atomically:YES];
}

- (NSString *)dateString:(NSInteger)storyIndex
                   index:(NSInteger)index
{
    self.mutableRiceMoveLevelRecord = [NSMutableDictionary dictionaryWithDictionary:[self riceMoveLevelRecord]];
    NSDictionary *dic = [self.mutableRiceMoveLevelRecord objectForKey:[NSString stringWithFormat:@"%d-%d", storyIndex + 1, index]];
    MGYRiceMoveLevelRecord *record = [MTLJSONAdapter modelOfClass:[MGYRiceMoveLevelRecord class] fromJSONDictionary:dic error:nil];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:record.timeSp]];
    
    return currentDateStr;
}

- (NSDictionary *)riceMoveLevelRecord
{
    return self.mutableRiceMoveLevelRecord?:[NSDictionary dictionaryWithContentsOfFile:[[self filePath] stringByAppendingString:@"/riceMoveLevelRecord.plist"]];
}

- (MGYTotalWalk *)totalWalk
{
    if (self.personalTotalWalk) {
        return self.personalTotalWalk;
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[self filePath] stringByAppendingString:@"/totalWalk.plist"]];
    
    if (dic) {
        return [MTLJSONAdapter modelOfClass:[MGYTotalWalk class]
                         fromJSONDictionary:dic
                                      error:nil];
    }
    
    return nil;
}

- (void)addPower:(NSInteger)power
{
    self.personalTotalWalk = [self totalWalk]?:[MGYTotalWalk new];
    self.personalTotalWalk.power = self.personalTotalWalk.power + power;
    NSDictionary *dic = [MTLJSONAdapter JSONDictionaryFromModel:self.personalTotalWalk];
    [dic writeToFile:[[self filePath] stringByAppendingString:@"/totalWalk.plist"] atomically:YES];
}

- (void)addStep:(NSInteger)step
{
    self.personalTotalWalk = [self totalWalk]?:[MGYTotalWalk new];
    if (!self.personalTotalWalk.timeSp) {
        self.personalTotalWalk.timeSp = [[NSDate date] timeIntervalSince1970];
    }
    
    NSDate *lastDate = [NSDate dateWithTimeIntervalSince1970:self.personalTotalWalk.timeSp];
    NSDateComponents *lastComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear| NSCalendarUnitWeekday fromDate:lastDate];

    NSDate *curDate = [NSDate date];
    NSDateComponents *curComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear| NSCalendarUnitWeekday fromDate:curDate];
    
    self.personalTotalWalk.totalStep = self.personalTotalWalk.totalStep + step;
    if ([lastComponents day] != [curComponents day]) {
        self.personalTotalWalk.curStep = 0;
        self.personalTotalWalk.timeSp = [[NSDate date] timeIntervalSince1970];
    }
    self.personalTotalWalk.curStep = self.personalTotalWalk.curStep + step;
}

- (NSArray *)arrayRiceMoveRecordFromLocal
{
    return nil;
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
