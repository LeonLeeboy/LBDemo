//
//  EHICalendarViewController.h
//  LBDemo
//
//  Created by 李兵 on 2020/3/6.
//  Copyright © 2020 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EHICalendarDayModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EHICalendarViewController : UIViewController

- (instancetype)initWithStartDate:(EHICalendarDayModel *)starModel endDate:(EHICalendarDayModel *)endModel;


@end

NS_ASSUME_NONNULL_END
