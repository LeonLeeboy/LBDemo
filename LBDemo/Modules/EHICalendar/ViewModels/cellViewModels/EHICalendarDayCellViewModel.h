//
//  EHICalendarDayCellViewModel.h
//  LBDemo
//
//  Created by 李兵 on 2020/3/6.
//  Copyright © 2020 ivan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SEEDCollectionCellItemProtocol.h"

#pragma mark -

@class EHICalendarDayModel;

static CGFloat disPlayTextHeight() {
    return autoHeightOf6(32);
}

static CGFloat desTextHeight() {
    return autoHeightOf6(14);
}

static CGFloat disPlayTextTop() {
    return autoHeightOf6(2);
}

static CGFloat disPlayTextLeft() {
    return 5;
}

typedef NS_ENUM(NSInteger,EHICalendarDayCellType) {
    EHICalendarDayCellTypeEmpty,               //!> 空
    EHICalendarDayCellTypeNormal,              //!> 正常可用
    EHICalendarDayCellTypeDisabled,            //!> 不可用
    EHICalendarDayCellTypeLeftRightConcidence, //!> 左右重合
    EHICalendarDayCellTypeLeftCorner,          //!> 左边切圆
    EHICalendarDayCellTypeRightCoorner,        //!> 右边切圆
    EHICalendarDayCellTypeIntecellNomal,       //!> 左右两个切圆中间正常的样式
    EHICalendarDayCellTypeIntecellLeft,        //!> 左右两个切圆中间左边切圆的样式
    EHICalendarDayCellTypeIntecellRight        //!> 左右两个切圆中间右边切圆的样式
};

@interface EHICalendarDayCellViewModel : NSObject<SEEDCollectionCellItemProtocol>

#pragma mark  getter

@property (nonatomic, assign, readonly) EHICalendarDayCellType identityType;

@property (nonatomic, strong, readonly) EHICalendarDayModel *model;

/** 日历 */
@property (nonatomic, strong) NSAttributedString *displayAttributed;


/** 描述信息 */
@property (nonatomic, copy) NSAttributedString *desDisplayAttributed;

/** 描述信息颜色 */
@property (nonatomic, strong, readonly) UIColor *desTextColor;

/** 背景颜色 */
@property (nonatomic, strong, readonly) UIColor *bgColor;

/** 圆的颜色 */
@property (nonatomic, strong, readonly) UIColor *cycleColor;

/** 切圆背景色 */
@property (nonatomic, strong, readonly) UIColor *layerColor;

@property (nonatomic, assign, readonly) UIEdgeInsets sectionInset;


#pragma mark  
- (void)generateViewModelWithModel:(EHICalendarDayModel *)model type:(EHICalendarDayCellType)type contentInset:(UIEdgeInsets)contentInset desText:(NSString *)desText;

/// 对应cell的类
- (Class )seed_CellClass;

@end




