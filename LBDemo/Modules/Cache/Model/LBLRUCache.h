//
//  LBLRUCache.h
//  LBDemo
//
//  Created by 李兵 on 2019/11/26.
//  Copyright © 2019 ivan. All rights reserved.
//
//  least recently using
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LBLRUCache : NSObject

- (instancetype)initWithCapacity:(NSInteger)capacity;

- (id)get:(id)key;

- (void)put:(id)value key:(id)key;

- (id)getLast;

@end

NS_ASSUME_NONNULL_END
