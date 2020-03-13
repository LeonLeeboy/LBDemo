//
//  EHICalendarClickActionProtol.h
//  LBDemo
//
//  Created by 李兵 on 2020/3/13.
//  Copyright © 2020 ivan. All rights reserved.
//

#import <Foundation/Foundation.h>


@class EHICalendarDayCellViewModel;
@class SEEDCollectionSectionItem;

@protocol EHICalendarClickActionProtol <NSObject>

@optional
- (NSMutableArray<EHICalendarDayCellViewModel *> *)doClickItemAction:(EHICalendarDayCellViewModel *)model
                                                           WithDates:(NSMutableArray<EHICalendarDayCellViewModel *> *)dates sectionItems:(NSArray<SEEDCollectionSectionItem *> *)sectionItems;

@end

