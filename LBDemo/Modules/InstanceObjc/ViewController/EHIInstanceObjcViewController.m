//
//  EHIInstanceObjcViewController.m
//  LBDemo
//
//  Created by 李兵 on 2019/12/25.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "EHIInstanceObjcViewController.h"
#import "LBPerson.h"

@interface EHIInstanceObjcViewController ()

@end

@implementation EHIInstanceObjcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"对象探究";
    self.view.backgroundColor = kLBAPPHexColor_FFFFFF;
    
    LBPerson *person = [LBPerson alloc];
    LBPerson *person1 = [person init];
     LBPerson *person2 = [person init];
     LBPerson *person3 = [person init];
    NSLog(@"%@ - %p",person1,&person1);
     NSLog(@"%@ - %p",person2,&person2);
     NSLog(@"%@ - %p",person3,&person3);
    // Do any additional setup after loading the view.
}



@end
