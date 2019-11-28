//
//  LBLFUCache.h
//  LBDemo
//
//  Created by 李兵 on 2019/11/26.
//  Copyright © 2019 ivan. All rights reserved.
//
//  least frequency using
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LBLFUCache : NSObject

- (instancetype)initWithCapacity:(NSInteger)capacity;

/** 获得指定的值 */
- (id)get:(id)key;

/** 添加（值） */
- (void)put:(id)value key:(id)key;

/** 获得最高（频率） */
- (id)getHighFreqValue;

/** 获得最低（频率） */
-(id)getLowFreqValue;

- (void)print;

@end

NS_ASSUME_NONNULL_END
