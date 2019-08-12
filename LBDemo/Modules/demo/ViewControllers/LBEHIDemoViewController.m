//
//  LBEHIDemoViewController.m
//  LBDemo
//
//  Created by 李兵 on 2019/8/9.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBEHIDemoViewController.h"
#import "EHIHiCarOperationTopView.h"

@interface LBEHIDemoViewController ()

@end

@implementation LBEHIDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    // Do any additional setup after loading the view.
    EHIHiCarOperationTopView *topView = [[EHIHiCarOperationTopView alloc] init];
    topView.didClickPhone = ^{
        NSLog(@"didClickPhone");
    };
    topView.didClickCarDetail = ^{
        NSLog(@"didClickCarDetail");
    };
    
    [self.view addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.right.mas_equalTo(0);
        make.height.mas_greaterThanOrEqualTo(autoHeightOf6(171));
    }];

    topView.layer.shadowOffset = CGSizeMake(0, 10);
    topView.layer.shadowColor = [UIColor blackColor].CGColor;
    topView.layer.shadowOpacity = 1.0;

    //设置阴影的半径
    topView.layer.shadowRadius = 5;
//
}



@end
