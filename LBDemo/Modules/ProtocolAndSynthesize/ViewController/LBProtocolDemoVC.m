//
//  LBProtocolDemoVC.m
//  LBDemo
//
//  Created by 李兵 on 2019/7/18.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBProtocolDemoVC.h"
#import "SEEDSelectModel.h"

@interface LBProtocolDemoVC ()

@end

@implementation LBProtocolDemoVC

#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    SEEDSelectModel *m = [[SEEDSelectModel alloc] init];
    m.aaa = @"11111";
    
    NSLog(@"%@",m.aaa);
    
}


@end
