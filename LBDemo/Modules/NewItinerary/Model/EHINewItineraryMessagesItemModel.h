//
//  EHINewItineraryMessagesItemModel.h
//  LBDemo
//
//  Created by 李兵 on 2019/9/20.
//  Copyright © 2019 ivan. All rights reserved.
//
//  EHINewItineraryMessagesView 每一行的 model
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EHINewItineraryMessagesItemModel : NSObject

#pragma mark 需要配置

/** 当前行描述 */
@property (nonatomic, copy) NSString *des;

/** 当前行描述 对应的值 */
@property (nonatomic, copy) NSString *desValue;

/** 没有“当前行描述“ 需要显示的值 */
@property (nonatomic, copy) NSString *normalValue;

/** 没有“当前行描述“ 需要显示的值 */
@property (nonatomic, copy) NSString *iconImageName;

/** 当前行描述 对应的富文本值 （和desValue 互斥）*/
@property (nonatomic, copy) NSAttributedString *desAttributedValue;

/** 隐藏View下划线，默认需要设置为NO */
@property (nonatomic, assign) BOOL hiddenBottomLine;

#pragma mark 无需设置

/** 隐藏 没有“当前行描述“ 需要显示的值 ： 根据des 来判断 */
@property (nonatomic, assign) BOOL hiddenNormalValue;

@end

NS_ASSUME_NONNULL_END
