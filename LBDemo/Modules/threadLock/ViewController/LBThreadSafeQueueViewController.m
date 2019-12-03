//
//  LBThreadSafeQueueViewController.m
//  LBDemo
//
//  Created by 李兵 on 2019/12/3.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBThreadSafeQueueViewController.h"
#import "ThreadSafeQueue.h"

@interface LBThreadSafeQueueViewController ()

@property (strong) ThreadSafeQueue *queue;

@end

@implementation LBThreadSafeQueueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"线程安全队列";
    
    [self test];
}

- (void)test {
    ThreadSafeQueue *queue = [[ThreadSafeQueue alloc] initWithSize:10];
    self.queue = queue;
    
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(producer) object:nil];
    [thread1 setName:@"生产者1"];
     NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(producer) object:nil];
    [thread2 setName:@"生产者2"];
    NSThread *thread3 = [[NSThread alloc] initWithTarget:self selector:@selector(customer) object:nil];
    [thread1 start];
    [thread2 start];
    [thread3 start];
}

- (void)producer {
//    [[NSRunLoop currentRunLoop] run];
    while (true) {
        
        [self.queue put:[NSThread currentThread].name];
        NSLog(@"生产之后当前的数量----%ld",self.queue.size);
        sleep(3);
    }
}

- (void)customer {
//    [[NSRunLoop currentRunLoop] run];
    while (true) {
        id obj = [self.queue popBlock:YES timeOut:2];
        NSLog(@"消费----%@\n 消费之后之后当前的数量----%ld",obj,self.queue.size);
        NSLog(@"消费之后之后当前的数量asdfas----%ld\n\n",self.queue.size);
        sleep(1);
    }
}





@end
