//
//  MGYStoryPlayer.m
//  MiGongYi
//
//  Created by megil on 10/28/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYStoryPlayer.h"
#import "MGYGetRiceDataManager.h"

#define STEP 20000

static MGYStoryPlayer *instance;

@interface MGYStoryPlayer ()
{
    NSMutableArray *_mutableProgress;
}
@property (nonatomic, strong) CLLocationManager *myLocationManager;// 定位管理
@property (nonatomic, strong) NSLock *lock;
@property (nonatomic, strong) NSMutableDictionary *mutableStory;
//@property (nonatomic, strong) NSMutableArray *mutableProgress;
@property (nonatomic, strong) NSArray *arrayFileName;
@property (nonatomic, strong) NSMutableDictionary *mutableFileName;
@property (nonatomic, strong) NSMutableArray *mutableNodes;


@end

@implementation MGYStoryPlayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        //读取配置文件 这里读取第一个故事
        
//        _story = [MGYStory new];
//        _story.storyName = @"story1";
//        _story.storyIndex = 0;
//        _story.progress = 0;
//        _story.playnodeIndex = 0;
//        _story.isfirstPlay = YES;
//        _story.mutableDicBuff = [NSMutableDictionary dictionary];
        _mutableStory = [NSMutableDictionary dictionary];
        _mutableProgress = [NSMutableArray array];
        _mutableNodes = [NSMutableArray array];
        _mutableFileName = [NSMutableDictionary dictionary];
        _motionManager = [CMMotionManager new];
        _motionManager.accelerometerUpdateInterval = 1./60;
        [_motionManager startAccelerometerUpdates];
        _myLocationManager = [[CLLocationManager alloc] init];// 初始化
        [_myLocationManager setDesiredAccuracy:kCLLocationAccuracyBest];// 设置精度值
        [_myLocationManager setDelegate:self];// 设置代理
        [_myLocationManager startUpdatingLocation];
        
        [NSTimer scheduledTimerWithTimeInterval:1.0/20.0
                                         target:self
                                       selector:@selector(timerAction)
                                       userInfo:nil
                                        repeats:YES];
        
        NSInteger storyIndex = 0;
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Config" ofType:@"plist"];
        NSArray *arrayFileName = [NSArray arrayWithContentsOfFile:plistPath];
        _arrayFileName = arrayFileName;
        
        NSString *storyName = [[MGYGetRiceDataManager manager] story].storyName;
        NSString *filePath = [[NSBundle mainBundle] pathForResource:storyName ofType:@"plist"];
        NSArray *nodeArray = [NSArray arrayWithContentsOfFile:filePath];
        for (NSDictionary *dic in nodeArray) {
            MGYStoryNode *node = [MTLJSONAdapter modelOfClass:[MGYStoryNode class] fromJSONDictionary:dic error:nil];
            [_mutableNodes addObject:node];
        }
        
        for (NSString *fileName in arrayFileName) {
            [self.mutableFileName setValue:@(storyIndex ++)
                                    forKey:fileName];
            NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
            NSArray *nodeArray = [NSArray arrayWithContentsOfFile:filePath];
            NSMutableArray *mutableNode = [NSMutableArray array];
            for (NSDictionary *dic in nodeArray) {
                MGYStoryNode *node = [MTLJSONAdapter modelOfClass:[MGYStoryNode class] fromJSONDictionary:dic error:nil];
                [mutableNode addObject:node];
            }
            
            [_mutableStory setObject:mutableNode
                              forKey:fileName];
        }
        
        for (int i=0; i < 4; i++) {
            [_mutableProgress addObject:@(0)];
        }
        
        self.lock = [NSLock new];
        
    }
    return  self;
}

- (void)timerAction
{
    CGFloat x = _motionManager.accelerometerData.acceleration.x;
    CGFloat y = _motionManager.accelerometerData.acceleration.y;
    CGFloat z = _motionManager.accelerometerData.acceleration.z;
    if (sqrt(x*x+y*y+z*z) > 2){
        [self addPower:1];
    }
}

