//
//  EHICalendarClickActionOrder.m
//  LBDemo
//
//  Created by 李兵 on 2020/3/13.
//  Copyright © 2020 ivan. All rights reserved.
//

#import "EHICalendarClickActionOrder.h"
#import "EHICalendarDayCellViewModel.h"
#import "EHICalendarDayModel.h"
#import "EHICalendarClickActionPrivate.h"
#import "NSDate+EHICalendar.h"

@interface EHICalendarClickActionOrder ()

@property (nonatomic, strong) EHICalendarClickActionPrivate *privateAction;

/** 选择的开始和结束时间CellVM */
@property (nonatomic, strong) NSMutableArray<EHICalendarDayCellViewModel *> *dates;

/** 选择的中间的cellVMs */
@property (nonatomic, strong) NSMutableArray<EHICalendarDayCellViewModel *> *interCellVms;

@end

@implementation EHICalendarClickActionOrder

- (NSMutableArray<EHICalendarDayCellViewModel *> *)doClickItemAction:(EHICalendarDayCellViewModel *)model
                                                           WithDates:(NSMutableArray<EHICalendarDayCellViewModel *> *)dates
                                                        sectionItems:(NSArray<SEEDCollectionSectionItem *> *)sectionItems {
    
    if (dates.count == 0) { // 第一次点击进来
        [model generateViewModelWithModel:model.model type:EHICalendarDayCellTypeLeftRightConcidence contentInset:model.sectionInset desText:@"取车"];
        
        [dates addObject:model];
    } else if (dates.count == 1) { // 第二次点击进来
        EHICalendarDayCellViewModel *firtCV = dates.firstObject;
        NSDate *firstDate = firtCV.model.getDate;
        NSDate *clickDate = model.model.getDate;
        
        NSComparisonResult rst = [clickDate compare:firstDate];
        
        switch (rst) {
            case NSOrderedDescending: {// 降 大于第一次点击时间
                // 处理头尾
                [firtCV generateViewModelWithModel:firtCV.model type:EHICalendarDayCellTypeLeftCorner contentInset:firtCV.sectionInset desText:@"取车"];
                [model generateViewModelWithModel:model.model type:EHICalendarDayCellTypeRightCoorner contentInset:model.sectionInset desText:@"还车"];
                [dates addObject:model];
                //处理中间
                self.interCellVms = [self.privateAction p_dealIntellCellBeginAndEndDates:dates IntellCells:sectionItems];
                // 再次处理头尾
                if (firtCV.model.month != model.model.month && (firtCV.model.day == firtCV.model.getDate.totalDaysInMonth)) { //没有中间cell 并且 跨月份
                     [firtCV generateViewModelWithModel:firtCV.model type:EHICalendarDayCellTypeLeftRightConcidence contentInset:firtCV.sectionInset desText:@"取车"];
                }
                if (firtCV.model.month != model.model.month && (model.model.day == 1)) {
                     [model generateViewModelWithModel:model.model type:EHICalendarDayCellTypeLeftRightConcidence contentInset:model.sectionInset desText:@"还车"];
                }
            }
                break;
            case NSOrderedAscending: {// 升 小于第一次点击时间
                [self p_clear:dates]; // 清除
                [model generateViewModelWithModel:model.model type:EHICalendarDayCellTypeLeftRightConcidence contentInset:model.sectionInset desText:@"取车"];
                
                [dates addObject:model];
            }
                break;
            case NSOrderedSame: {// 当前时间
                [model generateViewModelWithModel:model.model type:EHICalendarDayCellTypeLeftRightConcidence contentInset:model.sectionInset desText:@"取/还车"];
                
                [dates addObject:model];
            }
                break;
                
            default:
                break;
        }
     
    } else if (dates.count == 2) {// 第三次点击进来
        [self p_clear:dates]; // 清除
        [model generateViewModelWithModel:model.model type:EHICalendarDayCellTypeLeftRightConcidence contentInset:model.sectionInset desText:@"取车"];
        [dates addObject:model];
    }
    
    self.dates = dates;
    return dates;
    
}

/** 清除选中的效果 */
- (void)p_clear:(NSMutableArray *)dates {
    // 将首位,末尾清除 还原
    for (EHICalendarDayCellViewModel *cv in dates) {
        if (cv) {
            [cv generateViewModelWithModel:cv.model type:EHICalendarDayCellTypeNormal contentInset:cv.sectionInset desText:@""];
        }
    }
    [self.dates removeAllObjects];
    [self.privateAction clearInterCellData];
    
}

- (EHICalendarClickActionPrivate *)privateAction {
    if (!_privateAction) {
        EHICalendarClickActionPrivate *action = [[EHICalendarClickActionPrivate alloc] init];
        _privateAction = action;
    }
    return _privateAction;
}


@end
