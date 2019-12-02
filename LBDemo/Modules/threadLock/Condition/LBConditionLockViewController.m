//
//  LBConditionLockViewController.m
//  LBDemo
//
//  Created by 李兵 on 2019/12/2.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBConditionLockViewController.h"
#import "LBConditionLock.h"

@interface LBConditionLockViewController ()

@end

@implementation LBConditionLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"条件变量";
    
    LBConditionLock *lock = [[LBConditionLock alloc] init];
    [lock begin];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
