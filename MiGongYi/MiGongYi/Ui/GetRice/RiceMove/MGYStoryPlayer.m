//
//  MGYStoryPlayer.m
//  MiGongYi
//
//  Created by megil on 10/28/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYStoryPlayer.h"

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
@property (nonatomic, strong) NSMutableArray *mutableNodes;


@end

@implementation MGYStoryPlayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        //读取配置文件 这里读取第一个故事
        
        _story = [MGYStory new];
        _story.storyName = @"story1";
        _story.storyIndex = 0;
        _story.progress = 0;
        _story.playnodeIndex = 0;
        _story.isfirstPlay = YES;
        _story.mutableDicBuff = [NSMutableDictionary dictionary];
        _totalWalk = [MGYTotalWalk new];
        _totalWalk.timeSp = [[NSDate date] timeIntervalSince1970];
        _totalWalk.power = 999999999;
        _mutableStory = [NSMutableDictionary dictionary];
        _mutableProgress = [NSMutableArray array];
        _mutableNodes = [NSMutableArray array];
        _motionManager = [CMMotionManager new];
        _motionManager.accelerometerUpdateInterval = 1./60;
        [_motionManager startAccelerometerUpdates];
        _myLocationManager = [[CLLocationManager alloc] init];// 初始化
        [_myLocationManager setDesiredAccuracy:kCLLocationAccuracyBest];// 设置精度值
        [_myLocationManager setDelegate:self];// 设置代理
        [_myLocationManager startUpdatingLocation];
        
        [NSTimer scheduledTimerWithTimeInterval:1.0/5.0
                                         target:self
                                       selector:@selector(timerAction)
                                       userInfo:nil
                                        repeats:YES];
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Config" ofType:@"plist"];
        NSArray *arrayFileName = [NSArray arrayWithContentsOfFile:plistPath];
        _arrayFileName = arrayFileName;
        NSString *filePath = [[NSBundle mainBundle] pathForResource:_story.storyName ofType:@"plist"];
        NSArray *nodeArray = [NSArray arrayWithContentsOfFile:filePath];
        for (NSDictionary *dic in nodeArray) {
            MGYStoryNode *node = [MTLJSONAdapter modelOfClass:[MGYStoryNode class] fromJSONDictionary:dic error:nil];
            [_mutableNodes addObject:node];
        }
        
        for (NSString *fileName in arrayFileName) {
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
    //NSLog(@"%f %f %f", _motionManager.accelerometerData.acceleration.x, _motionManager.accelerometerData.acceleration.y, _motionManager.accelerometerData.acceleration.z);
    CGFloat x = _motionManager.accelerometerData.acceleration.x;
    CGFloat y = _motionManager.accelerometerData.acceleration.y;
    CGFloat z = _motionManager.accelerometerData.acceleration.z;
    if (sqrt(x*x+y*y+z*z) >2){
        [self addPower:STEP];
    }
}

- (void)save:(MGYStoryNode *)node
{
    if (node) {
        _story.progress = node.progress;
        _story.playnodeIndex = node.identifier;
        _playNode = node;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        MGYStoryNode *snode = [self getStoryNode:_story.storyName
                                           index:node.identifier - 1];
        snode.dateString = [dateFormatter stringFromDate:[NSDate date]];
        [self resetProgressArray];
    }
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
    _playNode = _mutableNodes[_story.playnodeIndex];
    
    [self resetProgressArray];
    for (MGYStoryBuff *buff in self.playNode.arrayBuff) {
        _story.mutableDicBuff[@(buff.buffType)] = buff;
    }
    if (callback) {
        callback([self getBuffImagePath]);
    }
    
    if (firstCallback && _story.isfirstPlay && self.playNode.nodeType == MGYStoryNodeTypeHead) {
        _story.isfirstPlay = NO;
        firstCallback(self.playNode.storyContent);
    }
    MGYStoryNode *node = _mutableNodes[4];
    NSLog(@"%@", node.mutableNodeType[[NSString stringWithFormat:@"%d", MGYStoryNodeTypeBoxingBrach]]);
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
            [self save:node];
            _isplaying = NO;
            //callback(nil);
        };
        
        callback(selectCallback);
        return;
    }
    
    for (MGYStoryBuff *buff in self.playNode.arrayBuff) {
        _story.mutableDicBuff[@(buff.buffType)] = buff;
    }
    
    if (_story.progress < self.playNode.progress) {
        return;
    }
    /**
     *  判断已经到达尾节点
     */
    if (self.playNode.nodeType == MGYStoryNodeTypeTrail) {
        return;
    }
    
    MGYStoryLevel *nextLevel = self.playNode.nextLevel;
    __block MGYStoryNode *next = _mutableNodes[nextLevel.nodeIndex];
    
    if (_story.progress == next.progress) {
        return;
    }
    /**
     *  米动力足够就进入剧情
     */
    if (_story.progress + _totalWalk.power >= next.progress) {
        
        _isplaying = YES;
        [self.lock lock];
        _totalWalk.power = _totalWalk.power - next.progress + _story.progress;
        [self.lock unlock];
        [self save:next];
        
        if (next.branch.count > 1) {
            MGYStorySelectCallback selectCallback = ^(NSInteger num){
                //无条件返回剧情
                next = _mutableNodes[num];
                [self save:next];
                _isplaying = NO;
                
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
                [self save:node];
            }
            
            callback(nil);
            _isplaying = NO;
        }
        return;
        
    }else
    {
        _story.progress = _story.progress + _totalWalk.power;
        [self.lock lock];
        _totalWalk.power = 0;
        [self.lock unlock];
        [self save:nil];
    }
    /**
     *  不弹剧情 但要更新进度条 所以要返回
     */
    callback(nil);
}


