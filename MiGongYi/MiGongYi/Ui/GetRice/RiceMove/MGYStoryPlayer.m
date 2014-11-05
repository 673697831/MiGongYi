//
//  MGYStoryPlayer.m
//  MiGongYi
//
//  Created by megil on 10/28/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>
#import "MGYStoryPlayer.h"

#define STEP 20000

@interface MGYStoryPlayer ()
{
    NSMutableDictionary *_mutableStory;
}

@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, assign) BOOL isplaying;

@end

@implementation MGYStoryPlayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        //读取配置文件 这里读取第一个故事
        
        //self.storyName = @"story1";
        _story = [MGYStory new];
        _story.storyName = @"story1";
        _story.storyIndex = 0;
        _story.progress = 0;
        _story.playnodeIndex = 0;
        _story.mutableDicBuff = [NSMutableDictionary dictionary];
        _totalWalk = [MGYTotalWalk new];
        _totalWalk.timeSp = [[NSDate date] timeIntervalSince1970];
        //_actionNodeArray = [NSMutableArray array];
        _progressArray = [NSMutableArray array];
        _mutableStory = [NSMutableDictionary dictionary];
        //_mutableDicBuff = [NSMutableDictionary dictionary];
        _nodes = [NSMutableArray array];
        _motionManager = [CMMotionManager new];
        _motionManager.accelerometerUpdateInterval = 1./60;
        [_motionManager startAccelerometerUpdates];
        [NSTimer scheduledTimerWithTimeInterval:1.0/5.0
                                         target:self
                                       selector:@selector(timerAction)
                                       userInfo:nil
                                        repeats:YES];
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Config" ofType:@"plist"];
        NSArray *fileNameArray = [NSArray arrayWithContentsOfFile:plistPath];
        _fileNameArray = fileNameArray;
        NSString *filePath = [[NSBundle mainBundle] pathForResource:_story.storyName ofType:@"plist"];
        NSArray *nodeArray = [NSArray arrayWithContentsOfFile:filePath];
        for (NSDictionary *dic in nodeArray) {
            MGYStoryNode *node = [MTLJSONAdapter modelOfClass:[MGYStoryNode class] fromJSONDictionary:dic error:nil];
            [_nodes addObject:node];
//            if (node.nodeType != MGYStoryNodeTypeHead) {
//                [_actionNodeArray addObject:node];
//            }
        }
        
        for (NSString *fileName in fileNameArray) {
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
        //self.nodes = nodes;
        
        for (int i=0; i < 4; i++) {
            [_progressArray addObject:@(0)];
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
        self.playNode = node;
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

- (void)play:(MGYStoryPlayCallback)callback
{
    self.playNode = _nodes[_story.playnodeIndex];
    
    [self resetProgressArray];
    
    if (callback) {
        callback();
    }
}

- (void)goAhead:(MGYStoryGoAheadCallback)callback
{
    //判断分支
    if (self.isplaying && self.playNode.branch.count > 1) {
        MGYStorySelectCallback selectCallback = ^(NSInteger num){
            //无条件返回剧情
            if (num != 0) {
                MGYStoryBranch *brach = self.playNode.branch[num];
                MGYStoryNode *node = _nodes[brach.identifier];
                [self save:node];
            }
            self.isplaying = NO;
        };
        
        callback(_nodes[_story.playnodeIndex], selectCallback);
        return;
    }
    self.isplaying = YES;
    for (MGYStoryBuff *buff in self.playNode.arrayBuff) {
        _story.mutableDicBuff[@(buff.buffType)] = @(buff.buffState);
    }
    
    if (_story.progress < self.playNode.progress) {
        return;
    }
    
    if (self.playNode.nodeType == MGYStoryNodeTypeTrail) {
        return;
    }
    
    MGYStoryLevel *nextLevel = self.playNode.nextLevel;
    __block MGYStoryNode *next = _nodes[nextLevel.nodeIndex];
    
    if (_story.progress == next.progress) {
        return;
    }
    
    if (_story.progress + _totalWalk.power >= next.progress) {
        
        [self.lock lock];
        _totalWalk.power = _totalWalk.power - next.progress + _story.progress;
        [self.lock unlock];
        [self save:next];
        [self resetProgressArray];
        
        if (next.branch.count > 1) {
            MGYStorySelectCallback selectCallback = ^(NSInteger num){
                //无条件返回剧情
                next = _nodes[num];
                [self save:next];
                self.isplaying = NO;
                [self resetProgressArray];
                callback(nil, nil);
                NSLog(@"%@", _progressArray);
            };
            
            callback(next, selectCallback);
            
        }else
        {
            callback(next, nil);
            self.isplaying = NO;
        }
        return;
        
    }else
    {
        _story.progress = _story.progress + _totalWalk.power;
        [self.lock lock];
        _totalWalk.power = 0;
        [self.lock unlock];
        [self save:nil];
        [self resetProgressArray];
    }
    
    callback(nil,nil);
    self.isplaying = NO;
}


- (void)resetProgressArray
{
    for (int i = 1; i < _nodes.count; i++) {
        if ( i-1 < _story.playnodeIndex) {
            _progressArray[i-1] = @1;
        }else
        {
            _progressArray[i-1] = @(0);
        }
    }
    
    if (_story.playnodeIndex <= 3 ) {
        MGYStoryNode *nextNode = _nodes[_story.playnodeIndex + 1];
        CGFloat progress = (_story.progress - self.playNode.progress) * 1.0 / (nextNode.progress - self.playNode.progress);
        NSLog(@"%f", progress);
        
        _progressArray[nextNode.identifier - 1] = @(progress);
        
    }
}

- (void)addPower:(NSInteger)num
{
    _totalWalk.totalStep = _totalWalk.totalStep + num;
    _totalWalk.curStep = _totalWalk.curStep + num;
    
    [self.lock lock];
    /**
     *  正常情况下两步一个动力 有鞋子一步一个动力
     */
    if (!_story.mutableDicBuff[@(MGYStoryBuffTypeShoes)]) {
        _totalWalk.power = _totalWalk.power + num / 2.0;
    }else
    {
        _totalWalk.power = _totalWalk.power + num;
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
    [_nodes removeAllObjects];
    
    NSArray *nodeArray = [_mutableStory objectForKey:storyName];
    
    [_nodes addObjectsFromArray:nodeArray];
    _playNode = nodeArray[_story.playnodeIndex];
    //_story.storyIndex = _fileNameArray
}

- (MGYStoryLockState)getMapLockState:(NSString *)mapName
{
    if (_playNode.nodeType == MGYStoryNodeTypeTrail) {
         //MGYStoryBranch *branch = self.playNode.branch[0];
        
        if ([_fileNameArray[_playNode.nextLevel.mapIndex] isEqualToString:mapName]) {
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

- (NSString *)getNextStory
{
    MGYStoryNode *node = _nodes[4];
    MGYStoryBranch *branch = node.branch[0];
    return branch.mapName;
}

- (NSString *)getCurStoryName
{
    return _story.storyName;
}

+ (instancetype)defaultPlayer
{
    static MGYStoryPlayer *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [MGYStoryPlayer new];
    });
    return instance;
}

@end
