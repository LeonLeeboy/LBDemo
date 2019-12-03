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

- (id)getHighFreqValue {
    NSInteger maxFreq = [self p_getMaxFeq:self.freqMap];
    DoubleLinkedList *l = [self p_getFreqList:maxFreq];
    LFUNode *node = (LFUNode *)[l pop];
    return node.value;
}

-(id)getLowFreqValue {
    NSInteger minFreq = [self p_getMinFeq:self.freqMap];
    DoubleLinkedList *l = [self p_getFreqList:minFreq];
    LFUNode *node = (LFUNode *)[l pop];
    return node.value;
}

- (id)get:(id)key {
    if (![self.map containsObjectForKey:key]) {
        return nil;
    }
    LFUNode *node = self.map[key];
    [self p_updateFreq:node];
    return node.value;
}

- (void)put:(id)value key:(id)key {
    if (self.capacity == 0) {
        return;
    }
    
    if ([self.map containsObjectForKey:key]) {//缓存命中
        LFUNode *node = self.map[key];
        node.value = value;
        [self p_updateFreq:node];
    } else { // 缓存没有命中
        if (self.capacity == self.size) {
            NSInteger minFreq = [self p_getMinFeq:self.freqMap];
            DoubleLinkedList *list = [self p_getFreqList:minFreq];
            [list pop];
            [self.map removeObjectForKey:key];
            self.size -= 1;
        }
        LFUNode *node = [[LFUNode alloc] initWithValue:value key:key];
        node.freq = 1;
        self.map[key] = node;
        NSString *freqKey = [self p_getFreqMapKey:node.freq];
        if (![self.freqMap containsObjectForKey:freqKey]) {
            self.freqMap[freqKey] = [[DoubleLinkedList alloc] initWithCapcity:self.capacity];
        }
        DoubleLinkedList *linkedList = self.freqMap[freqKey];
        [linkedList append:node];
        self.size += 1;
    }
}

- (void)print {
    NSLog(@"************************");
    [self.freqMap enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, DoubleLinkedList * _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"Freq = %@\n",key);
        [obj print];
    }];
    NSLog(@"************************");
    NSLog(@"\n");
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
    }
    DoubleLinkedList *l = self.freqMap[key];
    [l append:node];
}

- (NSString *)p_getFreqMapKey:(NSInteger)freq {
    return [NSString stringWithFormat:@"%ld",(long)freq];
}

/** 频率最低的freq */
- (NSInteger)p_getMinFeq:(NSDictionary *)freqMap {
    NSArray *allKeys = [freqMap.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    return [allKeys.firstObject integerValue];
}

/** 最高频率 */
- (NSInteger)p_getMaxFeq:(NSDictionary *)freqMap {
    NSArray *allKeys = [freqMap.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    return [allKeys.lastObject integerValue];
}

/** 频率 -> list */
- (DoubleLinkedList *)p_getFreqList:(NSInteger)freq {
    NSString *key = [self p_getFreqMapKey:freq];
    return self.freqMap[key];
}

@end