- (void)save:(MGYStoryNode *)node
   isplaying:(BOOL)isplaying
{
    if (node) {
        [[MGYGetRiceDataManager manager] saveStoryBuff:node.arrayBuff];
        [[MGYGetRiceDataManager manager] saveStoryProgress:node.progress];
        [[MGYGetRiceDataManager manager] saveStoryPlaynodeIndex:node.identifier];
        [[MGYGetRiceDataManager manager] saveStoryIsplaying:isplaying];
        _playNode = node;
        
        NSString *storyName = [[MGYGetRiceDataManager manager] story].storyName;
        
        [[MGYGetRiceDataManager manager] saveRiceMoveLevelRecord:[[self.mutableFileName objectForKey:storyName] integerValue]
                                                       nodeIndex:node.identifier];
        [[MGYGetRiceDataManager manager] synStory];
    }
    
    [self resetProgressArray];
}

- (instancetype)initWithNodes:(NSArray *)nodes
{
    self = [super init];
    if (self) {
        //self.nodes = nodes;

    }
    return  self;
}

- (void)dealloc
{
    if (_myLocationManager) {
        [_myLocationManager stopUpdatingLocation];
    }
}

- (void)play:(MGYStoryPlayCallback)callback firstCallback:(MGYStoryFirstPlayCallback)firstCallback
{
    MGYStory *story = [[MGYGetRiceDataManager manager] story];
    _playNode = _mutableNodes[story.playnodeIndex];
    
    [self resetProgressArray];
//    for (MGYStoryBuff *buff in self.playNode.arrayBuff) {
//        story.mutableDicBuff[@(buff.buffType)] = buff;
//    }
    if (callback) {
        callback([self getBuffImagePath]);
    }
    
    if (firstCallback && story.isfirstPlay && self.playNode.nodeType == MGYStoryNodeTypeHead) {
        [[MGYGetRiceDataManager manager] saveStoryIsfirstPlay:NO];
        firstCallback(self.playNode.storyContent);
    }
}
/**
 *  更新进度
 *
 *  @param callback 更新进度条 如果已经进入剧情则不用执行改函数 用play执行
 */
- (void)goAhead:(MGYStoryGoAheadCallback)callback
{
    //判断分支
    if (self.isplaying && self.playNode.branch.count > 1) {
        MGYStorySelectCallback selectCallback = ^(NSInteger num){
            //无条件返回剧情
            MGYStoryNode *node = _mutableNodes[num];
            [self save:node isplaying:NO];
            //callback(nil);
        };
        
        callback(selectCallback);
        return;
    }
    
//    if (_story.progress < self.playNode.progress) {
//        return;
//    }
    /**
     *  判断已经到达尾节点
     */
    if (self.playNode.nodeType == MGYStoryNodeTypeTrail) {
        return;
    }
    
    MGYStoryLevel *nextLevel = self.playNode.nextLevel;
    __block MGYStoryNode *next = _mutableNodes[nextLevel.nodeIndex];
    
//    if (_story.progress == next.progress) {
//        return;
//    }
    /**
     *  米动力足够就进入剧情
     */
    
    
    MGYTotalWalk *totalWalk = [[MGYGetRiceDataManager manager] totalWalk];
    
    if (totalWalk.power <= 0) {
        return;
    }
    MGYStory *story = [[MGYGetRiceDataManager manager] story];
    if (story.progress + totalWalk.power >= next.progress) {
        
        [self.lock lock];
        [[MGYGetRiceDataManager manager] addPower:(story.progress - next.progress)];
        [self.lock unlock];
        [self save:next isplaying:YES];
        
        if (next.branch.count > 1) {
            MGYStorySelectCallback selectCallback = ^(NSInteger num){
                //无条件返回剧情
                next = _mutableNodes[num];
                [self save:next isplaying:NO];
                
                /**
                 *    分支判断 暂时只能这样处理了
                 */

                //callback(nil);
            };
            callback(selectCallback);
            
        }else
        {
#warning 剧情
            if ([self isBoxingNode] && false) {
                MGYStoryBranch *branch = _playNode.branch[0];
                MGYStoryNode *node = _mutableNodes[branch.identifier];
                [self save:node isplaying:NO];
            }
            
            callback(nil);
            [[MGYGetRiceDataManager manager] saveStoryIsplaying:NO];
            [[MGYGetRiceDataManager manager] synStory];
        }
        return;
        
    }else
    {
        NSInteger progress = story.progress + totalWalk.power;
        [[MGYGetRiceDataManager manager] saveStoryProgress:progress];
        [[MGYGetRiceDataManager manager] synStory];
        [self.lock lock];
        [[MGYGetRiceDataManager manager] resetPower];
        [self.lock unlock];
        [self save:nil isplaying:NO];
    }
    /**
     *  不弹剧情 但要更新进度条 所以要返回
     */
    callback(nil);
}


