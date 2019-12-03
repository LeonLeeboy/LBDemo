//
//  queue.h
//  LBDemo
//
//  Created by 李兵 on 2019/12/3.
//  Copyright © 2019 ivan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ThreadSafeQueue : NSObject

/** 当前队列元素的数量 */
- (NSInteger)size;

/** 放入元素 */
- (id)put:(id)item;

/** 批量放入 */
- (void)batchPut:(id)itemList;

/** 从头部取出元素 */
- (id)popBlock:(BOOL)block timeOut:(NSTimeInterval)timeOut;

/** 取出指定的值 */
- (id)get:(NSInteger)index;

- (instancetype)initWithSize:(NSInteger)maxSize;

@end