- (void)resetProgressArray
{
    for (int i = 1; i < _mutableNodes.count; i++) {
        if ( i-1 < _story.playnodeIndex) {
            _mutableProgress[i-1] = @1;
        }else
        {
            _mutableProgress[i-1] = @(0);
        }
    }
    
    if (_story.playnodeIndex <= 3 ) {
        MGYStoryNode *nextNode = _mutableNodes[_story.playnodeIndex + 1];
        CGFloat progress = (_story.progress - self.playNode.progress) * 1.0 / (nextNode.progress - self.playNode.progress);
        
        _mutableProgress[nextNode.identifier - 1] = @(progress);
        
    }
    NSLog(@"%@", _mutableProgress);
}

- (void)addPower:(NSInteger)num
{
    _totalWalk.totalStep = _totalWalk.totalStep + num;
    _totalWalk.curStep = _totalWalk.curStep + num;
    
    [self.lock lock];
    /**
     *  正常情况下两步一个动力 有鞋子一步一个动力
     */
    
    MGYStoryBuff *buffShoes = _story.mutableDicBuff[@(MGYStoryBuffTypeShoes)];
    
    if (buffShoes && buffShoes.buffState) {
        _totalWalk.power = _totalWalk.power + num;
    }else
    {
        _totalWalk.power = _totalWalk.power + num / 2;
    }
    
    [self.lock unlock];
    if (self.addPowerCallback) {
        self.addPowerCallback();
    }
}

- (void)resetStory:(NSString *)storyName
{
    _story.storyName = storyName;
    _story.playnodeIndex = 0;
    _story.progress = 0;
    _story.isfirstPlay = YES;
    [_mutableNodes removeAllObjects];
    
    NSArray *arrayNode = [_mutableStory objectForKey:storyName];
    
    [_mutableNodes addObjectsFromArray:arrayNode];
    _playNode = arrayNode[_story.playnodeIndex];
}

- (MGYStoryLockState)getMapLockState:(NSString *)mapName
{
    if (_playNode.nodeType == MGYStoryNodeTypeTrail) {
        
        if ([_arrayFileName[_playNode.nextLevel.mapIndex] isEqualToString:mapName] || !mapName) {
            return MGYStoryLockStateUnLocked;
        }
    }
    return MGYStoryLockStateLocked;
}

- (NSString *)getStoryContent:(NSString *)storyName
                        index:(NSInteger)index
{
    NSArray *arrayNode = [_mutableStory objectForKey:storyName];
    MGYStoryNode *node = arrayNode[index + 1];
    
    return node.storyContent;
}

- (MGYStoryNode *)getStoryNode:(NSString *)storyName
                         index:(NSInteger)index
{
    NSArray *arrayNode = [_mutableStory objectForKey:storyName];
    return arrayNode[index + 1];
}

- (NSString *)getBuffImagePath
{
    if (_story.mutableDicBuff[@(MGYStoryBuffTypeBear)]) {
        MGYStoryBuff *buff = _story.mutableDicBuff[@(MGYStoryBuffTypeBear)];
        if (buff.buffState == MGYStoryBuffStateTypeOpen) {
            return buff.buffImagePath;
        }
    }
    
    if (_story.mutableDicBuff[@(MGYStoryBuffTypeShoes)]) {
        MGYStoryBuff *buff = _story.mutableDicBuff[@(MGYStoryBuffTypeShoes)];
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
        [self save:node];
        
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
    if (_story.boxingBranch) {
        return YES;
    }
    return NO;
}

- (BOOL)isBoxingAndSelectNode
{
#warning 剧情
    if (_playNode.mutableNodeType && _playNode.mutableNodeType[[NSString stringWithFormat:@"%d", MGYStoryNodeTypeBoxingBrach]] && _playNode.mutableNodeType[[NSString stringWithFormat:@"%d", MGYStoryNodeTypeSelect]] && false) {
        return  YES;
    }
    return NO;
}

- (void)openBoxingBranch
{
    _story.boxingBranch = YES;
    _arrayFileName = @[@"story1", @"story2", @"story3", @"story4", @"story5", @"story7", @"story8"];
}

- (NSString *)getCurStoryName
{
    return _story.storyName;
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

