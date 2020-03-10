//
//  EHICalendarDayViewModel.h
//  LBDemo
//
//  Created by 李兵 on 2020/3/9.
//  Copyright © 2020 ivan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EHICalendarSectinonViewModel;

@interface EHICalendarDayViewModel : NSObject


@property (nonatomic, strong) void(^refreshUIBlock)(NSArray<EHICalendarSectinonViewModel *> *dataSource);

- (void)getData;

@end

