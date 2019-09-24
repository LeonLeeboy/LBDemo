//
//  EHINewItinerayItemModel.h
//  LBDemo
//
//  Created by 李兵 on 2019/9/23.
//  Copyright © 2019 ivan. All rights reserved.
//
//  我的行程列表 展示 模型
//

#import <Foundation/Foundation.h>
@class EHINewItineraryCellContentModel;

NS_ASSUME_NONNULL_BEGIN

@interface EHINewItinerayItemModel : NSObject

/** 订单日期（2019年10月2日） */
@property (nonatomic, copy) NSString *orderDate;

@property (nonatomic, strong) NSArray<EHINewItineraryCellContentModel *> *orderLists;

@end



NS_ASSUME_NONNULL_END
