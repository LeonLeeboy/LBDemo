//
//  LBAutoReleasePoolViewController.m
//  LBDemo
//
//  Created by 李兵 on 2019/11/13.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBAutoReleasePoolViewController.h"

/** models */
#import "LBAutoReleasePerson.h"

@interface LBAutoReleasePoolViewController ()

@end

@implementation LBAutoReleasePoolViewController

#pragma mark - life cycle

__weak id reference = nil;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kEHIHexColor_FFFFFF;
    self.title = @"AutoReleasePool 探究";
    
    NSString *str = [NSString stringWithFormat:@"autoreleasePool"];
    // str是一个autorelease对象，设置一个weak的引用来观察它
    reference = str;
    
//    [self p_test];
//    
//    [self p_test2];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     NSLog(@"%@", reference); // Console: autoreleasePool
}

- (void)viewDidAppear:(BOOL)animated {
     NSLog(@"%@", reference); // Console: autoreleasePool
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self p_test3];
}

#pragma mark - private
/** @autoreleasepool 就释放 */
- (void)p_test {
    __weak id tmp = nil;
    @autoreleasepool {
        LBAutoReleasePerson *obj = [LBAutoReleasePerson object];
        tmp = obj;
    }
    NSLog(@"tmp==========%@",tmp);
    
}

/** 不会释放 */
- (void)p_test2 {
    __weak id tmp = nil;
    {
        LBAutoReleasePerson *obj = [LBAutoReleasePerson object];
        tmp = obj;
    }
    NSLog(@"tmp==========%@",tmp);
    
}

/** autoreleasepool 实际应用 */
- (void)p_test3 {
    
    uint64_t dispatch_benchmark(size_t count, void (^block)(void));
    uint64_t time = dispatch_benchmark(10, ^{
//        @autoreleasepool {
//            NSString *str = @"forkpanda";
//            NSMutableArray *array = @[].mutableCopy;
//            for (int i = 0; i < 10000; i++)
//            {
//                [array addObject:str];
//            }
//        }
        for (int i = 0; i < 10000000; i++) {
            @autoreleasepool {
                [NSString stringWithFormat:@"str - %lu", (unsigned long)i];
            }
        }
    });
    NSLog(@"[D] <%@|%@:%d> The average runtime for operation is %llu ns.",
          NSStringFromClass([self class]), NSStringFromSelector(_cmd), __LINE__, time);
   
}

@end
