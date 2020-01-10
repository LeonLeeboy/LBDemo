//
//  LBFIFOCache.h
//  LBDemo
//
//  Created by 李兵 on 2019/11/26.
//  Copyright © 2019 ivan. All rights reserved.
//
//  先进先出缓存置换算法
//

#import <Foundation/Foundation.h>

@class  ListNode;

NS_ASSUME_NONNULL_BEGIN

@interface LBFIFOCache : NSObject

- (id)getValue:(NSString *)key;

- (void)putValue:(id)value key:(id)key;

- (void)print;

@end

NS_ASSUME_NONNULL_END
