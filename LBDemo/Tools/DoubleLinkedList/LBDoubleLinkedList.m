//
//  LBDoubleLinkedList.m
//  LBDemo
//
//  Created by 李兵 on 2019/12/13.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBDoubleLinkedList.h"

@implementation LBListNode


- (LBListNode *)initWithKey:(NSString *)key Value:(id)value {
    if (self = [super init]) {
        self.key = key;
        self.value = value;
    }
    return self;
}

@end

@interface LBDoubleLinkedList ()

@property (nonatomic, assign) NSInteger capacity;

@property (nonatomic, assign) NSInteger size;

@property (nonatomic, strong) LBListNode *head;

@property (nonatomic, strong) LBListNode *tail;

@end

@implementation LBDoubleLinkedList

#pragma mark - life cycle
- (LBDoubleLinkedList *)initWithCapacity:(NSInteger)capacity {
    if (self = [super init]) {
        self.capacity = capacity;
        self.size = 0;
        self.head = nil;
        self.tail = nil;
    }
    return self;
}

#pragma mark - public
- (LBListNode *)append:(LBListNode *)node {
    return [self p_addTail:node];
}

- (LBListNode *)appendFront:(LBListNode *)node {
    return [self p_addHead:node];
}

#pragma mark - private

- (LBListNode *)p_addHead:(LBListNode *)node {
    
    if (!node) {
        return node;
    }
    
    if (!self.head) {
        self.head = node;
        self.tail = node;
        self.head.pre = nil;
        self.tail.next = nil;
    } else {
        self.head.pre = node;
        node.next = self.head;
        self.head = node;
        self.head.pre = nil;
    }
    self.size += 1;
    return node;
}

- (LBListNode *)p_addTail:(LBListNode *)node {
    if (!node) {
        return node;
    }
    
    if (!self.tail) {
        self.head = node;
        self.tail = node;
        self.head.pre = nil;
        self.tail.next = nil;
    } else {
        self.tail.next = node;
        node.pre = self.tail;
        self.tail = node;
        self.tail.next = nil;
    }
    self.size += 1;
    return node;
}







@end
