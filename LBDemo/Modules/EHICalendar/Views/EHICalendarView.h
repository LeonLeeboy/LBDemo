//
//  EHICalendarView.h
//  LBDemo
//
//  Created by 李兵 on 2020/3/9.
//  Copyright © 2020 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHICalendarDayCellViewModel.h"

@class EHICalendarView;

@protocol EHICalendarViewProtocol <NSObject>

- (BOOL)calendarView:(EHICalendarView *)view clickableOfCellViewModel:(EHICalendarDayCellViewModel *)cellVm;

- (void)calendarView:(EHICalendarView *)view afterGeneratedCellViewModel:(EHICalendarDayCellViewModel *)cellVm;

@end


@interface EHICalendarView : UIView

@property (nonatomic, weak) id<EHICalendarViewProtocol> delegate;

- (instancetype)initWithStartDate:(EHICalendarDayModel *)starModel endDate:(EHICalendarDayModel *)endModel;


@end