- (void)resetProgressArray
{
    MGYStory *story = [[MGYGetRiceDataManager manager] story];
    for (int i = 1; i < _mutableNodes.count; i++) {
        if ( i-1 < story.playnodeIndex) {
            _mutableProgress[i-1] = @1;
        }else
        {
            _mutableProgress[i-1] = @(0);
        }
    }
    
    if (story.playnodeIndex <= 3 ) {
        MGYStoryNode *nextNode = _mutableNodes[story.playnodeIndex + 1];
        CGFloat progress = (story.progress - self.playNode.progress) * 1.0 / (nextNode.progress - self.playNode.progress);
        
        _mutableProgress[nextNode.identifier - 1] = @(progress);
        
    }
    NSLog(@"%@", _mutableProgress);
}

- (void)addPower:(NSInteger)num
{
    [[MGYGetRiceDataManager manager] addStep:num];
    [self.lock lock];
    /**
     *  正常情况下两步一个动力 有鞋子一步一个动力
     */
    MGYStoryBuff *buffShoes = [[MGYGetRiceDataManager manager] story].arrayBuff[MGYStoryBuffTypeShoes];
    
    if (buffShoes && buffShoes.buffState) {
        [[MGYGetRiceDataManager manager] addPower:num];
    }else
    {
        [[MGYGetRiceDataManager manager] addPower:num / 2.0];
    }
    
    [self.lock unlock];
    if (self.addPowerCallback) {
        self.addPowerCallback();
    }
}

- (void)resetStory:(NSString *)storyName
{
    MGYGetRiceDataManager *manager = [MGYGetRiceDataManager manager];
    [manager saveStoryName:storyName];
    [manager saveStoryPlaynodeIndex:0];
    [manager saveStoryProgress:0];
    [manager saveStoryIsfirstPlay:YES];
    [manager synStory];
    [_mutableNodes removeAllObjects];
    
    NSArray *arrayNode = [_mutableStory objectForKey:storyName];
    
    [_mutableNodes addObjectsFromArray:arrayNode];
    _playNode = arrayNode[manager.story.playnodeIndex];
}

- (MGYStoryLockState)getMapLockState:(NSString *)mapName
{
    if (_playNode.nodeType == MGYStoryNodeTypeTrail) {
        
        NSInteger index = _playNode.nextLevel.mapIndex;
        if ([self isBoxingBranch]&& [self isBoxingNode]) {
            index = index + 1;
        }
        if ([_arrayFileName[index] isEqualToString:mapName] || !mapName) {
            return MGYStoryLockStateUnLocked;
        }
        
    }
    return MGYStoryLockStateLocked;
}

