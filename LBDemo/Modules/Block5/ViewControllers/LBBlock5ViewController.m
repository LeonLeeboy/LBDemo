//
//  LBBlock5ViewController.m
//  LBDemo
//
//  Created by 李兵 on 2019/7/25.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBBlock5ViewController.h"

@interface LBBlock5ViewController ()

@property (nonatomic, strong) void (^block)(void);

@end

@implementation LBBlock5ViewController

#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UIView *content1 = [[UIView alloc] init];
    content1.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.4];
    
    UIView *content2 = [[UIView alloc] init];
    content2.backgroundColor = UIColor.clearColor;
    
    [self.view addSubview:content1];
    [content1 addSubview:content2];
    
    [content1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [content2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    content2.layer.mask = [self p_clearShapeLayer];
    
    self.title = @"block 对引用计数的影响";
    
    [self dealData];
}



- (CAShapeLayer *)p_clearShapeLayer {
    
    
    CGRect rect = CGRectMake(100, 200, 100, 100);
    //贝塞尔曲线 画一个带有圆角的矩形
    UIBezierPath *bpath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:0];
    
    [bpath appendPath:[[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:0] bezierPathByReversingPath]];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bpath.CGPath;
    
    return shapeLayer;
}


- (void)dealloc {
    NSLog(@"sdf");
}

/** 处理数据 */
- (void)dealData {
    // what effect of object retainCount that is heap Block
    [self p_dealStrongObjectRetainCountWithStrongBlock];
    [self p_dealStrongObjectRetainCountWithWeakBlock];
    [self p_dealWeakObjectRetainCountWithStrongBlock];
    [self p_dealWeakObjectRetainCountWithWeakBlock];
    [self p_method];
//    [self method];
    self.block();
}

#pragma mark private
/** heap block's effect of object's retain count */
- (void)p_dealStrongObjectRetainCountWithStrongBlock {
    // arr 1
    NSMutableArray *arr = [NSMutableArray array];
    NSLog(@"step1 strong对象的引用计数：%@",@(CFGetRetainCount((__bridge CFTypeRef)arr)));
    //arr , 1 + 1(__strong) + 1(copy,__retain)
    void (^block)(void) = ^ {
        NSLog(@"step3 strong对象的引用计数：%@",@(CFGetRetainCount((__bridge CFTypeRef)arr)));
    };
    NSLog(@"step2 strong对象的引用计数：%@",@(CFGetRetainCount((__bridge CFTypeRef)arr)));
    block();
    NSLog(@"step4 strong对象的引用计数：%@",@(CFGetRetainCount((__bridge CFTypeRef)arr)));
}

- (void)p_dealWeakObjectRetainCountWithStrongBlock {
    //arr 1
    NSMutableArray *arr = [NSMutableArray array];
    //weakarr 1 , arr 1
    __weak typeof(NSMutableArray *) weakArr = arr;
    NSLog(@"step1 weak对象的引用计数：%@",@(CFGetRetainCount((__bridge CFTypeRef)weakArr)));
    NSLog(@"!!!step1 strong对象的引用计数：%@",@(CFGetRetainCount((__bridge CFTypeRef)arr)));
    //
    void (^block)(void) = ^ {
        NSLog(@"step3 weak对象的引用计数：%@",@(CFGetRetainCount((__bridge CFTypeRef)weakArr)));
    };
    NSLog(@"step2 weak对象的引用计数：%@",@(CFGetRetainCount((__bridge CFTypeRef)weakArr)));
    block();
    NSLog(@"step4 weak对象的引用计数：%@",@(CFGetRetainCount((__bridge CFTypeRef)weakArr)));
}

