//
//  EHICalendarTopView.h
//  LBDemo
//
//  Created by 李兵 on 2020/3/6.
//  Copyright © 2020 ivan. All rights reserved.
//
//  顶部开始时间 结束时间
//

#import <UIKit/UIKit.h>
#import "EHICalendarDayModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EHICalendarTopView : UIView

//左侧按钮点击
@property (nonatomic, copy) void(^leftClickAction)(id data);

//右侧按钮点击
@property (nonatomic, copy) void(^rightClickAction)(id data);

//选中的 左侧 日期模型
@property (nonatomic, strong) EHICalendarDayModel *leftModel;
//选中的 右侧 日期模型
@property (nonatomic, strong) EHICalendarDayModel *rightModel;

@end

NS_ASSUME_NONNULL_END
