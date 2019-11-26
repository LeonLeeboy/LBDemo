//
//  LBDoubleLinkedListViewController.m
//  LBDemo
//
//  Created by 李兵 on 2019/11/26.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBDoubleLinkedListViewController.h"

#import "DoubleLinkedList.h"

@interface LBDoubleLinkedListViewController ()

@end

@implementation LBDoubleLinkedListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kLBAPPHexColor_FFFFFF;
    
    self.title = @"内存置换算法";
    
    [self p_cacheFIFO];
}

- (void)p_cacheFIFO {
    
}

@end
