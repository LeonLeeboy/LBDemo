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

@property (nonatomic, strong) NSMutableArray *dates;


@end

@implementation EHICalendarViewController

- (instancetype)initWithStartDate:(EHICalendarDayModel *)starModel endDate:(EHICalendarDayModel *)endModel {
    EHICalendarViewController *vc = [[EHICalendarViewController alloc] init];
   
    if ([EHICalendarViewController modelisValid:starModel]) {
        [vc.dates addObject:starModel];
    }
    
    if ([EHICalendarViewController modelisValid:endModel]) {
        [vc.dates addObject:endModel];
    }
    return vc;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kEHIHexColor_FFFFFF;
  
    EHICalendarView *view = [[EHICalendarView alloc] initWithStartDate:self.dates.firstObject endDate:self.dates.lastObject];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    NSLog(@"dsf");
}


#pragma mark - getter
- (NSMutableArray<EHICalendarDayModel *> *)dates {
    if (!_dates) {
        NSMutableArray *arr = [NSMutableArray array];
        _dates = arr;
    }
    
    return _dates;
}

#pragma mark - static
+ (BOOL)modelisValid:(EHICalendarDayModel *)model {
    BOOL rst = NO;
    
    if (model && model.day != 0 && model.month != 0 && model.year != 0) {
        rst = YES;
    }
    
    return rst;
}


@end
