//
//  DoubleLinkedList.h
//  LBAutoReleasePool
//
//  Created by 李兵 on 2019/11/26.
//  Copyright © 2019 李兵. All rights reserved.
//
//  双向链表
//

#import <Foundation/Foundation.h>


@interface ListNode : NSObject

@property (nonatomic, strong) id value;

@property (nonatomic, strong, readonly) id key;

@property (nonatomic, strong) ListNode *prev;

@property (nonatomic, strong) ListNode *next;

- (instancetype)initWithValue:(id)value key:(NSString *)key;

@end

@interface DoubleLinkedList : NSObject

@property (nonatomic, strong) ListNode *head;

@property (nonatomic, strong) ListNode *tail;

@property (nonatomic, assign, readonly) NSInteger size;

#pragma mark - Method
/** 构造方法 */
- (instancetype)initWithCapcity:(NSInteger)capacity;

/** 添加头部节点 */
- (void)appendFront:(ListNode *)listNode;

/** 添加尾部节点 */
- (ListNode *)append:(ListNode *)listNode;

/** 删除 */
- (ListNode *)remove:(ListNode *)node;

/** 弹出头部 */
- (ListNode *)pop;

/** 打印 */
- (void)print;


@end
