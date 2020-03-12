//
//  EHICalendarView.m
//  LBDemo
//
//  Created by 李兵 on 2020/3/9.
//  Copyright © 2020 ivan. All rights reserved.
//

#import "EHICalendarView.h"

#import "EHICalendarDayViewModel.h"
#import "EHICalendarDayCellViewModel.h"
#import "EHICalendarCollecitionCell.h"
#import "SEEDCollectionView.h"
#import "EHICalendarSectinonViewModel.h"


@interface EHICalendarView ()<EHICalendarDayViewModelDataSource>

@property (nonatomic, strong) SEEDCollectionView *collecitonView;

@property (nonatomic, strong) EHICalendarDayViewModel *viewModel;

@property (nonatomic, strong) NSArray<EHICalendarSectinonViewModel *> *dataSource;


@end

@implementation EHICalendarView

#pragma mark - life cycle

- (instancetype)initWithStartDate:(EHICalendarDayModel *)starModel endDate:(EHICalendarDayModel *)endModel {
    if (self = [super initWithFrame:CGRectZero]) {
       
        
        NSMutableArray *rst = [NSMutableArray array];
        if (starModel) {
            [rst addObject:starModel];
        }
        if (endModel) {
            [rst addObject:endModel];
        }
        self.viewModel = [[EHICalendarDayViewModel alloc] initWithDates:rst.copy];
        self.viewModel.delegate = self;
        
        [self p_dealUI:self];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSLog(@"initWithFrame");
        [self p_dealUI:self];
    }
    return self;
}

- (instancetype)p_dealUI:(EHICalendarView *)context {
    [context setupSubViews];
    
    EHiWeakSelf(self)
    context.viewModel.refreshUIBlock = ^(NSArray<EHICalendarSectinonViewModel *> * _Nonnull dataSource) {
        EHiStrongSelf(self)
        self.dataSource = dataSource;
        self.collecitonView.items = dataSource.mutableCopy;
        [self.collecitonView reloadData];
    };
    [context.viewModel getData];
    return context;
}




- (void)setupSubViews {
    [self addSubview:self.collecitonView];
    [self layoutViews];
}

- (void)layoutViews {
    [_collecitonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

#pragma mark - delegate
- (BOOL)dayViewModel:(EHICalendarDayViewModel *)viewModel clickableOfCellViewModel:(EHICalendarDayCellViewModel *)cellVm {
    if ([self.delegate respondsToSelector:@selector(calendarView:clickableOfCellViewModel:)]) {
        return [self.delegate calendarView:self clickableOfCellViewModel:cellVm];
    }
    
    return YES;
}

- (void)dayViewModel:(EHICalendarDayViewModel *)viewModel afterGeneratedCellViewModel:(EHICalendarDayCellViewModel *)cellVm {
    if ([self.delegate respondsToSelector:@selector(calendarView:afterGeneratedCellViewModel:)]) {
        [self.delegate respondsToSelector:@selector(calendarView:afterGeneratedCellViewModel:)];
    }
}

#pragma mark - Getter
- (SEEDCollectionView *)collecitonView {
    if (!_collecitonView) {
        _collecitonView = [[SEEDCollectionView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, autoHeightOf6(150))];

        _collecitonView.backgroundColor = [UIColor whiteColor];
    }
    return _collecitonView;
}

- (EHICalendarDayViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel  = [[EHICalendarDayViewModel alloc] init];
        _viewModel.delegate = self;
    }
    return _viewModel;
}

@end
