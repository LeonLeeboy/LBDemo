//
//  LBAppDefines.h
//  LBDemo
//
//  Created by 李兵 on 2019/8/5.
//  Copyright © 2019 ivan. All rights reserved.
//

#ifndef LBAppDefines_h
#define LBAppDefines_h

#import "UIColor+YYAdd.h"

typedef void (^SelectedCallBack)(id object);
typedef BOOL (^CheckCallBack)(id object);
typedef void (^SelectedMultyCallBack)(id object1, id object2);

typedef void (^SelectedAtIndex)(NSInteger index);
typedef void (^EHIOperationBlock)(BOOL isSuccess);
typedef void (^ActionBlock)(void);

#pragma mark - App尺寸

#define DeviceFrame         [[UIScreen mainScreen] bounds]  // 整个屏幕尺寸
#define DeviceSize          DeviceFrame.size
#define Main_Screen_Height  DeviceSize.height
#define Main_Screen_Width   DeviceSize.width

#define kLBAPPNavHeight       (44 + kLBAPPStatusBarHeight)                                  // 导航栏高度
#define kLBAPPStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height// 状态栏高度
#define kLBAPPTabbarHeight    ((kLBAPPStatusBarHeight > 20) ? 83 : 49)                      // tabbar高度
#define kLBAPPBottomDistance  (kHaveTheSafetyArea ? 34 : 0)                               // 距离底部距离
#define kHaveTheSafetyArea  (kLBAPPStatusBarHeight > 20)


/** 线 */
#define SINGLE_LINE_WIDTH   (1 / [UIScreen mainScreen].scale)

/** 在6的基础上自动缩放 */
#define autoHeightOf6(HEIGHT)   (kHaveTheSafetyArea ? (HEIGHT) : (HEIGHT) * (DeviceSize.height / 667))
#define autoWidthOf6(WIDTH)     WIDTH * (DeviceSize.width / 375)

/** 机型判断 */
#define iPhoneX kHaveTheSafetyArea
#define iPhoneXR ((Main_Screen_Width == 414) && (Main_Screen_Height == 896))
#define iPhoneXS_MAX ((Main_Screen_Width == 414) && (Main_Screen_Height == 896))
#define Is5 DeviceSize.width <= 320
#define Is6P DeviceSize.height == 736

/** 系统判断 */
#define SystemVersion [[[UIDevice currentDevice] systemVersion] doubleValue]
#define IsIOS7 ((SystemVersion >= 7.0) ? YES : NO)
#define IsIOS8 ((SystemVersion >= 8.0) ? YES : NO)

/** 字体和加粗字体：适配 */
#define autoFONT(SIZE) Is6P ? FONT(SIZE * 1.1) : FONT(SIZE)
#define autoBoldFONT(SIZE) Is6P ? BoldFONT(SIZE * 1.1) : BoldFONT(SIZE)

/** 字体和加粗字体 */
#define FONT(SIZE) [UIFont systemFontOfSize:SIZE]
#define BoldFONT(SIZE) [UIFont boldSystemFontOfSize:SIZE]

/** 雅黑字体 */
#define FONT_MS_YAHEI(SIZE) [UIFont fontWithName:@"HelveticaNeue-Medium" size:SIZE / 1.9]

/** 主方法
 1. 特殊颜色：如渐变色、优惠折扣特殊色才使用
 2. 统一使用如下色值,如不包含,先跟UI确定色值是错误 或 新增色值 */

/** 色值 */
static inline UIColor * kLBAPPHexColor(uint32_t rgbValue) {
    return [UIColor colorWithRGB:rgbValue];
}
/** 色值（字符串） */
static inline UIColor * kLBAPPHexStringColor(NSString *color) {
    return [UIColor colorWithHexString:color];
}
/** 色值+alpha */
static inline UIColor * kLBAPPHexAlphaColor(uint32_t rgbValue, CGFloat alpha) {
    return [UIColor colorWithRGB:rgbValue alpha:alpha];
}
/** 颜色+alpha */
static inline UIColor * kLBAPPAlphaColor(UIColor *color, CGFloat alpha) {
    return [color colorWithAlphaComponent:alpha];
}

/** 主要色值 */
#define kLBAPPHexColor_FFFFFF kLBAPPHexColor(0xFFFFFF) // 白色
#define kLBAPPHexColor_000000 kLBAPPHexColor(0x000000) // 黑色：仅用于弹窗背景底色40%不透明度

/** 文字、底色、线 */
#define kLBAPPHexColor_333333 kLBAPPHexColor(0x333333) // 黑色：重要文字用色、按钮（可按、按下、不可按依次按不透明度100%、60%、30%递减）（step2左侧tab底色2%透明度）
#define kLBAPPHexColor_7B7B7B kLBAPPHexColor(0x7B7B7B) // 灰色：仅用于次要文字
#define kLBAPPHexColor_CCCCCC kLBAPPHexColor(0xCCCCCC) // 浅灰色：仅用于占位文字
#define kLBAPPHexColor_F2F2F2 kLBAPPHexColor(0xF2F2F2) // 淡灰色：仅用于全局背景底色
#define kLBAPPHexColor_EEEEEE kLBAPPHexColor(0xEEEEEE) // 淡灰色：仅用于全局分割线

