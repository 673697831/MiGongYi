//
//  MGYStoryPlayer.m
//  MiGongYi
//
//  Created by megil on 10/28/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYStoryPlayer.h"

@implementation MGYStoryPlayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        //读取配置文件 这里读取第一个故事
        
        //self.storyName = @"story1";
        self.story = [MGYStory new];
        _story.storyName = @"story2";
        _story.storyIndex = 1;
        _story.progress = 5000;
        _totalWalk = [MGYTotalWalk new];
        _totalWalk.timeSp = [[NSDate date] timeIntervalSince1970];
        _actionNodeArray = [NSMutableArray array];
        _progressArray = [NSMutableArray array];
        _mutableDicBuff = [NSMutableDictionary dictionary];
        _nodes = [NSMutableArray array];
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Config" ofType:@"plist"];
        NSArray *fileNameArray = [NSArray arrayWithContentsOfFile:plistPath];
        
        for (NSString *fileName in fileNameArray) {
            NSString *filePath = [[NSBundle mainBundle] pathForResource:_story.storyName ofType:@"plist"];
            NSArray *nodeArray = [NSArray arrayWithContentsOfFile:filePath];
            for (NSDictionary *dic in nodeArray) {
                MGYStoryNode *node = [MTLJSONAdapter modelOfClass:[MGYStoryNode class] fromJSONDictionary:dic error:nil];
                //[nodes addObject:node];
                [_nodes addObject:node];
                if (node.nodeType == MGYStoryNodeTypeAction) {
                    [_actionNodeArray addObject:node];
                }
            }
            break;
        }
        //self.nodes = nodes;
        
        for (int i=0; i < 4; i++) {
            [_progressArray addObject:@(0)];
        }
        
        self.lock = [NSLock new];
        
    }
    return  self;
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
    if (!self.playNode) {
        self.playNode = _nodes[0];
        
    }
    if (callback) {
        callback();
    }
}

- (void)goAhead:(MGYStoryGoAheadCallback)callback
{
    for (MGYStoryBuff *buff in self.playNode.arrayBuff) {
        _mutableDicBuff[@(buff.buffType)] = @(buff.buffState);
    }
    
    if (_story.progress < self.playNode.progress) {
        return;
    }
    
    if (self.playNode.nodeType == MGYStoryNodeTypeTrail) {
        return;
    }
    
    MGYStoryBranch *brach = self.playNode.branch[0];
    __block MGYStoryNode *next = _nodes[brach.identifier];
    
    if (_story.progress == next.progress) {
        return;
    }
    
    if (_story.progress + _totalWalk.power >= next.progress) {
        
        [self.lock lock];
        _totalWalk.power = _totalWalk.power - next.progress + _story.progress;
        [self.lock unlock];
        _story.progress = next.progress;
        
        if (next.branch.count > 1) {
            MGYStorySelectCallback selectCallback = ^(NSInteger num){
                if (brach.mapName && brach.mapName != _story.storyName) {
                    MGYStoryBranch *brach = next.branch[num];
                    next = _nodes[brach.identifier];
                }
                //MGYStoryNode *next = _nodes[brach.identifier];
                self.playNode = next;
                _story.progress = next.progress;
                [self resetProgressArray];
                NSLog(@"%@", _progressArray);
            };
            
            callback(selectCallback, _progressArray, _totalWalk);
            return;
        }else
        {
            [self resetProgressArray];
            callback(nil, _progressArray, _totalWalk);
            NSLog(@"%@", _progressArray);
        }
        self.playNode = next;
        
    }else
    {
        _story.progress = _story.progress + _totalWalk.power;
        [self.lock lock];
         _totalWalk.power = 0;
        [self.lock unlock];
        [self resetProgressArray];
    }
    
    callback(nil, _progressArray, _totalWalk);
}

- (void)resetProgressArray
{
    for (int i = 1; i < _nodes.count; i++) {
        if ( i-1 <=self.playNode.identifier) {
            _progressArray[i-1] = @1;
        }else
        {
            _progressArray[i-1] = @(0);
        }
    }
    
    if (self.playNode.identifier < 3 ) {
        MGYStoryNode *nextNode = _nodes[self.playNode.identifier + 1];
        CGFloat progress = (_story.progress - self.playNode.progress) * 1.0 / (nextNode.progress - self.playNode.progress);
        NSLog(@"%f", progress);
        
        _progressArray[nextNode.identifier - 1] = @(progress);
        
    }
}

- (void)addPower:(NSInteger)num
        callback:(MGYStoryAddPowerCallback)callback
{
    _totalWalk.totalStep = _totalWalk.totalStep + num;
    _totalWalk.curStep = _totalWalk.curStep + num;
    
    [self.lock lock];
    /**
     *  正常情况下两步一个动力 有鞋子一步一个动力
     */
    if (!_mutableDicBuff[@(MGYStoryBuffTypeShoes)]) {
        _totalWalk.power = _totalWalk.power + num / 2.0;
    }else
    {
        _totalWalk.power = _totalWalk.power + num;
    }
    
    [self.lock unlock];
    NSLog(@"walk ~~~~~%@", _totalWalk);
    if (callback) {
        callback(_totalWalk);
    }
}

- (void)saveNode
{
    if (self.playNode.identifier > 0 && self.playNode.identifier < 5) {
        if (self.story.nodeArray.count < self.playNode.identifier - 1) {
            
        }
    }
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
