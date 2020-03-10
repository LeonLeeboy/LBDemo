//
//  EHICalendarDayModel.h
//  LBDemo
//
//  Created by 李兵 on 2020/3/6.
//  Copyright © 2020 ivan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, EHICalendarDayType) {
    EHICalendarDayTypeEmpty = 0,    //不显示
    EHICalendarDayTypeAllDayCan,    //全天可租
    EHICalendarDayTypeAllDayNo      //全天不可阻
};

@interface EHICalendarDayModel : NSObject

@property (nonatomic, assign) NSUInteger year;//年
@property (nonatomic, assign) NSUInteger month;//月
@property (nonatomic, assign) NSUInteger day;//天


//选择的时间 如 06:45
@property (nonatomic, copy) NSString *timeStr;


+ (EHICalendarDayModel *)calendarDayWithYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day;

- (NSDate *)getDate;

- (NSInteger)getWeek;


@end

NS_ASSUME_NONNULL_END