//
//  MGYRiceBoxingDataManager.m
//  MiGongYi
//
//  Created by megil on 11/14/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYGetRiceDataManager.h"
#import "MGYBoxingRecord.h"
#import "MGYRiceBoxingMonsterRate.h"
#define test 0

@interface MGYGetRiceDataManager ()

@property (nonatomic, strong) NSMutableDictionary *mutableRiceMoveLevelRecord;
@property (nonatomic, strong) MGYBoxingRecord *boxingRecord;
@property (nonatomic, strong) MGYTotalWalk *personalTotalWalk;
@property (nonatomic, strong) MGYStory *personalStory;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *baseUrl;
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, strong) NSDictionary *md5Parameters;
@property (nonatomic, weak) AFHTTPRequestOperationManager *requestManager;
@property (nonatomic, strong) NSArray *arrayMonsterRate;
@property (nonatomic, weak) MGYRiceBoxingTimeBlock timeBlock;
@property (nonatomic, strong) NSTimer *bossTimer;
@property (nonatomic, assign) BOOL riceBoxingIsHitting;
@property (nonatomic, assign) NSInteger bossRemainTime;

@end

@implementation MGYGetRiceDataManager

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if([keyPath isEqualToString:@"curHp"])
//    {
//        if(self.boxingRecord.curHp >= 500)
//        {
//        
//        }
//    }
//}

- (instancetype)initWithManager:(DataManager *)manager
{
    self = [self init];
    if (self) {
//        self.baseUrl = manager.baseUrl;
//        self.filePath = manager.filePath;
//        self.requestManager = manager.requestManager;
        _remainTimes = 1;
        
        [self loadRiceBoxingRecord];
        if (!self.boxingRecord){
            self.boxingRecord = [MGYBoxingRecord new];
            self.boxingRecord.timesp = [[NSDate date] timeIntervalSince1970];
            self.boxingRecord.smallTimes = 0;
            self.boxingRecord.middleTimes = 0;
            self.boxingRecord.followId = -1;
            self.boxingRecord.firstBlood = YES;
            
#if test
#warning 测试

            self.boxingRecord.smallTimes = 3;
            self.boxingRecord.middleTimes = 2;
#endif
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Monster" ofType:@"plist"];
            NSArray *arrayMonster = [NSArray arrayWithContentsOfFile:filePath];
            self.boxingRecord.arrayMonster = [MTLJSONAdapter modelsOfClass:[MGYMonster class]
                                                             fromJSONArray:arrayMonster
                                                                     error:nil];
            
            for (MGYMonster *monster in self.boxingRecord.arrayMonster) {
                monster.skillContent = monster.skillContent? monster.skillContent: @"";
#if test
#warning 测试
                monster.fightTimes = 5;
                monster.monsterStatus = MGYMonsterStatusUnLocked;
#endif
                monster.condition = monster.condition? monster.condition: @"";
            }
            
            MGYMonster *monster = self.boxingRecord.arrayMonster[0];
            self.boxingRecord.monsterId = monster.monsterId;
            self.boxingRecord.curHp = monster.maxHp;
            
            [self saveRiceBoxingRecord];
            
        }
        
        self.arrayMonsterRate = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"monster_rate" ofType:@"plist"]];
        self.arrayMonsterRate = [MTLJSONAdapter modelsOfClass:[MGYRiceBoxingMonsterRate class]
                                                fromJSONArray:self.arrayMonsterRate
                                                        error:nil];
        
//        [self.boxingRecord addObserver:self forKeyPath:@"curHp" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];

    }
    return self;
}

- (NSString *)uid
{
    return [DataManager shareInstance].uid;
}

- (NSString *)baseUrl
{
    return [DataManager shareInstance].baseUrl;
}

- (NSString *)filePath
{
    return [DataManager shareInstance].filePath;
}

- (AFHTTPRequestOperationManager *)requestManager
{
    return [DataManager shareInstance].requestManager;
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

- (AFHTTPRequestOperation *)requestForRiceMoveLevels
{
    NSString *url = [[self baseUrl] stringByAppendingString:@"/game.php?type=getwalkprocess"];
    return [self.requestManager GET:url
                         parameters:nil
                            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                
                            }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                
                            }];
}

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
    if (![self.mutableRiceMoveLevelRecord writeToFile:[[self filePath] stringByAppendingString:@"/riceMoveLevelRecord.plist"]
                                          atomically:YES]) {
        assert(false);
    }
    
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

