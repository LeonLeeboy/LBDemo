//
//  EHICalendarViewController.m
//  LBDemo
//
//  Created by 李兵 on 2020/3/6.
//  Copyright © 2020 ivan. All rights reserved.
//

#import "EHICalendarViewController.h"
#import "EHICalendarView.h"
#import "EHICalendarTopView.h"
#import "EHIStoreOpenCloseModel.h"
#import "EHICalendarSelectTimeView.h"

@interface EHICalendarViewController ()<EHICalendarViewProtocol>

@property (nonatomic, strong) NSMutableArray *dates;

@property (nonatomic, strong) EHICalendarTopView *topView;

@property (nonatomic, strong) EHICalendarView *calendarView;

@property (nonatomic, strong) EHICalendarDayModel *startDate;

@property (nonatomic, strong) EHICalendarDayModel *endDate;

@property (nonatomic, strong) EHIStoreOpenCloseModel *openCloseModel;

@property (nonatomic, strong) EHICalendarSelectTimeView *pickTimeView;

@end

@implementation EHICalendarViewController

- (instancetype)initWithStartDate:(EHICalendarDayModel *)starModel endDate:(EHICalendarDayModel *)endModel {
    EHICalendarViewController *vc = [[EHICalendarViewController alloc] init];
   
    
    if ([EHICalendarViewController modelisValid:starModel]) {
        vc.startDate = starModel;
        if ([EHICalendarViewController modelisValid:endModel]) {
            vc.endDate = endModel;
        }
    }
    
    return vc;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kEHIHexColor_FFFFFF;
    
    [self setUpUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)setUpUI {
    [self.view addSubview:self.topView];
    [self.view addSubview:self.calendarView];
    [self.view addSubview:self.pickTimeView];
    [self layoutViews];
}

- (void)layoutViews {
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(84);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(78);
    }];
    
    [_calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.topView);
        make.top.equalTo(self.topView.mas_bottom);
        make.height.mas_equalTo(300);
    }];
    
    [_pickTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.equalTo(self.calendarView.mas_bottom);
    }];
}


#pragma mark - delegate

- (void)calendarView:(EHICalendarView *)view didClickForCell:(EHICalendarDayModel *)vm beginDate:(EHICalendarDayModel *)beginDate endDate:(EHICalendarDayModel *)endModel {
    self.startDate = beginDate;
    self.endDate = endModel;
    self.topView.leftModel = self.startDate;
    self.topView.rightModel = self.endDate;
}



#pragma mark - getter
- (NSMutableArray<EHICalendarDayModel *> *)dates {
    if (!_dates) {
        NSMutableArray *arr = [NSMutableArray array];
        _dates = arr;
    }
    
    return _dates;
}


- (EHICalendarTopView *)topView {
    if (!_topView) {
        EHICalendarTopView *topView = [[EHICalendarTopView alloc] init];
        topView.leftModel = self.startDate;
        topView.rightModel = self.endDate;
        _topView = topView;
    }
    return _topView;
}

- (EHICalendarView *)calendarView {
    if (!_calendarView) {
        EHICalendarView *calendarView = [[EHICalendarView alloc] initWithStartDate:self.startDate endDate:self.endDate];
        calendarView.delegate = self;
        _calendarView = calendarView;
    }
    return _calendarView;
}

- (EHIStoreOpenCloseModel *)openCloseModel {
    if (!_openCloseModel) {
        _openCloseModel = [[EHIStoreOpenCloseModel alloc] initWithPickCarOpenTimeStr:@"09:00" pickCarCloseTimeStr:@"18:00" returnCarOpenTime:@"09:00" returnCarCloseTimeStr:@"21:00"];
    }
    return _openCloseModel;
}


- (EHICalendarSelectTimeView *)pickTimeView {
    if (!_pickTimeView) {
        _pickTimeView = [[EHICalendarSelectTimeView alloc] init];
    }
    return _pickTimeView;
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
