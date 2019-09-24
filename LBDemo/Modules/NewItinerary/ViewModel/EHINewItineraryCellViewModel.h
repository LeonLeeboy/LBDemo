//
//  EHINewItineraryCellViewModel.h
//  LBDemo
//
//  Created by 李兵 on 2019/9/20.
//  Copyright © 2019 ivan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EHINewItineraryCellContentModel,EHINewItineraryMessagesItemModel;

NS_ASSUME_NONNULL_BEGIN

@interface EHINewItineraryCellViewModel : NSObject

/** 获取停靠站 的信息 */
+ (NSArray<NSString *> *)getDockSitesWithModel:(EHINewItineraryCellContentModel *)model;

/** 获得乘客信息，取还车时间，车辆信息，司机信息 数组 */
+ (NSArray<EHINewItineraryMessagesItemModel *> *)getMessagesWithModel:(EHINewItineraryCellContentModel *)model;

@end

NS_ASSUME_NONNULL_END
