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


@interface EHICalendarView ()

@property (nonatomic, strong) SEEDCollectionView *collecitonView;

@property (nonatomic, strong) EHICalendarDayViewModel *viewModel;

@property (nonatomic, strong) NSArray<EHICalendarSectinonViewModel *> *dataSource;

@end

@implementation EHICalendarView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
        
        EHiWeakSelf(self)
        self.viewModel.refreshUIBlock = ^(NSArray<EHICalendarSectinonViewModel *> * _Nonnull dataSource) {
            EHiStrongSelf(self)
            self.dataSource = dataSource;
            self.collecitonView.items = dataSource.mutableCopy;
            [self.collecitonView reloadData];
        };
        [self.viewModel getData];
    }
    return self;
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
    }
    return _viewModel;
}

@end