- (MGYStory *)story
{
    if (self.personalStory) {
        return self.personalStory;
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[self filePath] stringByAppendingString:@"/story.plist"]];
    
    if (dic) {
        return [MTLJSONAdapter modelOfClass:[MGYStory class]
                         fromJSONDictionary:dic
                                      error:nil];
    }
    
    MGYStoryBuff *buff0 = [MGYStoryBuff new];
    buff0.buffType = MGYStoryBuffTypeShoes;
    buff0.buffState = MGYStoryBuffStateTypeClose;
    buff0.buffImagePath = @"sfsdfssf";
    MGYStoryBuff *buff1 = [MGYStoryBuff new];
    buff1.buffType = MGYStoryBuffTypeBear;
    buff1.buffState = MGYStoryBuffStateTypeClose;
    buff1.buffImagePath = @"fsdfdsfsf";
    
    MGYStory *story = [MTLJSONAdapter modelOfClass:[MGYStory class]
                                fromJSONDictionary:@{@"storyName": @"story1", @"isfirstPlay": @1}
                                             error:nil];
    story.arrayBuff = [NSMutableArray arrayWithObjects:buff0, buff1, nil];

    return story;
}

- (void)synStory
{

    self.personalStory.arrayBuff = self.personalStory.arrayBuff ? :[NSMutableArray array];
    NSDictionary *dic = [MTLJSONAdapter JSONDictionaryFromModel:self.personalStory];
    //NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    if (![dic writeToFile:[[self filePath] stringByAppendingString:@"/story.plist"] atomically:YES]) {
        assert(false);
    }
    
}

- (void)saveStoryName:(NSString *)storyName
{
    self.personalStory = [self story];
    self.personalStory.storyName = storyName;
}

- (void)saveStoryProgress:(NSInteger)progress
{
    self.personalStory = [self story];
    self.personalStory.progress = progress;
}

- (void)saveStoryPlaynodeIndex:(NSInteger)index
{
    self.personalStory = [self story];
    self.personalStory.playnodeIndex = index;
}

- (void)saveStoryBuff:(NSArray *)arrayBuff
{
    self.personalStory = [self story];
    NSMutableArray *mutableBuff = [NSMutableArray arrayWithArray:self.personalStory.arrayBuff];
    for (int i = 0; i < arrayBuff.count; i++) {
        MGYStoryBuff *buff = arrayBuff[i];
        mutableBuff[buff.buffType] = buff;
    }
    self.personalStory.arrayBuff = mutableBuff;
}

- (void)saveStoryIsfirstPlay:(BOOL)isfirstPlay
{
    self.personalStory = [self story];
    self.personalStory.isfirstPlay = isfirstPlay;
}

- (void)saveStoryIsplaying:(BOOL)isplaying
{
    self.personalStory = [self story];
    self.personalStory.isplaying = isplaying;
}

- (void)saveStoryBoxingBranch:(BOOL)isBoxingBranch
{
    self.personalStory = self.personalStory = [self story];
    self.personalStory.boxingBranch = isBoxingBranch;
}

- (void)saveRiceBoxingRecord
{
    NSDictionary *dic = [MTLJSONAdapter JSONDictionaryFromModel:self.boxingRecord];
    if (![dic writeToFile:[[self filePath] stringByAppendingString:@"/boxingRecordTest.plist"] atomically:YES]) {
        assert(false);
    }
}

- (void)loadRiceBoxingRecord
{
    NSString* fileName = [[self filePath] stringByAppendingString:@"/boxingRecordTest.plist"];
    if ([[NSFileManager defaultManager]fileExistsAtPath:fileName]) {
        NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:fileName];
        self.boxingRecord = [MTLJSONAdapter modelOfClass:[MGYBoxingRecord class] fromJSONDictionary:data error:nil];
        if (!self.boxingRecord) {
            assert(false);
        }
    }
}

