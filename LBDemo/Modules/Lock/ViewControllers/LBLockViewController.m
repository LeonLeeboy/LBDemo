//
//  LBLockViewController.m
//  LBDemo
//
//  Created by 李兵 on 2019/8/8.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBLockViewController.h"

@interface LBLockViewController ()

@property (nonatomic, copy) NSString *name;

@end

@implementation LBLockViewController

#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"锁";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configSubView];
}

- (instancetype)init {
    if (self = [super init]) {
        self.name = @"初始化";
    }
    return self;
}

- (void)configSubView {
    [self configPthred_mutexLock];
    [self configNSLock];
}

#pragma mark configuration

- (void)configPthred_mutexLock {
    
//#define PTHREAD_MUTEX_NORMAL        0      //
//#define PTHREAD_MUTEX_ERRORCHECK    1      // 有错误提示的锁
//#define PTHREAD_MUTEX_RECURSIVE        2。 //递归锁
//#define PTHREAD_MUTEX_DEFAULT        PTHREAD_MUTEX_NORMAL
    
    //一般情况下，一个线程只能申请一次锁，也只能在获得锁的情况下才能释放锁，多次申请锁或释放未获得的锁都会导致崩溃。假设在已经获得锁的情况下再次申请锁，线程会因为等待锁的释放而进入睡眠状态，因此就不可能再释放锁，从而导致死锁。
    
//    然而这种情况经常会发生，比如某个函数申请了锁，在临界区内又递归调用了自己。辛运的是 pthread_mutex 支持递归锁，也就是允许一个线程递归的申请锁，只要把 attr 的类型改成 PTHREAD_MUTEX_RECURSIVE 即可。
    // 属性
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_NORMAL);  // 定义锁的属性

    // 锁创建
    pthread_mutex_t mutex;
    pthread_mutex_init(&mutex, &attr);
    
    pthread_mutex_lock(&mutex); // 申请锁
    // 临界区
    pthread_mutex_unlock(&mutex); // 释放锁
}

- (void)configNSLock {
    
    //初始化值
    NSLog(@"%@",self.name);
    
    for (int i = 1; i < 10; i++) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSLog(@"%@ ---- 读取",self.name);
//        });
        
        NSLock *lock = [[NSLock alloc] init];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [lock lock];
            sleep(i);
            self.name = [NSString stringWithFormat:@"锁住呀 1 - %d",i];
            NSLog(@"%@",self.name);
            [lock unlock];
            NSLog(@"线程1解锁成功");
        });
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            sleep(1);
            
            if ([lock tryLock]) {
                self.name = [NSString stringWithFormat:@"锁住呀 2 - %d",i];
                NSLog(@"%@",self.name);
                [lock unlock];
                NSLog(@"线程2解锁成功");
            } else {
                NSLog(@"尝试加锁失败");
            }
            
            
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            sleep(i-1);
            NSLog(@"%@ ---- 读取",self.name);
        });
    }
    
   
    
    //FIXME: 待验证
    /**
     #define    MLOCK \
     - (void) lock\
     {\
     int err = pthread_mutex_lock(&_mutex);\
     // 错误处理 ……
     }
     */
}


@end
