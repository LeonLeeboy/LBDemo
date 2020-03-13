//
//  EHICalendarClickActionPrivate.m
//  LBDemo
//
//  Created by 李兵 on 2020/3/13.
//  Copyright © 2020 ivan. All rights reserved.
//

#import "EHICalendarClickActionPrivate.h"
#import "EHICalendarDayCellViewModel.h"
#import "EHICalendarDayModel.h"
#import "SEEDCollectionSectionItem.h"
#import "NSDate+EHICalendar.h"
#import "EHICalendarSectinonViewModel.h"

@interface EHICalendarClickActionPrivate ()

@property (nonatomic, strong) NSMutableArray<EHICalendarDayCellViewModel *> *interCellVms;

@end

@implementation EHICalendarClickActionPrivate

- (NSMutableArray<EHICalendarDayCellViewModel *> *)p_dealIntellCellBeginAndEndDates:(NSArray *)dates IntellCells:(NSMutableArray<SEEDCollectionSectionItem *> *)sectionItems {
    EHICalendarDayCellViewModel *begin = dates.firstObject;
    EHICalendarDayCellViewModel *end = dates.lastObject;
    
    NSTimeInterval beginTimeInterval = [begin.model.getDate timeIntervalSince1970];
    NSTimeInterval endTimeInterval = [end.model.getDate timeIntervalSince1970];
    
    if (!begin || !end) {
        return @[].mutableCopy;
    }
    // 当前时间
    NSDate *currentDate = [NSDate date];
    // 获得对应的月份 对应的section
    // a(n) = 1 + 2 * n : a(n) 是对应的index
    NSInteger beginIndex = 1 + 2 * (begin.model.month - currentDate.month);
    NSInteger endIndex = 1 + 2 * (end.model.month - currentDate.month);
    for (NSInteger i = beginIndex; i <= endIndex ; i++) {
        if (sectionItems.count > i) {
            SEEDCollectionSectionItem *sectionItem = sectionItems[i];
            if ([sectionItem isKindOfClass:[EHICalendarSectinonViewModel class]]) {// 如果是headerView 就不处理
                continue;
            }
            for (EHICalendarDayCellViewModel *obj in sectionItem.cellItems) {
                // 在开始和结束日期中间 渲染样式
                if (!obj.model) {
                    continue;
                }
                NSInteger day = obj.model.day;
                if (day == 0) {
                    continue;
                }
                
                NSTimeInterval currentTimeInterval = [obj.model.getDate timeIntervalSince1970];
                if (beginTimeInterval < currentTimeInterval && currentTimeInterval < endTimeInterval) {
                    // 每个月 最后一天，第一天
                    if (day == 1) {
                        [obj generateViewModelWithModel:obj.model type:EHICalendarDayCellTypeIntecellLeft contentInset:obj.sectionInset desText:@""];
                    } else if (day == obj.model.getDate.totalDaysInMonth) {
                        [obj generateViewModelWithModel:obj.model type:EHICalendarDayCellTypeIntecellRight contentInset:obj.sectionInset desText:@""];
                    } else {
                        [obj generateViewModelWithModel:obj.model type:EHICalendarDayCellTypeIntecellNomal contentInset:obj.sectionInset desText:@""];
                    }
                    
                    [self.interCellVms addObject:obj];
                    
                }
                    
            }
        }
    }
    
    return self.interCellVms;
}

- (void)clearInterCellData {
    // 将中间还原
     for (EHICalendarDayCellViewModel *obj in self.interCellVms) {
         if (obj) {
             [obj generateViewModelWithModel:obj.model type:EHICalendarDayCellTypeNormal contentInset:obj.sectionInset desText:@""];
         }
     }
     [self.interCellVms removeAllObjects];
}


#pragma mark - getter
- (NSMutableArray<EHICalendarDayCellViewModel *> *)interCellVms {
    if (!_interCellVms) {
        _interCellVms = [NSMutableArray array];
    }
    return _interCellVms;
}

@end
