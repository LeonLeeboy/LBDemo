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
    if (self.capacity == 0) {
        return;
    }
    
}

#pragma mark - private
/** 跟新节点频率的操作 */
- (void)p_updateFreq:(LFUNode *)node {
    // 删除
    NSInteger freq = node.freq;
    NSString *key = [self p_getFreqMapKey:freq];
    DoubleLinkedList *list = self.freqMap[key];
    if (list) {
        [list remove:node];
    }
   
    // 更新
    freq += 1;
    node.freq = freq;
    key = [self p_getFreqMapKey:freq];
    if (![self.freqMap containsObjectForKey:key]) {
        self.freqMap[key] = [[DoubleLinkedList alloc] initWithCapcity:self.capacity?:1000];
    } else {
        DoubleLinkedList *l = self.freqMap[key];
        [l append:node];
    }
}

- (NSString *)p_getFreqMapKey:(NSInteger)freq {
    return [NSString stringWithFormat:@"%ld",(long)freq];
}

@end


