//
//  queue.m
//  LBDemo
//
//  Created by 李兵 on 2019/12/3.
//  Copyright © 2019 ivan. All rights reserved.
//
//
//

#import "ThreadSafeQueue.h"


@interface ThreadSafeQueueException : NSException

@end

@implementation ThreadSafeQueueException

@end


@interface ThreadSafeQueue ()

@property ( strong) NSMutableArray *queue;

@property ( assign) NSInteger maxSize;

@property ( strong) NSLock *lock;

@property ( strong) NSCondition *condition;
@end

@implementation ThreadSafeQueue

#pragma mark - life Cycle
/** 构造函数 */
- (instancetype)initWithSize:(NSInteger)maxSize {
    if (self = [self init]) {
        self.queue = @[].mutableCopy;
        self.maxSize = maxSize;
        self.lock = [[NSLock alloc] init];
        self.condition = [[NSCondition alloc] init];
    }
    return self;
}

- (NSInteger)size {
    [self.lock lock];
    NSInteger size = self.queue.count;
    [self.lock unlock];
    return size;
}

- (id)put:(id)item {
    if (self.maxSize != 0 && [self size] > self.maxSize) {
        return [[ThreadSafeQueueException alloc] initWithName:@"threadSafeException" reason:@"已经满了" userInfo:nil];
    }
    [self.lock lock];
    [self.queue addObject:item];
    [self.lock unlock];
    
    [self.condition lock];
    [self.condition signal];
    [self.condition unlock];
    
    return item;
}

- (void)batchPut:(id)itemList {
    if (![itemList isKindOfClass:NSArray.class]) {
        itemList = @[itemList];
    }
    for (id obj in itemList) {
        [self put:obj];
    }
    
}

- (id)popBlock:(BOOL)block timeOut:(NSTimeInterval)timeOut {
    if (self.size == 0) {
        if (block) {
            [self.condition lock];
            NSDate *date = [NSDate dateWithTimeIntervalSinceNow:timeOut];
            [self.condition waitUntilDate:date];
            [self.condition unlock];
        } else {
            return nil;
        }
    }
    if (self.size == 0) {
        return nil;
    }
    
    [self.lock lock];
    id rest = self.queue.firstObject;
    [self.queue removeFirstObject];
    [self.lock unlock];
    return rest;
}

- (id)get:(NSInteger)index {
    if (index > self.size - 1) {
        return nil;
    }
    
    [self.lock lock];
    id rst = self.queue[index];
    [self.lock unlock];
    return rst;
}


@end

