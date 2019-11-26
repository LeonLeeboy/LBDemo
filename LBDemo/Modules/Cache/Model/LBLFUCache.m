//
//  LBLFUCache.m
//  LBDemo
//
//  Created by 李兵 on 2019/11/26.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBLFUCache.h"
#import "DoubleLinkedList.h"

@interface LFUNode : ListNode

@property (nonatomic, assign) NSInteger freq;

@end

@implementation LFUNode

- (instancetype)initWithValue:(id)value key:(NSString *)key {
    if (self = [super initWithValue:value key:key]) {
        self.freq = 0;
    }
    return self;
}

@end

#pragma mark -
#pragma mark 实现类

@interface LBLFUCache ()

@property (nonatomic, assign) NSInteger capacity;

@property (nonatomic, assign) NSInteger size;

@property (nonatomic, strong) NSMutableDictionary *map;

/** 频率对应的双向链表 :key是频率，value是对应频率的双向链表 */
@property (nonatomic, strong) NSMutableDictionary<NSString *,DoubleLinkedList *> *freqMap;

@end


@implementation LBLFUCache

- (instancetype)initWithCapacity:(NSInteger)capacity {
    if (self = [super init]) {
        self.capacity = capacity;
        self.size = 0;
        self.map = @{}.mutableCopy;
        self.freqMap = @{}.mutableCopy;
    }
    return self;
}

- (id)get:(id)key {
    if ([self.map containsObjectForKey:key]) {
        LFUNode *node = self.map[key];
        return node.value;
    }
    return nil;
}

- (void)put:(id)value key:(id)key {
    
}

#pragma mark - private
/** 跟新节点频率的操作 */
- (void)p_updateFreq:(LFUNode *)node {
    NSInteger freq = node.freq;
    NSString *key = [NSString stringWithFormat:@"%ld",(long)freq];
    DoubleLinkedList *list = self.freqMap[key];
    [list remove:node];
    
}

@end


