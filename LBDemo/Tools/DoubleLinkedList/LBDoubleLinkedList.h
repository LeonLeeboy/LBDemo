//
//  LBDoubleLinkedList.h
//  LBDemo
//
//  Created by 李兵 on 2019/12/13.
//  Copyright © 2019 ivan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LBListNode<__covariant T> : NSObject

@property (nonatomic, strong) T value;

@property (nonatomic, copy) NSString *key;

@property (nonatomic, strong, nullable) LBListNode *pre;

@property (nonatomic, strong, nullable) LBListNode *next;

- (__kindof LBListNode *)initWithKey:(NSString *)key Value:(T)value;

@end

@interface LBDoubleLinkedList : NSObject

- (LBDoubleLinkedList *)initWithCapacity:(NSInteger)capacity;

/** 增 */
/** 尾部 */
- (LBListNode *)append:(LBListNode *)node;

/** 头部 */
- (LBListNode *)appendFront:(LBListNode *)node;

/** 删除 */
/** 任意 */
- (LBListNode *)remove:(LBListNode *)node;

/** 弹出头部 */
- (LBListNode *)pop;

/** 打印 */
- (void)print;

@end

NS_ASSUME_NONNULL_END