- (MGYTotalWalk *)totalWalk
{
    if (self.personalTotalWalk) {
        return self.personalTotalWalk;
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[self filePath] stringByAppendingString:@"/totalWalk.plist"]];
    
    if (dic) {
        self.personalTotalWalk = [MTLJSONAdapter modelOfClass:[MGYTotalWalk class]
                                           fromJSONDictionary:dic
                                                        error:nil];
    }
    
    return self.personalTotalWalk ? :[MTLJSONAdapter modelOfClass:[MGYTotalWalk class] fromJSONDictionary:@{@"power": @(1000000)} error:nil];
}

- (void)addPower:(CGFloat)power
{
    self.personalTotalWalk = [self totalWalk]?:[MGYTotalWalk new];
    self.personalTotalWalk.power = self.personalTotalWalk.power + power;
    NSDictionary *dic = [MTLJSONAdapter JSONDictionaryFromModel:self.personalTotalWalk];
    if (![dic writeToFile:[[self filePath] stringByAppendingString:@"/totalWalk.plist"] atomically:YES]) {
    }
    
}

- (void)resetPower
{
    self.personalTotalWalk = [self totalWalk]?:[MGYTotalWalk new];
    self.personalTotalWalk.power = 0;
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
    NSDictionary *dic = [MTLJSONAdapter JSONDictionaryFromModel:self.personalTotalWalk];
    [dic writeToFile:[[self filePath] stringByAppendingString:@"/totalWalk.plist"] atomically:YES];
}

- (BOOL)bshowRiceMoveHelp
{
    MGYStory *story = [self story];
    return story.isfirstPlay && [story.storyName isEqualToString:@"story1"];
}

- (NSArray *)arrayRiceMoveRecordFromLocal
{
    return nil;
}

- (NSArray *)arrayRiceBoxingMonster
{
    return self.boxingRecord.arrayMonster;
}

- (void)hitMonster:(MGYSuccess)success
              failure:(MGYFailure)failure
       timeoutFailure:(MGYRiceTimeOutFailure)timeoutFailure
{
    if(self.riceBoxingIsHitting){
        return;
    }
    self.riceBoxingIsHitting = YES;
    CGFloat coefficient = 1;
    if ([self checkRiceBoxingCoefficient]) {
        coefficient = 1.5;
    }
    else if ([self checkGetRiceCoefficient]){
        coefficient = 1.2;
    }
    
    //判断是否是大怪
    if ((self.boxingRecord.bossId && self.boxingRecord.bossId == 2) || self.boxingRecord.bossId == 5 || self.boxingRecord.bossId == 8 || self.boxingRecord.bossId == 11 || self.boxingRecord.bossId == 14) {
        //判断是否需要倒计时
        MGYMonster *monster = self.boxingRecord.arrayMonster[self.boxingRecord.bossId];
        if (monster.time) {
            if(!self.bossRemainTime)
            {
                self.boxingRecord.bossId = 0;
                [self saveRiceBoxingRecord];
                timeoutFailure();
                self.riceBoxingIsHitting = NO;
                return;
            }
        }
        self.boxingRecord.bossHp = self.boxingRecord.bossHp - 20;
        //self.boxingRecord.bossHp = 0;
        if (self.boxingRecord.bossHp <= 0) {
            MGYMonster *monster = self.boxingRecord.arrayMonster[self.boxingRecord.bossId];
            [self requestForRiceBoxing:monster.monsterId % 3 + 1
                           monsterType:monster.monsterType
                           coefficient:coefficient
                               success:^{
                                   monster.fightTimes ++;
                                   self.boxingRecord.bossId = 0;
                                   [self saveRiceBoxingRecord];
                                   self.bossRemainTime = 0;
                                   self.riceBoxingIsHitting = NO;
                                   success();
                               }
                               failure:^(NSError *error) {
                                   self.bossRemainTime = 0;
                                   self.boxingRecord.curHp = monster.maxHp;
                                   self.riceBoxingIsHitting = NO;
                               }];
        }else
        {
            [self saveRiceBoxingRecord];
            self.riceBoxingIsHitting = NO;
        }
    }else
    {
        self.boxingRecord.curHp = self.boxingRecord.curHp - 20;
        //self.boxingRecord.curHp = 0;
        if (self.boxingRecord.curHp <= 0) {
            MGYMonster *monster = self.boxingRecord.arrayMonster[self.boxingRecord.monsterId];
            self.lastOp = [self requestForRiceBoxing:monster.monsterId % 3 + 1
                           monsterType:monster.monsterType
                           coefficient:coefficient
                               success:^{
                                   if(monster.monsterType == MGYMonsterTypeSmall){
                                       self.boxingRecord.smallTimes ++;
                                   }else{
                                       self.boxingRecord.middleTimes ++;
                                   }
                                   
                                   if (self.boxingRecord.firstBlood) {
                                       self.boxingRecord.firstBlood = NO;
                                   }
                                   monster.fightTimes ++;
                                   [self resetMonster];
                                   self.riceBoxingIsHitting = NO;
                                   success();

                               }
                               failure:^(NSError *error) {
                                   //self.boxingRecord.curHp = monster.maxHp;
                                   failure(error);
                                   self.riceBoxingIsHitting = NO;
                               }];
            
        }else
        {
            [self saveRiceBoxingRecord];
            self.riceBoxingIsHitting = NO;
        }
    }
}