/** 特殊色值 */
#define kLBAPPHexColor_FF7E00 kLBAPPHexColor(0xFF7E00) // 橙色：用于重要按钮底色、少量提示性文字、部分icon、按钮（可按、按下、不可按依次按不透明度100%、60%、30%递减）
#define kLBAPPHexColor_29B7B7 kLBAPPHexColor(0x29B7B7) // 青色：用于提示性文字、链接文字、部分icon
#define kLBAPPHexColor_FFEFE0 kLBAPPHexColor(0xFFEFE0) // 淡黄色：仅用于顶部提示条底色
#define kLBAPPHexColor_F43530 kLBAPPHexColor(0xF43530) // 红色：仅用于部分提示性圆点、提示性文字
#define kLBAPPHexColor_FFF9F6 kLBAPPHexColor(0xFFF9F6) // 淡红色：仅用于标签
#define kLBAPPHexColor_20AF36 kLBAPPHexColor(0x20AF36) // 绿色：仅用于优惠价格文字、部分标签颜色

/** 按钮、icon */
#define kLBAPPHexColor_F8F8F8 kLBAPPHexColor(0xF8F8F8) // 淡灰色：（可按、按下、不可按依次按不透明度100%、60%、30%递减）
#define kLBAPPHexColor_646774 kLBAPPHexColor(0x646774) // 蓝灰色：重要icon用色、step2底部筛选底色90%不透明度
#define kLBAPPHexColor_DDDDDD kLBAPPHexColor(0xDDDDDD) // 淡灰色：次要icon用色

/** 不规范色值（不好动，之后替换掉） */
#define kLBAPPHexColor_FFF0F0 kLBAPPHexColor(0xFFF0F0)
#define kLBAPPHexColor_3766FF kLBAPPHexColor(0x3766FF)
#define kLBAPPHexColor_34B9FB kLBAPPHexColor(0x34B9FB)
#define kLBAPPHexColor_6F717A kLBAPPHexColor(0x6F717A)



/** 主要色值 */
#define kEHIHexColor_FFFFFF kEHIHexColor(0xFFFFFF) // 白色
#define kEHIHexColor_000000 kEHIHexColor(0x000000) // 黑色：仅用于弹窗背景底色40%不透明度



/** 主方法
 1. 特殊颜色：如渐变色、优惠折扣特殊色才使用
 2. 统一使用如下色值,如不包含,先跟UI确定色值是错误 或 新增色值 */

/** 色值 */
static inline UIColor * kEHIHexColor(uint32_t rgbValue) {
    return [UIColor colorWithRGB:rgbValue];
}
/** 色值（字符串） */
static inline UIColor * kEHIHexStringColor(NSString *color) {
    return [UIColor colorWithHexString:color];
}
/** 色值+alpha */
static inline UIColor * kEHIHexAlphaColor(uint32_t rgbValue, CGFloat alpha) {
    return [UIColor colorWithRGB:rgbValue alpha:alpha];
}
/** 颜色+alpha */
static inline UIColor * kEHIAlphaColor(UIColor *color, CGFloat alpha) {
    return [color colorWithAlphaComponent:alpha];
}


/** 文字、底色、线 */
#define kEHIHexColor_333333 kEHIHexColor(0x333333) // 黑色：重要文字用色、按钮（可按、按下、不可按依次按不透明度100%、60%、30%递减）（step2左侧tab底色2%透明度）
#define kEHIHexColor_7B7B7B kEHIHexColor(0x7B7B7B) // 灰色：仅用于次要文字
#define kEHIHexColor_CCCCCC kEHIHexColor(0xCCCCCC) // 浅灰色：仅用于占位文字
#define kEHIHexColor_F2F2F2 kEHIHexColor(0xF2F2F2) // 淡灰色：仅用于全局背景底色
#define kEHIHexColor_EEEEEE kEHIHexColor(0xEEEEEE) // 淡灰色：仅用于全局分割线

/** 特殊色值 */
#define kEHIHexColor_FF7E00 kEHIHexColor(0xFF7E00) // 橙色：用于重要按钮底色、少量提示性文字、部分icon、按钮（可按、按下、不可按依次按不透明度100%、60%、30%递减）
#define kEHIHexColor_29B7B7 kEHIHexColor(0x29B7B7) // 青色：用于提示性文字、链接文字、部分icon
#define kEHIHexColor_FFEFE0 kEHIHexColor(0xFFEFE0) // 淡黄色：仅用于顶部提示条底色
#define kEHIHexColor_F43530 kEHIHexColor(0xF43530) // 红色：仅用于部分提示性圆点、提示性文字
#define kEHIHexColor_FFF9F6 kEHIHexColor(0xFFF9F6) // 淡红色：仅用于标签
#define kEHIHexColor_20AF36 kEHIHexColor(0x20AF36) // 绿色：仅用于优惠价格文字、部分标签颜色

/** 按钮、icon */
#define kEHIHexColor_F8F8F8 kEHIHexColor(0xF8F8F8) // 淡灰色：（可按、按下、不可按依次按不透明度100%、60%、30%递减）
#define kEHIHexColor_646774 kEHIHexColor(0x646774) // 蓝灰色：重要icon用色、step2底部筛选底色90%不透明度
#define kEHIHexColor_DDDDDD kEHIHexColor(0xDDDDDD) // 淡灰色：次要icon用色

/** 不规范色值（不好动，之后替换掉） */
#define kEHIHexColor_FFF0F0 kEHIHexColor(0xFFF0F0)
#define kEHIHexColor_3766FF kEHIHexColor(0x3766FF)
#define kEHIHexColor_34B9FB kEHIHexColor(0x34B9FB)
#define kEHIHexColor_6F717A kEHIHexColor(0x6F717A)

#pragma mark - 方法

/** weak & strong */
#define EHiWeakSelf(type)           __weak typeof(type) weak##type = type;
#define EHiStrongSelf(_instance)    __strong typeof(weak##_instance) _instance = weak##_instance;

#endif /* LBDefines_h */
