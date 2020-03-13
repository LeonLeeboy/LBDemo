//
//  EHICalendarDayModel.m
//  LBDemo
//
//  Created by 李兵 on 2020/3/6.
//  Copyright © 2020 ivan. All rights reserved.
//

#import "EHICalendarDayModel.h"



@implementation EHICalendarDayModel

//YYModelSynthCoderAndHash


+ (EHICalendarDayModel *)calendarDayWithYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day {
    
    EHICalendarDayModel *calendarDay = [[EHICalendarDayModel alloc] init];//初始化自身
    calendarDay.year = year;//年
    calendarDay.month = month;//月
    calendarDay.day = day;//日
    return calendarDay;
}

+ (EHICalendarDayModel *)calendarDayWithYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day hour:(NSUInteger)hour minutes:(NSUInteger)minutes {
    EHICalendarDayModel *calendarDay = [[EHICalendarDayModel alloc] init];//初始化自身
    calendarDay.year = year;//年
    calendarDay.month = month;//月
    calendarDay.day = day;//日
    calendarDay.Hour = hour;
    calendarDay.miniutes = minutes;
    return calendarDay;
}

- (NSDate *)getDate {
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.year = self.year;
    c.month = self.month;
    c.day = self.day;
    return [[NSCalendar currentCalendar] dateFromComponents:c];
}

- (NSDate *)getFullDate {
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.year = self.year;
    c.month = self.month;
    c.day = self.day;
    c.hour = self.Hour;
    c.minute = self.miniutes;
    return [[NSCalendar currentCalendar] dateFromComponents:c];
}

- (NSInteger)getWeek {
   return [self getDate].weekday;
}

@end
