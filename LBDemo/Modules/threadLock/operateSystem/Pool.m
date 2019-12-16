//
//  Pool.m
//  LBDemo
//
//  Created by 李兵 on 2019/12/6.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "Pool.h"

@implementation Pool


@end

@interface ProcessThread : NSThread

@property (nonatomic, copy) void(^actionBlock)(void);

- (instancetype)initWithTaskQueue:(id)taskQueue block:(void(^)(void))actionBlock;
@end

@implementation ProcessThread

- (instancetype)initWithTaskQueue:(id)taskQueue block:(void(^)(void))actionBlock {
   
    if (self = [super init]) {
        self.actionBlock = actionBlock;
    }
    return self;
}

- (void)run {
    
}

- (void)stop {
    
}

@end
