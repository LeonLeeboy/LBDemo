//
//  EHICalendarTopView.h
//  LBDemo
//
//  Created by 李兵 on 2020/3/6.
//  Copyright © 2020 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EHICalendarTopView : UIView

//左侧按钮点击
@property (nonatomic, copy) void(^leftClickAction)(id data);

//右侧按钮点击
@property (nonatomic, copy) void(^rightClickAction)(id data);

////选中的 左侧 日期模型
//@property (nonatomic, strong) JGCalendarDayModel *LeftModel;
////选中的 右侧 日期模型
//@property (nonatomic, strong) JGCalendarDayModel *RightModel;

@end

NS_ASSUME_NONNULL_END
