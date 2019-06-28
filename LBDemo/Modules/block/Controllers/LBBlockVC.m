//
//  LBBlockVC.m
//  LBDemo
//
//  Created by 李兵 on 2019/6/27.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBBlockVC.h"
#import "LBModelLogin.h"

/** 全局变量 */
int global_count = 10;
/** 静态全局变量 */
static int static_global_count = 10;

@interface LBBlockVC ()

@property (copy , nonatomic) NSString *tempStr;

@end

@implementation LBBlockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
    self.tempStr = @"sfd";
}

- (void)configUI {
    self.view.backgroundColor = UIColor.lightGrayColor;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    [btn addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(btn.superview);
    }];
    [self ThreeTypesOfBlock];
    
  
}

#pragma mark Actoin
- (void)btnSelected:(UIButton *)sender {
    
    [self ThreeTypesOfBlock];

//    /** 静态局部变量 */
//    static int static_count = 10;
//    void (^block)(void) = ^ {
//        global_count = 11;
//        static_global_count = 11;
//        static_count = 11;
//    };
//    block();
}

- (void)ThreeTypesOfBlock {
    NSLog(@"%p",self.tempStr);
    __block NSString *str = @"dasf";
    NSLog(@"%p",str);
    NSInteger i2 = 10;
    static int i = 0;
    LBModelLogin *o = LBModelLogin.new;
    //这个即为强引用
    void (^block)(void) = ^{
//         NSLog(@"%@",o);
        NSLog(@"dsf%d",i);
        NSLog(@"dsf%d",i2);
    };
    NSLog(@"%@",^{
//        NSLog(@"%@",o);
         NSLog(@"dsf%d",i);
        NSLog(@"dsf%d",i2);
    });
//    block();
    NSLog(@"block 类型---%@",block);
    
    NSLog(@"%@",LBModelLogin.new);
//        0x0000000101f96d00   -> po 出来的
//        2019-06-27 16:06:25.748362+0800 LBDemo[25444:1206960] 0x105eae890
//        2019-06-27 16:06:25.748476+0800 LBDemo[25444:1206960] 0x105eae8d0
//        2019-06-27 16:06:25.748560+0800 LBDemo[25444:1206960] 0x7ffee9d63ed8
    
    
//    //值传递
//    void (^block)(int count);
//    int count = 10;
//    // block的实现
//    block = ^void (int count) {
//        count++;
//        NSLog(@"count = %d，地址:%p", count, &count);
//    };
//    // block的调用
//    block(count);
//    NSLog(@"count = %d，地址:%p", count, &count);
    
}

@end
