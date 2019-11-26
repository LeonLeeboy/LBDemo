//
//  LBRunLoopViewModel.m
//  LBDemo
//
//  Created by 李兵 on 2019/11/12.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBRunLoopViewModel.h"

@interface LBRunLoopViewModel ()

@property (nonatomic, strong) NSThread *timerThread;

@property (nonatomic, strong) NSTimer *requestTimer;

@end

@implementation LBRunLoopViewModel

#pragma mark - life cycle

- (void)dealloc {
    NSLog(@"dealloc -----------");
}

#pragma mark - public
- (void)getData {
    if (self.timerThread.isFinished) {
        return;
    }
    [self.timerThread start];
}

- (void)destroyTimer {
    [self performSelector:@selector(p_destroyTimer) onThread:self.timerThread withObject:nil waitUntilDone:NO];
}

- (void)stopTimer {
    [self performSelector:@selector(p_stopTimer) onThread:self.timerThread withObject:nil waitUntilDone:NO];
}

- (void)fireTimer {
    [self performSelector:@selector(p_fireTimer) onThread:self.timerThread withObject:nil waitUntilDone:NO];
}

- (void)p_request {
    NSLog(@"-----------------%@",[NSThread currentThread]);
    NSLog(@"request data");
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"-----------------%@ 结束",[NSThread currentThread]);
    });
}

#pragma - Action

#pragma mark - private
- (void)p_createTimer {
    @autoreleasepool {
        self.requestTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(p_request) userInfo:nil repeats:YES];
        [self.requestTimer fire];
        do {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        } while (_requestTimer);
    }
}

- (void)p_fireTimer {
    if (!self.requestTimer) {
        return;
    }
    [self.requestTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:3]];
}

- (void)p_stopTimer {
    if (!self.requestTimer) {
        return;
    }
    [self.requestTimer setFireDate:[NSDate distantFuture]];
}

- (void)p_destroyTimer {
    if (!self.requestTimer) {
        return;
    }
    [self.requestTimer invalidate];
    self.requestTimer = nil;
}

#pragma mark - Getter && Setter
- (NSThread *)timerThread {
    if (!_timerThread) {
        NSThread *timerThread = [[NSThread alloc] initWithTarget:self selector:@selector(p_createTimer) object:nil];
        [timerThread setName:@"首页我的行程计时子线程"];
        _timerThread = timerThread;
    }
    return _timerThread;
}

@end