- (MGYStoryNode *)getStoryNode:(NSString *)storyName
                         index:(NSInteger)index
{
    NSArray *arrayNode = [_mutableStory objectForKey:storyName];
    return arrayNode[index];
}

- (NSString *)getBuffImagePath
{
    MGYStory *story = [MGYGetRiceDataManager manager].story;
    if (story.arrayBuff[MGYStoryBuffTypeBear]) {
        MGYStoryBuff *buff = story.arrayBuff[MGYStoryBuffTypeBear];
        if (buff.buffState == MGYStoryBuffStateTypeOpen) {
            return buff.buffImagePath;
        }
    }
    
    if (story.arrayBuff[MGYStoryBuffTypeShoes]) {
        MGYStoryBuff *buff = story.arrayBuff[MGYStoryBuffTypeShoes];
        if (buff.buffState == MGYStoryBuffStateTypeOpen) {
            return buff.buffImagePath;
        }
    }
    return nil;
}

- (NSString *)storyDescription
{
    MGYStoryNode *node = _mutableNodes[0];
    return  node.storyContent;
}

- (NSString *)getNextStory
{
    MGYStoryNode *node = _mutableNodes[4];
    MGYStoryBranch *branch = node.branch[0];
    return branch.mapName;
}

- (NSString *)dateString:(NSString *)storyName
                   index:(NSInteger)index
{
    NSInteger storyIndex = [[self.mutableFileName objectForKey:storyName] integerValue];
    
    return [[MGYGetRiceDataManager manager] dateString:storyIndex index:index];
    
}
/**
 *  此方法不好 慎用或不要用
 *
 *  @return 是否
 */
- (BOOL)isMizhiNode
{
#warning 剧情
    if (_playNode.mutableNodeType && _playNode.mutableNodeType[[NSString stringWithFormat:@"%d", MGYStoryNodeTypeMiZhiBrach]] && false) {
        MGYStoryBranch *branch = _playNode.branch[0];
        MGYStoryNode *node = _mutableNodes[branch.identifier];
        [self save:node isplaying:NO];
        
        return YES;
    }
    return NO;
}
/**
 *  此方法不好 慎用或不要用
 *
 *  @return 是否
 */
- (BOOL)isBoxingNode
{
#warning 剧情
    if (_playNode.mutableNodeType && _playNode.mutableNodeType[[NSString stringWithFormat:@"%d", MGYStoryNodeTypeBoxingBrach]]) {
        return YES;
    }
    
    return NO;
}

/**
 *  奇葩
 *
 *  @return 是否
 */
- (BOOL)isBoxingBranch
{
    if ([MGYGetRiceDataManager manager].story.boxingBranch) {
        return YES;
    }
    return NO;
}

- (BOOL)isBoxingAndSelectNode
{
#warning 剧情
    if (_playNode.mutableNodeType && _playNode.mutableNodeType[[NSString stringWithFormat:@"%d", MGYStoryNodeTypeBoxingBrach]] && _playNode.mutableNodeType[[NSString stringWithFormat:@"%d", MGYStoryNodeTypeSelect]]) {
        return  YES;
    }
    return NO;
}

- (void)openBoxingBranch
{
    [[MGYGetRiceDataManager manager] saveStoryBoxingBranch:YES];
    //_arrayFileName = @[@"story1", @"story2", @"story3", @"story4", @"story5", @"story7", @"story8"];
}

- (BOOL)isplaying
{
    return [[MGYGetRiceDataManager manager] story].isplaying;
}

- (NSString *)getCurStoryName
{
    return [MGYGetRiceDataManager manager].story.storyName;
}

+ (instancetype)defaultPlayer
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [MGYStoryPlayer new];
    });
    return instance;
}

+ (void)enterBackground
{
    if (instance) {
        [instance.myLocationManager startUpdatingLocation];
    }
}

+ (void)outBackground
{
    if (instance) {
        [instance.myLocationManager stopUpdatingLocation];
    }
}

@end