- (void)riceBoxingUnLockMonster:(NSInteger)monsterId
{
    MGYMonster *monster = self.boxingRecord.arrayMonster[monsterId];
    monster.monsterStatus = MGYMonsterStatusUnLocked;
}

- (CGFloat)riceBoxingMonsterCurHp
{
    if (self.boxingRecord.bossId){
        return self.boxingRecord.bossHp;
    }
    return self.boxingRecord.curHp;
}

- (CGFloat)riceBoxingMonsterProgress
{
    MGYMonster *monster;
    CGFloat progress;
    if (self.boxingRecord.bossId) {
        monster = self.boxingRecord.arrayMonster[self.boxingRecord.bossId];
        progress = self.boxingRecord.bossHp *1.0 / monster.maxHp;
    }else
    {
        monster = self.boxingRecord.arrayMonster[self.boxingRecord.monsterId];
        progress = self.boxingRecord.curHp *1.0 / monster.maxHp;
    }
    
    
    if(progress > 1){
        assert(false);
    }
    return progress;
}

- (MGYMonster *)riceBoxingCurMonster
{
    if (self.boxingRecord.bossId) {
        return self.boxingRecord.arrayMonster[self.boxingRecord.bossId];
    }
    
    return self.boxingRecord.arrayMonster[self.boxingRecord.monsterId];
}

- (void)resetMonster
{
    //产生随机数 确定随机怪
    int i = arc4random() % 100 + 1;
    for (MGYRiceBoxingMonsterRate *monsterRate in self.arrayMonsterRate) {
        if (i <= monsterRate.rate) {
            MGYMonster *monster = self.boxingRecord.arrayMonster[monsterRate.monsterId];
            self.boxingRecord.monsterId = monster.monsterId;
            self.boxingRecord.curHp = monster.maxHp;
            
            if([self riceBoxingMonsterProgress] != 1)
            {
                assert(false);
            }
            
            [self saveRiceBoxingRecord];
            return;
        }
    }
}

- (void)riceBoxingResetBoss
{
    [self.bossTimer invalidate];
    self.bossTimer = nil;
    [self resetRiceBoxingTimes];
    int i = arc4random() % 17;
    while (1) {
        i = i % 17;
        MGYMonster *monster = self.boxingRecord.arrayMonster[i];
        if (monster.monsterType == MGYMonsterTypeLarge) {
            self.boxingRecord.bossHp = monster.maxHp;
            self.boxingRecord.bossId = monster.monsterId;
            
            //需要倒计时
            
            if(monster.time)
            {
                self.bossRemainTime = monster.time * 10;
                self.bossTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                                  target:self
                                                                selector:@selector(bossTimerAciton)
                                                                userInfo:nil
                                                                 repeats:YES];
            }
            [self saveRiceBoxingRecord];
            break;
        }
        i ++;
    }
    
    
}

