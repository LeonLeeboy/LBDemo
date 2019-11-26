//
//  LBLRUCache.m
//  LBDemo
//
//  Created by 李兵 on 2019/11/26.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBLRUCache.h"
#import "DoubleLinkedList.h"

@interface LBLRUCache ()

@property (nonatomic, assign) NSInteger size;

@property (nonatomic, assign) NSInteger capacity;

@property (nonatomic, strong) NSMutableDictionary *map;

@property (nonatomic, strong) DoubleLinkedList *list;

@end

@implementation LBLRUCache

- (instancetype)initWithCapacity:(NSInteger)capacity {
    if (self = [super init]) {
        self.capacity = capacity;
    }
    return self;
}

- (id)get:(id)key {
    if ([self.map containsObjectForKey:key]) {
        ListNode *node = self.map[key];
        [self.list remove:node];
        [self.list appendFront:node];
        return node.value;
    } else {
        return nil;
    }
}

- (void)put:(id)value key:(id)key {
    if ([self.map containsObjectForKey:key]) {
        ListNode *node = self.map[key];
        [self.list remove:node];
        node.value = value;
        [self.list appendFront:node];
    } else {
        ListNode *node = [[ListNode alloc] initWithValue:value key:key];
        if (self.size >= self.capacity) {// 链表已经满了
            ListNode *oldNode = [self.list remove:nil];
            [self.map removeObjectForKey:oldNode.key];
        }
        
        [self.list appendFront:node];
        self.map[key] = value;
    }
}

- (id)getLast {
    return self.list.head.value;
}

- (void)print {
    [self.list print];
}

@end
