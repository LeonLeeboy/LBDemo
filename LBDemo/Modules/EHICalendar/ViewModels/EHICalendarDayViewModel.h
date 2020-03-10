//
//  EHICalendarDayViewModel.h
//  LBDemo
//
//  Created by 李兵 on 2020/3/9.
//  Copyright © 2020 ivan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EHICalendarDayCellViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface EHICalendarDayViewModel : NSObject


@property (nonatomic, strong) void(^refreshUIBlock)(NSArray<NSArray<EHICalendarDayCellViewModel *> *> *dataSource);

- (void)getData;

@end

NS_ASSUME_NONNULL_END
