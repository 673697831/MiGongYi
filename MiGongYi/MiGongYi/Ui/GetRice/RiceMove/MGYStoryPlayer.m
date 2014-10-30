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
        
        self.storyName = @"story3";
        _actionNodeArray = [NSMutableArray array];
        _progressArray = [NSMutableArray array];
        _mutableDicBuff = [NSMutableDictionary dictionary];
        _nodes = [NSMutableArray array];
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Config" ofType:@"plist"];
        NSArray *fileNameArray = [NSArray arrayWithContentsOfFile:plistPath];
        
        for (NSString *fileName in fileNameArray) {
            NSString *filePath = [[NSBundle mainBundle] pathForResource:self.storyName ofType:@"plist"];
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
    
    if (self.progress < self.playNode.progress) {
        return;
    }
    
    if (self.playNode.nodeType == MGYStoryNodeTypeTrail) {
        return;
    }
    
    MGYStoryBranch *brach = self.playNode.branch[0];
    __block MGYStoryNode *next = _nodes[brach.identifier];
    
    if (self.progress == next.progress) {
        return;
    }
    
    if (self.progress + _power >= next.progress) {
        
        [self.lock lock];
        _power = _power - next.progress + self.progress;
        [self.lock unlock];
        self.progress = next.progress;
        
        if (next.branch.count > 1) {
            MGYStorySelectCallback selectCallback = ^(NSInteger num){
                if (brach.mapName && brach.mapName != self.storyName) {
                    MGYStoryBranch *brach = next.branch[num];
                    next = _nodes[brach.identifier];
                }
                //MGYStoryNode *next = _nodes[brach.identifier];
                self.playNode = next;
                self.progress = next.progress;
                [self resetProgressArray];
                NSLog(@"%@", _progressArray);
            };
            
            callback(selectCallback);
            return;
        }else
        {
            [self resetProgressArray];
            NSLog(@"%@", _progressArray);
        }
        self.playNode = next;
        
    }else
    {
        self.progress = self.progress + _power;
        [self.lock lock];
        _power = 0;
        [self.lock unlock];
    }
    
    callback(nil);
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
}

- (void)addPower:(NSInteger)num
{
    [self.lock lock];
    /**
     *  正常情况下两步一个动力 有鞋子一步一个动力
     */
    if (!_mutableDicBuff[@(MGYStoryBuffTypeShoes)]) {
        num = num / 2;
    }
    _power = _power + num;
    [self.lock unlock];
}

@end
