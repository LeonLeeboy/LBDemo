//
//  EHICalendarDayCellViewModel.h
//  LBDemo
//
//  Created by 李兵 on 2020/3/6.
//  Copyright © 2020 ivan. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark -

@class EHICalendarDayModel;

typedef NS_ENUM(NSInteger,EHICalendarDayCellType) {
    EHICalendarDayCellTypeNormal,        //!> 正常可用
    EHICalendarDayCellTypeDisabled,      //!> 不可用
    EHICalendarDayCellTypeLeftCorner,    //!> 左边切圆
    EHICalendarDayCellTypeRightCoorner,  //!> 右边切圆
    EHICalendarDayCellTypeIntecell       //!> 左右两个切圆中间
};

@interface EHICalendarDayCellViewModel : NSObject


#pragma mark  getter

@property (nonatomic, assign, readonly) EHICalendarDayCellType identityType;

@property (nonatomic, strong, readonly) EHICalendarDayModel *model;

/** 日历 */
@property (nonatomic, copy) NSString *display;

/** 文字颜色 */
@property (nonatomic, strong, readonly) UIColor *textColor;

/** 描述信息 */
@property (nonatomic, copy) NSString *desDisplay;

/** 描述信息颜色 */
@property (nonatomic, strong, readonly) UIColor *desTextColor;

/** 背景颜色 */
@property (nonatomic, strong, readonly) UIColor *bgColor;

/** 圆的颜色 */
@property (nonatomic, strong, readonly) UIColor *cycleColor;

/** 切圆背景色 */
@property (nonatomic, strong, readonly) UIColor *layerColor;

/** item  大小 */
@property (nonatomic, assign, readonly) CGSize itemSize;



#pragma mark  
- (void)generateViewModelWithModel:(EHICalendarDayModel *)model type:(EHICalendarDayCellType)type;

- (NSString *)reuseIdentifier;


@end




