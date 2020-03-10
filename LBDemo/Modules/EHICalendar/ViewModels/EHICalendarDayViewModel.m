//
//  EHICalendarDayViewModel.m
//  LBDemo
//
//  Created by 李兵 on 2020/3/9.
//  Copyright © 2020 ivan. All rights reserved.
//

#import "EHICalendarDayViewModel.h"
#import "EHICalendarDayCellViewModel.h"
#import "EHICalendarDayModel.h"
#import "NSDate+EHICalendar.h"
#import "EHICalendarSectinonViewModel.h"

#import "SEEDCollectionSectionItem.h"

#define MonthCount 5 //5个月
#define perweekDays 7

@interface EHICalendarDayViewModel ()

@property (nonatomic, strong) NSArray<NSArray<EHICalendarDayModel *> *> *originDataSource;

@property (nonatomic, strong) NSArray<EHICalendarSectinonViewModel *> *datasource;

@end

@implementation EHICalendarDayViewModel

- (void)getData {
    self.originDataSource = [self p_getCalendarMonth];
    
    self.datasource = [self p_dealOriginData];
    
    if (self.datasource.count > 0 && self.refreshUIBlock) {
        self.refreshUIBlock(self.datasource);
    }
    
}

- (NSMutableArray<NSArray<EHICalendarDayModel *> *> *)p_getCalendarMonth {
    NSMutableArray *rst = [NSMutableArray array];
    
    NSDate *date = [NSDate getCurrentLocalDate];
    for (int i = 0; i < MonthCount; i++) {
        NSMutableArray<EHICalendarDayModel *> *days = [NSMutableArray array];
        
        //N月后的日期
        NSDate *Date = [date dayInTheFollowingMonth:i];
        //对象对应的月份的总天数
        NSInteger totalDaysInMonth = Date.totalDaysInMonth;
        
        //当月第一天
        NSDate *firstDate = [Date getCurrentMonthFirstDate];
        // 返回 周日 1，周一 2
        NSInteger weekDay = firstDate.weekday;
      
        
        int columnCount = 7;
        //每个月有多少天
        NSInteger itemCount = (totalDaysInMonth + (weekDay - 1) + (columnCount - 1) ) / columnCount * columnCount;
        
        NSInteger lineCount = itemCount / columnCount;
        
        NSInteger day = 1;
        for (int j = 0 ; j < itemCount; j++) {
            EHICalendarDayModel *model = [[EHICalendarDayModel alloc] init];;
            NSInteger currentLineIdx = j / columnCount;
            
            
            if (currentLineIdx == 0 && j >= weekDay - 1) {
                model = [EHICalendarDayModel calendarDayWithYear:Date.year month:Date.month day:day++];
            }
            
            if (currentLineIdx > 0 && currentLineIdx < lineCount - 1 ) {
                model = [EHICalendarDayModel calendarDayWithYear:Date.year month:Date.month day:day++];
            }
            
            if (currentLineIdx == lineCount-1 && day <= totalDaysInMonth) {
                model = [EHICalendarDayModel calendarDayWithYear:Date.year month:Date.month day:day++];
            }
            
            
            [days addObject:model];
        }
        
        [rst addObject:days];
    }
    
    return rst;
}

- (NSMutableArray *)p_dealOriginData {
    NSMutableArray *rst = [NSMutableArray array];
   
    for (NSArray<EHICalendarDayModel *> *arr in self.originDataSource) {
        
        EHICalendarSectinonViewModel *sectionVm = [[EHICalendarSectinonViewModel alloc] init];
        sectionVm.columnCount = perweekDays;
        [sectionVm updateWithModel:arr];
        [rst addObject:sectionVm];
    }
    
    return rst;
}


@end


