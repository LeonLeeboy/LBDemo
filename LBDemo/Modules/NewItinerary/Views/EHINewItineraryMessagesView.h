//
//  EHINewItineraryMessagesView.h
//  LBDemo
//
//  Created by 李兵 on 2019/9/20.
//  Copyright © 2019 ivan. All rights reserved.
//
//  我的行程 “时间，乘客信息，司机信息，车辆信息 list”
//

#import <UIKit/UIKit.h>
@class EHINewItineraryMessagesItemModel;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 时间，乘客信息，司机信息，车辆信息 itemView
#pragma mark -

@interface EHINewItineraryMessagesItemView : UIView


- (void)renderViewWithModel:(EHINewItineraryMessagesItemModel *)model;

@end

#pragma mark -

@interface EHINewItineraryMessagesView : UIView

- (void)renderViewWithModels:(NSArray<EHINewItineraryMessagesItemModel *> *)models;

@end

NS_ASSUME_NONNULL_END