- (void)bossTimerAciton
{
    self.bossRemainTime -=1 ;
    if(self.timeBlock)
    {
        self.timeBlock();
    }
    
    if(self.bossRemainTime <= 0)
    {
        self.bossRemainTime = 0;
        [self.bossTimer invalidate];
        self.bossTimer = nil;
        self.boxingRecord.bossId = 0;
    }
    
}

- (NSInteger)getRiceBoxingBossRemainTime
{
    return self.bossRemainTime;
}

- (NSInteger)getRiceBoxingFollowId
{
    return self.boxingRecord.followId;
}

- (void)setRiceBoxingFollowId:(NSInteger)followId
{
    self.boxingRecord.followId = followId;
    [self saveRiceBoxingRecord];
}

- (void)setRiceRiceBoxingTimeBlock:(MGYRiceBoxingTimeBlock)timeBlock
{
    self.timeBlock = timeBlock;
}

- (NSInteger)riceBoxingSmallTimes
{
    return self.boxingRecord.smallTimes;
}

- (NSInteger)riceBoxingMiddleTimes
{
    return self.boxingRecord.middleTimes;
}

- (void)resetRiceBoxingTimes
{
    self.boxingRecord.smallTimes = 0;
    self.boxingRecord.middleTimes = 0;
}

- (BOOL)checkRiceBoxingCoefficient
{
    return self.boxingRecord.followId == 15 ? YES:NO;
}

- (BOOL)checkRiceMoveCoefficient
{
    return self.boxingRecord.followId == 6? YES:NO;
}

- (BOOL)checkMiZhiCoefficient
{
    return self.boxingRecord.followId == 12? YES:NO;
}

- (BOOL)checkMiChatCoefficient
{
    return self.boxingRecord.followId == 0? YES:NO;
}

- (BOOL)checkGetRiceCoefficient
{
    return self.boxingRecord.followId == 9? YES:NO;
}


- (AFHTTPRequestOperation *)requestForRiceBoxing:(NSInteger)family
                                     monsterType:(MGYMonsterType)monsterType
                                     coefficient:(CGFloat)coefficient
                                         success:(MGYSuccess)success
                                         failure:(MGYFailure)failure
{
    NSString *url = [[self baseUrl] stringByAppendingString:@"/gain.php?type=boxing"];
    AFHTTPRequestOperationManager *manager = self.requestManager;
    NSDictionary *parameters = @{@"uid":self.uid, @"family":@(family + 1), @"monster":@(monsterType + 1), @"coefficient":@(coefficient)};
    NSDictionary *md5Parameters = [MGYPublicFunction md5Parameters:parameters];
    
    [DataManager shareInstance].afNetworkingSuccessBlock = ^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"%@", responseObject);
        if (![responseObject[@"error"] integerValue]) {
            
            MGYProtocolRiceBoxingObtain *riceBoxingObtain = [MTLJSONAdapter modelOfClass:[MGYProtocolRiceBoxingObtain class] fromJSONDictionary:responseObject[@"data"] error:nil];
            
            _riceBoxingObtain = riceBoxingObtain;
            _remainTimes = riceBoxingObtain.remainTimes;
            if (riceBoxingObtain.rice) {
                success();
            }
            else
            {
                //没有剩余次数
                NSError *mgyError = [NSError errorWithDomain:MGYRiceBoxingErrorDomain
                                                        code:MGYRiceBoxingErrorRiceNull
                                                    userInfo:nil];
                _remainTimes = 0;
                failure(mgyError);
            }
        }else{
            failure(nil);
        }
    };
    
    [DataManager shareInstance].afNetworkingFailureBlock = ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error %@", error);
        failure(error);
    };
    
    [DataManager shareInstance].requestMethod = @"GET";
    [DataManager shareInstance].requestUrl = url;
    [DataManager shareInstance].requestParameters = md5Parameters;

    AFHTTPRequestOperation *op = [manager GET:url
             parameters:md5Parameters
                success:[DataManager shareInstance].afNetworkingSuccessBlock
                failure:[DataManager shareInstance].afNetworkingFailureBlock];
    
    return op;
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
