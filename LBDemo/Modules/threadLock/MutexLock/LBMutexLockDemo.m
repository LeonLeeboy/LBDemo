//
//  LBMutexLockDemo.m
//  LBDemo
//
//  Created by 李兵 on 2019/12/3.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBMutexLockDemo.h"

@interface LBMutexLockDemo ()

@property (nonatomic, strong) NSLock *mutex;

@property (nonatomic, strong) NSCondition *condition;

@end

@implementation LBMutexLockDemo

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (NSLock *)mutex {
    if (!_mutex) {
        NSLock *mutex = [[NSLock alloc] init];
        _mutex = mutex;
    }
    return _mutex;
}

- (NSCondition *)condition {
    if (!_condition) {
        NSCondition *cond = [[NSCondition alloc] init];
        _condition = cond;
    }
    return _condition;
}

@end
