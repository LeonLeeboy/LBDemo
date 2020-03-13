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

#define MonthCount 10 //5个月
#define perweekDays 7

@interface EHICalendarDayViewModel ()

@property (nonatomic, strong) NSArray<NSArray<EHICalendarDayModel *> *> *originDataSource;

/** 选择的开始和结束时间CellVM */
@property (nonatomic, strong) NSMutableArray<EHICalendarDayCellViewModel *> *dates;

/** 初始化传值暂存 */
@property (nonatomic, strong) NSMutableArray<EHICalendarDayCellViewModel *> *shows;

/** 选择的中间的cellVMs */
@property (nonatomic, strong) NSMutableArray<EHICalendarDayCellViewModel *> *interCellVms;

@property (nonatomic, strong) NSArray<SEEDCollectionSectionItem *> *datasource;

@end

@implementation EHICalendarDayViewModel

- (instancetype)initWithDates:(NSArray<EHICalendarDayModel *> *)dates {
    if (self = [super init]) {
        SEEDCollectionSectionItem *item = [self p_dealCells:dates];
        self.shows = [NSMutableArray array];
        for (id<SEEDCollectionCellItemProtocol> obj in item.cellItems) {
            if (obj) {
                [self.shows addObject:obj];
            }
        }
    }
    return self;
}


- (void)getData {
    self.originDataSource = [self p_getCalendarMonth];
    
    self.datasource = [self p_dealOriginData];
    
    for (EHICalendarDayCellViewModel *obj in self.shows) {
        NSDate *currentDate = [NSDate date];
        NSInteger sectionIndex = 1 + 2 * (obj.model.month - currentDate.month);
        NSInteger rowIndex = (obj.model.getDate.firstWeekDayInMonth - 1) + obj.model.day;
        
        if (self.datasource.count > sectionIndex) {
            SEEDCollectionSectionItem *item = self.datasource[sectionIndex];
            if (item.cellItems.count > rowIndex) {
                EHICalendarDayCellViewModel *cv = item.cellItems[rowIndex];
                [self doClickItemAction:cv];
            }
        }
        
    }
    
    self.shows = self.dates;
    
    if (self.datasource.count > 0 && self.refreshUIBlock) {
        self.refreshUIBlock(self.datasource);
    }
    
}

#pragma mark - Action
- (void)doClickItemAction:(EHICalendarDayCellViewModel *)model {
    // 第一次点击进来 插入
    // 第二次点击进来 小于当前时间 删除原来的插入新的时间
    // 第二次点击进来 大于等于当前时间 插入
    // 第三次点击进来 清空 插入
    [self.clickObj doClickItemAction:model WithDates:self.dates sectionItems:self.datasource];
    if ([self.delegate respondsToSelector:@selector(dayViewModel:didClickForCell:beginDate:endDate:)]) {
        EHICalendarDayModel *start = self.dates.firstObject.model;
        EHICalendarDayModel *end = (self.dates.count > 1) ? self.dates.lastObject.model : nil;
        [self.delegate dayViewModel:self didClickForCell:model.model beginDate:start endDate:end];
    }
    
    //刷新
    if (self.datasource.count > 0 && self.refreshUIBlock) {
        self.refreshUIBlock(self.datasource);
    }
}

#pragma mark - private
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
            EHICalendarDayModel *model = [EHICalendarDayModel calendarDayWithYear:0 month:0 day:0];
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
        
        EHICalendarSectinonViewModel *headerSectionItem = [[EHICalendarSectinonViewModel alloc] init];
        [headerSectionItem updateWithModel:arr];
        
        SEEDCollectionSectionItem *cellsSectionItem = [self p_dealCells:arr];
        
        [rst addObject:headerSectionItem];
        
        [rst addObject:cellsSectionItem];
      
    }
    
    return rst;
}

- (SEEDCollectionSectionItem *)p_dealCells:(NSArray<EHICalendarDayModel *> *)models {
    SEEDCollectionSectionItem *sectionVm = [[SEEDCollectionSectionItem alloc] init];
    sectionVm.columnCount = perweekDays;
    sectionVm.sectionInset = UIEdgeInsetsMake(0, 14, 0, 14);
    
    // 处理cells
      NSMutableArray<EHICalendarDayCellViewModel *> *arrs = [NSMutableArray array];
      for (int i = 0; i < models.count; i++) {
          EHICalendarDayModel *dayModel = models[i];
          EHICalendarDayCellViewModel *cv = [[EHICalendarDayCellViewModel alloc] init];
          
          if (!dayModel) {//为空
              [cv generateViewModelWithModel:dayModel type:EHICalendarDayCellTypeEmpty contentInset:cv.sectionInset desText:@""];
          } else if (dayModel.month <= [NSDate date].month && dayModel.getDate.isItPassday) { // 过去的时间
              [cv generateViewModelWithModel:dayModel type:EHICalendarDayCellTypeDisabled contentInset:sectionVm.sectionInset desText:@""];
          } else { // 中间正常显示
             
              
              [cv generateViewModelWithModel:dayModel type:EHICalendarDayCellTypeNormal contentInset:sectionVm.sectionInset desText:@""];

              // action
              if ([self.delegate respondsToSelector:@selector(dayViewModel:clickableOfCellViewModel:)]) {
                  BOOL flag = [self.delegate dayViewModel:self clickableOfCellViewModel:cv];
                  if (flag) {
                      EHiWeakSelf(self)
                      cv.seed_didSelectActionBlock = ^(EHICalendarDayCellViewModel *object) {
                          EHiStrongSelf(self)
                          [self doClickItemAction:object];
                      };
                  }
                  
              } else {
                   EHiWeakSelf(self)
                  cv.seed_didSelectActionBlock = ^(EHICalendarDayCellViewModel *object) {
                      EHiStrongSelf(self)
                      [self doClickItemAction:object];
                  };
              }
              
              // 用户再次自定义
              if ([self.delegate respondsToSelector:@selector(dayViewModel:afterGeneratedCellViewModel:)]) {
                  [self.delegate dayViewModel:self afterGeneratedCellViewModel:cv];
              }
          }
          [arrs addObject:cv];
      }
    
   
    sectionVm.cellItems = arrs.copy;
    
    return sectionVm;

}



#pragma mark - getter
- (NSMutableArray *)dates {
    if (!_dates) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:2];
        _dates = arr;
    }
    return _dates;
}

- (NSMutableArray<EHICalendarDayCellViewModel *> *)interCellVms {
    if (!_interCellVms) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:2];
        _interCellVms = arr;
    }
    return _interCellVms;
}

@end


