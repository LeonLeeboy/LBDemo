//
//  DoubleLinkedList.m
//  LBAutoReleasePool
//
//  Created by 李兵 on 2019/11/26.
//  Copyright © 2019 李兵. All rights reserved.
//

#import "DoubleLinkedList.h"

@interface ListNode ()

@property (nonatomic, strong, readwrite) id key;

@end

@implementation ListNode

- (instancetype)initWithValue:(id)value key:(NSString *)key{
    if (self = [super init]) {
        self.value = value;
        self.key = key;
        self.prev = nil;
        self.next = nil;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"{%@,%@}",self.key,self.value];
}

@end

@interface DoubleLinkedList ()

@property (nonatomic, assign) NSInteger capacity;

@property (nonatomic, assign) NSInteger size;

@end

@implementation DoubleLinkedList

- (instancetype)initWithCapcity:(NSInteger)capacity {
    if (self = [super init]) {
        self.capacity = capacity;
        self.head = nil;
        self.tail = nil;
        self.size = 0;
    }
    return self;
}

#pragma mark - public
/** 弹出头部 */
- (ListNode *)pop {
    return [self p_delHead];
}

- (void)append:(ListNode *)listNode {
    [self p_addTail:listNode];
}

- (void)appendFront:(ListNode *)listNode {
    [self p_addHead:listNode];
}

- (ListNode *)remove:(ListNode *)node {
    return [self p_remove:node];
}

- (void)print {
    ListNode *p = self.head;
    NSString *line = @"";
    while (p) {
        line = [line stringByAppendingFormat:@"%@",p.description];
        p = p.next;
        if (p) {
            line = [line stringByAppendingFormat:@"=>"];
        }
    }
    NSLog(@"%@",line);
}


#pragma mark - private
- (ListNode *)p_addHead:(ListNode *)node {
    if (!node) {
        return node;
    }
    
    self.size += 1;
    if (!self.head) {
        self.head = node;
        self.tail = node;
        self.head.prev = nil;
        self.head.next = nil;
        return node;
    }
    node.next = self.head;
    self.head.prev = node;
    self.head = node;
    self.head.prev = nil;
    
    return node;
    
}

/** tail 增加节点 */
- (ListNode *)p_addTail:(ListNode *)node {
    if (!self.tail) {
        self.head = node;
        self.tail = node;
        self.tail.prev = nil;
        self.tail.next = nil;
    } else {
        self.tail.next = node;
        node.prev = self.tail;
        self.tail = node;
        self.tail.next = nil;
    }
    self.size += 1;
    
    return node;
}

/** 任意节点删除 */
- (ListNode *)p_remove:(ListNode *)node {
    //如果nodel == nil 默认删除尾部节点
    if (!node) {
        node = self.tail;
    }
    if (node == self.tail) {
        [self p_delTail];
    } else if (node == self.head) {
        [self p_delHead];
    } else {
        node.prev.next = node.next;
        node.next.prev = node.prev;
        self.size -= 1;
    }
    return node;
}


- (void)p_delTail {
    if (!self.tail) {
        return ;
    }
    ListNode *node = self.tail;
    if (node.prev) {
        self.tail = node.prev;
        self.tail.next = nil;
    } else {
        self.head = self.tail = nil;
    }
    self.size -= 1;

    return;
}

- (ListNode *)p_delHead {
    if (!self.head) {
        return self.head;
    }
    ListNode *node = self.head;
    if (self.head.next) {
        self.head = node.next;
        self.head.prev = nil;
        self.size -= 1;
    } else {
        self.head = self.tail = nil;
    }
    
    return node;
}

@end
