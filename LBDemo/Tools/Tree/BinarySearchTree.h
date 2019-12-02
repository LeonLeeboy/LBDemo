//
//  BinarySearchTree.h
//  LBDemo
//
//  Created by 李兵 on 2019/12/2.
//  Copyright © 2019 ivan. All rights reserved.
//
//  二叉查找树
//

#import <Foundation/Foundation.h>
#import "Node.h"

NS_ASSUME_NONNULL_BEGIN

@interface BinarySearchTree : NSObject


/** 增 */
- (void)insert:(id)value;

/** 删 */
- (void)del:(id)value;

/** 查 */
- (Node *)find:(id)value;

/** 获得最大 */
- (Node *)getMax;

/** 获得最小 */
- (Node *)getMin;


@end

NS_ASSUME_NONNULL_END