/** stack block's effect of object's retain count */
- (void)p_dealStrongObjectRetainCountWithWeakBlock {
    NSMutableArray *arr = [NSMutableArray array];
    // 1
    NSLog(@"step1 strong对象的引用计数：%@",@(CFGetRetainCount((__bridge CFTypeRef)arr)));
    //2
    void (__weak ^block)(void) = ^ {
        NSLog(@"step3 strong对象的引用计数：%@",@(CFGetRetainCount((__bridge CFTypeRef)arr)));
    };
    NSLog(@"step2 strong对象的引用计数：%@",@(CFGetRetainCount((__bridge CFTypeRef)arr)));
    block();
    NSLog(@"step4 strong对象的引用计数：%@",@(CFGetRetainCount((__bridge CFTypeRef)arr)));
}

- (void)p_dealWeakObjectRetainCountWithWeakBlock {
    // 1
    NSMutableArray *arr = [NSMutableArray array];
    //2
    __weak typeof(NSMutableArray *) weakArr = arr;
    NSLog(@"step1 weak对象stack block的引用计数：%@",@(CFGetRetainCount((__bridge CFTypeRef)weakArr)));
    void (__weak ^block)(void) = ^ {
        NSLog(@"step3 weak对象stack block的引用计数：%@",@(CFGetRetainCount((__bridge CFTypeRef)weakArr)));
    };
    NSLog(@"step2 weak对象stack block的引用计数：%@",@(CFGetRetainCount((__bridge CFTypeRef)weakArr)));
    block();
    NSLog(@"step4 weak对象stack block的引用计数：%@",@(CFGetRetainCount((__bridge CFTypeRef)weakArr)));
    
     NSLog(@"block 类型---%@",block);
    NSLog(@"------ 额外 -----step2 weak对象stack block的引用计数：%@",@(CFGetRetainCount((__bridge CFTypeRef)block)));
}

#pragma mark 循环引用的问题
/** weak 什么时候释放，block 延迟调用 */
- (void)p_method {
    // 模拟处理数据
    __block NSMutableArray *arrM = [[NSMutableArray alloc] init];
    [arrM addObject:self]; // 处理数据中引用了self
    
    // 弱引用数据
    NSLog(@"step1 -- weakArrM的引用计数为：%@", @(CFGetRetainCount((__bridge CFTypeRef)(arrM))));
    NSLog(@"step1 -- arrM的引用计数为：%@", @(CFGetRetainCount((__bridge CFTypeRef)(arrM))));
    self.block = ^{
        [arrM addObject:@"asfd"];
        // 模拟对数据的二次处理
        NSLog(@"step3 -- strongArrM的引用计数为：%@", @(CFGetRetainCount((__bridge CFTypeRef)(arrM))));
        arrM = nil;
    };
     NSLog(@"block 类型---%@",self.block);
    NSLog(@"step2 -- weakArrM的引用计数为：%@", @(CFGetRetainCount((__bridge CFTypeRef)(arrM))));
    NSLog(@"step2 -- arrM的引用计数为：%@", @(CFGetRetainCount((__bridge CFTypeRef)(arrM))));
}

/** 错误打破循环用法 , 其实还是上下文环境，为什么__weak && __strong 不会出现崩溃*/
- (void)method {
    // 模拟处理数据
    // arrM 1
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    [arrM addObject:self]; // 处理数据中引用了self
    
    // 弱引用数据
    // weakArrM 2 , arrm 1
    __weak typeof(NSMutableArray *) weakArrM = arrM;
    NSLog(@"step1 -- weakArrM的引用计数为：%@", @(CFGetRetainCount((__bridge CFTypeRef)(weakArrM))));
    NSLog(@"step1 -- arrM的引用计数为：%@", @(CFGetRetainCount((__bridge CFTypeRef)(arrM))));
    self.block = ^{
        __strong typeof(NSMutableArray *) strongArrM = weakArrM;
        // 模拟对数据的二次处理
        NSLog(@"step3 -- strongArrM的引用计数为：%@", @(CFGetRetainCount((__bridge CFTypeRef)(strongArrM))));
    };
    NSLog(@"step2 -- weakArrM的引用计数为：%@", @(CFGetRetainCount((__bridge CFTypeRef)(weakArrM))));
    NSLog(@"step2 -- arrM的引用计数为：%@", @(CFGetRetainCount((__bridge CFTypeRef)(arrM))));
}


@end
