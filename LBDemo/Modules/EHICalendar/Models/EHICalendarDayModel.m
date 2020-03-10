//
//  EHICalendarDayModel.m
//  LBDemo
//
//  Created by 李兵 on 2020/3/6.
//  Copyright © 2020 ivan. All rights reserved.
//

#import "EHICalendarDayModel.h"



@implementation EHICalendarDayModel


+ (EHICalendarDayModel *)calendarDayWithYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day {
    
    EHICalendarDayModel *calendarDay = [[EHICalendarDayModel alloc] init];//初始化自身
    calendarDay.year = year;//年
    calendarDay.month = month;//月
    calendarDay.day = day;//日
    return calendarDay;
}

- (NSDate *)getDate {
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.year = self.year;
    c.month = self.month;
    c.day = self.day;
    return [[NSCalendar currentCalendar] dateFromComponents:c];
}

- (NSInteger)getWeek {
   return [self getDate].weekday;
}

@end
