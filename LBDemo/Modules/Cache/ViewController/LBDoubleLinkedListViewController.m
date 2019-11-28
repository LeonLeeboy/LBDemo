//
//  LBDoubleLinkedListViewController.m
//  LBDemo
//
//  Created by 李兵 on 2019/11/26.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBDoubleLinkedListViewController.h"

#import "DoubleLinkedList.h"

#import "LBLFUCache.h"

@interface LBDoubleLinkedListViewController ()

@end

@implementation LBDoubleLinkedListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kLBAPPHexColor_FFFFFF;
    
    self.title = @"内存置换算法";
    
//    LBLFUCache *LFUCache = [[LBLFUCache alloc] initWithCapacity:10];
    
//    [self p_cacheFIFO];
    
    [self p_cacheLFU];
}

- (void)p_cacheFIFO {
    
}

- (void)p_cacheLFU {
    LBLFUCache *LFUCache = [[LBLFUCache alloc] initWithCapacity:4];
    [LFUCache put:@"1" key:@"1"];
    [LFUCache print];
    [LFUCache put:@"2" key:@"2"];
    [LFUCache print];
    [LFUCache get:@"1"];
    [LFUCache print];
    [LFUCache put:@"3" key:@"3"];
    [LFUCache print];
    [LFUCache get:@"3"];
    [LFUCache print];
    [LFUCache put:@"4" key:@"4"];
    [LFUCache print];
    [LFUCache get:@"1"];
    [LFUCache print];
    [LFUCache put:@"5" key:@"5"];
    [LFUCache print];
}

@end
