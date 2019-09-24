//
//  EHINewItineraryViewModel.m
//  LBDemo
//
//  Created by 李兵 on 2019/9/20.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "EHINewItineraryViewModel.h"
#import "EHINewItinerayItemModel.h"
#import "EHINewItineraryCellContentModel.h"

@interface EHINewItineraryViewModel ()

@property (nonatomic, strong, readwrite) NSArray<EHINewItinerayItemModel *> *dataSource;

@end

@implementation EHINewItineraryViewModel

- (void)getMyNewItineraryDataWith:(id)parames{
    
    if (self.refreshUI) {
        self.refreshUI(self.dataSource);
    }
}

#pragma mark - private
/** 将原数据源 转为 可用数据源 */
- (NSArray<EHINewItinerayItemModel *> *)p_transferModelToDataSourceFWithDataSource:(NSArray<EHINewItineraryCellContentModel *> *)originDataSource {
    
    NSMutableArray *dataSource = [NSMutableArray array];
    
    EHINewItineraryCellContentModel *preObj;
    for (int i = 0; i < originDataSource.count; i++) {
        EHINewItineraryCellContentModel *currentObj = originDataSource[i];
        
        if (preObj.orderDate != currentObj.orderDate) {
            EHINewItinerayItemModel *itemModel = [[EHINewItinerayItemModel alloc] init];
            itemModel.orderDate = currentObj.orderDate;
            itemModel.orderLists = [self p_getTodyOrdersWithDataSource:originDataSource selectWithOrderDate:currentObj.orderDate];
            [dataSource addObject:itemModel];
        }
        preObj = currentObj;
    }
    
    return dataSource;
}

/** 根据Date 得到响应数据源 */
- (NSArray<EHINewItineraryCellContentModel *> *)p_getTodyOrdersWithDataSource:(NSArray<EHINewItineraryCellContentModel *> *)dataSource
                                                          selectWithOrderDate:(NSString *)orderDate {
    
    NSMutableArray *rst = [NSMutableArray array];
    
    for (int i = 0; i < dataSource.count; i++) {
        EHINewItineraryCellContentModel *m = dataSource[i];
        if ([m.orderDate isEqualToString:orderDate]) {
            [rst addObject:m];
        }
    }
    
    return rst;
}

@end
