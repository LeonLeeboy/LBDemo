//
//  LBPtrViewController.m
//  LBDemo
//
//  Created by 李兵 on 2019/12/17.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBPtrViewController.h"


/** OC 是 c 的超集，参数的传递都是值的传递。指针也不例外 */

void increase(int * x){
    printf("xb:%p,%p--%d\n",&x,x,*x);
    int b = 2;
    x = &b;
    printf("xa:%p,%p--%d\n",&x,x,*x);
}


void testC() {

    int i,b;
    int *j = &b;
    i = 10;
    b = 20;
    printf("ib:%p--%d\n",&i,i);
    printf("jb:%p,%p--%d\n",&j,j,*j);
    increase(&i);
    increase(j);
    printf("ia:%p--%d\n",&i,i);
    printf("ja:%p,%p--%d\n",&j,j,*j);
}

@interface LBPtrViewController ()

@end

@implementation LBPtrViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    NSObject *obj = [[NSObject alloc] init];
    
    NSLog(@"df");
    
    self.title = @"指针探索";
    
    NSString *outerStr = @"outer";
    NSLog(@"outer before:%p,%p----%@",&outerStr,outerStr,outerStr);
    [self changeStr:outerStr];
    NSLog(@"outer after:%p,%p----%@",&outerStr,outerStr,outerStr);
    
    NSLog(@"------------------------------------------------");
    
    
    testC();
}

- (void)changeStr:(NSString *)innerStr{
    NSLog(@"inner before:%p,%p----%@",&innerStr,innerStr,innerStr);
    NSString *str = @"changeInner";
    innerStr = str;
    NSLog(@"inner str after:%p,%p----%@",&str,str,str);
    NSLog(@"inner after:%p,%p----%@",&innerStr,innerStr,innerStr);
}

@end

