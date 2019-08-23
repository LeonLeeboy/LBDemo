//
//  EHIDetectionModel.h
//  LBDemo
//
//  Created by 李兵 on 2019/8/23.
//  Copyright © 2019 ivan. All rights reserved.
//
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface EHIDetecctionItemModel : NSObject

@property (nonatomic, assign) NSInteger itemID;

/** 检查子类项目的名称 */
@property (nonatomic, copy) NSString *itemName;

@property (nonatomic, assign) NSInteger animationDuration;

@property (nonatomic, assign, getter=isSuccess) BOOL success;

@end

@interface EHIDetectionModel : NSObject

/** value: 请确保以下设备均已关闭 */
@property (nonatomic, copy) NSString *title;

/** value: 打开蓝牙，还车速度更快 */
@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, strong) NSArray<EHIDetecctionItemModel *> *itemModels;


@end

NS_ASSUME_NONNULL_END
