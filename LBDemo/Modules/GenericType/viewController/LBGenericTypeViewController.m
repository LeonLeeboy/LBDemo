//
//  LBGenericTypeViewController.m
//  LBDemo
//
//  Created by 李兵 on 2019/7/17.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBGenericTypeViewController.h"
#import "Language.h"
#import "People.h"

@interface LBGenericTypeViewController ()

@end

@implementation LBGenericTypeViewController

#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"__kindof , convariant";
    self.view.backgroundColor = [UIColor whiteColor];
    
    OC *oc = [[OC alloc] init];
    swift *s = [[swift alloc] init];
    swift5 *s5 = [[swift5 alloc] init];
    Language *lan = [[Language alloc] init];
    
    
    People<Language *> *p1 = [[People alloc] init];
    p1.language = lan;
    
    People<swift *> *p2 = [[People alloc] init];
    p2.language = s5;
    
    People<OC *> *p3 = [[People alloc] init];
    p3.language = oc;
    
}

- (void)swapTwovalue:(id)value1 value2:(id)value2 {
    
}



@end
