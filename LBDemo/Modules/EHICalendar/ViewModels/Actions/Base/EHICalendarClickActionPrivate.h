//
//  EHICalendarClickActionPrivate.h
//  LBDemo
//
//  Created by 李兵 on 2020/3/13.
//  Copyright © 2020 ivan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SEEDCollectionSectionItem;
@class EHICalendarDayCellViewModel;

@interface EHICalendarClickActionPrivate : NSObject

- (NSMutableArray<EHICalendarDayCellViewModel *> *)p_dealIntellCellBeginAndEndDates:(NSArray *)dates IntellCells:(NSMutableArray<SEEDCollectionSectionItem *> *)sectionItems;

/** 清除中间内容 */
- (void)clearInterCellData;

@end

