//
//  EHIHicarOperationBottomView.h
//  LBDemo
//
//  Created by 李兵 on 2019/8/13.
//  Copyright © 2019 ivan. All rights reserved.
//
//  嗨车取车页面底部的View
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EHIHicarBottomViewStyle) {
    EHIHicarBottomViewStyleNotAssigned,    //!> 未分配车牌
    EHIHicarBottomViewStyleAssigned
};

typedef NS_ENUM(NSInteger, EHIHicarBottomEventType) {
    EHIHicarBottomEventTypeScan,    //!> 扫车牌取车
    EHIHicarBottomEventTypeConfirmGetCar, //!> 确认取车事件
    EHIHicarBottomEventTypeChangeCar, //!> 更换车辆
    EHIHicarBottomEventTypeSearchCar, //!> 寻找车辆
};

NS_ASSUME_NONNULL_BEGIN

typedef void(^EHIHicarBottomDidClickBlock)(EHIHicarBottomEventType);

@interface EHIHicarOperationBottomView : UIView

@property (nonatomic, assign) BOOL haveSearCar;

@property (nonatomic, copy) EHIHicarBottomDidClickBlock didClickBlock;

- (instancetype)initWhtBottomViewWithStyle:(EHIHicarBottomViewStyle)viewStyle;

- (void)renderViewWithViewStyle:(EHIHicarBottomViewStyle)viewStyle;

@end

NS_ASSUME_NONNULL_END
