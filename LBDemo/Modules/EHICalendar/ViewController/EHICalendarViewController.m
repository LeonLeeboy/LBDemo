//
//  EHICalendarViewController.m
//  LBDemo
//
//  Created by 李兵 on 2020/3/6.
//  Copyright © 2020 ivan. All rights reserved.
//

#import "EHICalendarViewController.h"
#import "EHICalendarView.h"

@interface EHICalendarViewController ()

@end

@implementation EHICalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kEHIHexColor_FFFFFF;
  
    
    EHICalendarView *view = [[EHICalendarView alloc] init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
}


@end
