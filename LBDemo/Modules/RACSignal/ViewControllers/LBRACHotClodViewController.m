//
//  LBRACHotClodViewController.m
//  LBDemo
//
//  Created by 李兵 on 2019/10/16.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBRACHotClodViewController.h"

@interface LBRACHotClodViewController ()

@end

@implementation LBRACHotClodViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //测试冷信号
//    [self p_testColdSignal];
    //测试热信号
    [self p_testHotSignal];
    UITextField *textFieldSignal = [[UITextField alloc] init];
    [textFieldSignal.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        
    }];
}

#pragma mark - private
/** 冷信号测试 */
- (void)p_testColdSignal {
    RACSignal *coldSignal = [self p_createColdSignal];
    
    [[RACScheduler mainThreadScheduler] afterDelay:0.1 schedule:^{
        [coldSignal subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@",x);
        }];
    }];
    
    [[RACScheduler mainThreadScheduler] afterDelay:1 schedule:^{
        [coldSignal subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@",x);
        }];
    }];
}

/** 测试热信号 */
- (void)p_testHotSignal {
    RACSignal *hotSignal = [self p_createHotObservable];
    
    [[RACScheduler mainThreadScheduler] afterDelay:1.1 schedule:^{
        [hotSignal subscribeNext:^(id  _Nullable x) {
            NSLog(@"订阅者1 - %@",x);
        }];
    }];
    
    [[RACScheduler mainThreadScheduler] afterDelay:2.1 schedule:^{
        [hotSignal subscribeNext:^(id  _Nullable x) {
            NSLog(@"订阅者2 - %@",x);
        }];
    }];
    
    [[RACScheduler mainThreadScheduler] afterDelay:3.1 schedule:^{
        [hotSignal subscribeNext:^(id  _Nullable x) {
            NSLog(@"订阅者3 - %@",x);
        }];
    }];
    
}

/** 创建热信号:一秒钟后，开始每隔一秒钟发送一个信号 */
- (RACSignal *)p_createHotObservable {
    RACMulticastConnection *connection = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[RACScheduler mainThreadScheduler] afterDelay:1 schedule:^{
            [subscriber sendNext:@1];
        }];
        
        [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
            [subscriber sendNext:@2];
        }];
        
        [[RACScheduler mainThreadScheduler] afterDelay:3 schedule:^{
            [subscriber sendNext:@3];
        }];
        
        [[RACScheduler mainThreadScheduler] afterDelay:4 schedule:^{
            [subscriber sendNext:@4];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:5 schedule:^{
            [subscriber sendCompleted];
        }];
        return nil;
    }] publish];
    
    [connection connect];
    
    RACSignal *signal = connection.signal;
    return signal;
}

/** 创建冷信号 */
- (RACSignal *)p_createColdSignal {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"1"];
        [subscriber sendNext:@"2"];
        [subscriber sendNext:@"3"];
        return nil;
    }];
}



@end
