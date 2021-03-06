//
//  EHICalendarDayViewModel.h
//  LBDemo
//
//  Created by 李兵 on 2020/3/9.
//  Copyright © 2020 ivan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EHICalendarClickActionProtol.h"

@class EHICalendarDayViewModel;
@class EHICalendarDayModel;

typedef NS_ENUM(NSInteger,EHICalendarDayCellTimeType) {
    EHICalendarDayCellTimeTypeFirst,             //!> 第一次
    EHICalendarDayCellTimeTypeSecond,             //!> 第二次
    EHICalendarDayCellTimeTypeThird,             //!> 第三次
};


@protocol EHICalendarDayViewModelDataSource <NSObject>

- (BOOL)dayViewModel:(EHICalendarDayViewModel *)viewModel clickableOfCellViewModel:(EHICalendarDayCellViewModel *)cellVm;

- (void)dayViewModel:(EHICalendarDayViewModel *)viewModel afterGeneratedCellViewModel:(EHICalendarDayCellViewModel *)cellVm;

- (void)dayViewModel:(EHICalendarDayViewModel *)viewModel didClickForCell:(EHICalendarDayModel *)vm beginDate:(EHICalendarDayModel *)beginDate endDate:(EHICalendarDayModel *)endModel;

@end

@class SEEDCollectionSectionItem;

@interface EHICalendarDayViewModel : NSObject

- (instancetype)initWithDates:(NSArray <EHICalendarDayModel *>*)dates;

// 需要设置
@property (nonatomic, strong) id<EHICalendarClickActionProtol> clickObj;

@property (nonatomic, weak) id<EHICalendarDayViewModelDataSource> delegate;

@property (nonatomic, strong) void(^refreshUIBlock)(NSArray<SEEDCollectionSectionItem *> *dataSource);

- (void)getData;

@end

