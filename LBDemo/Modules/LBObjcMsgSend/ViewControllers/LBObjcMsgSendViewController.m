//
//  LBObjcMsgSendViewController.m
//  LBDemo
//
//  Created by 李兵 on 2019/10/11.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBObjcMsgSendViewController.h"
#import "LBStudent.h"

@interface LBObjcMsgSendViewController ()

@end

@implementation LBObjcMsgSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LBStudent *s1 = [[LBStudent alloc] init];
    [s1 personEat];
}



@end
