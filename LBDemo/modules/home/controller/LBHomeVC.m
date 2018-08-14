//
//  LBHomeVC.m
//  LBDemo
//
//  Created by ivan on 2018/8/6.d//  Copyright © 2018年 ivan. All rights reserved.
//

#import "LBHomeVC.h"

@interface LBHomeVC ()<NSCopying>

@end

@implementation LBHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    UIView *view = UIView.new;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0  ));
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
