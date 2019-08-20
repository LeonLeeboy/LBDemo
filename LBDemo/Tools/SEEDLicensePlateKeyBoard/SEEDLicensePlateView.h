//
//  SEEDLicensePlateView.h
//  LBDemo
//
//  Created by 李兵 on 2019/8/20.
//  Copyright © 2019 ivan. All rights reserved.
//
//  输入车牌的keboard
//

#import <UIKit/UIKit.h>

#pragma mark -
#pragma mark protocol && typedefine

typedef NS_ENUM(NSInteger,SEDDLicesePlateViewEvent) {
    SEDDLicesePlateViewEventClickItem,               //!> 普通按钮
    SEDDLicesePlateViewEventClickDone,               //!> 完成事件
    SEDDLicesePlateViewEventClickABC,                //!> 点击ABC
    SEDDLicesePlateViewEventClickDel,                //!> 点击删除
    SEDDLicesePlateViewEventClickLicensePlate,       //!> 点击车牌
};

typedef NS_ENUM(NSInteger,SEDDLicensePlateStyle) {
    SEDDLicensePlateStyleABC,               //!> 26个英文字母格式
    SEDDLicensePlateStyleProvince           //!> 省模式
};

@class SEEDLicensePlateView;

@protocol SEEDLicensePlateDelegate <NSObject>

@optional
- (void)licensePlateView:(SEEDLicensePlateView *_Nullable)licensePlateView didClickText:(NSString *_Nullable)text clickEvent:(SEDDLicesePlateViewEvent)clickEvent;



@end

#pragma mark -
#pragma mark 省份键盘Item渲染model
@interface SEEDLicensePlateItemModel : NSObject

@property (nonatomic, copy) NSString * _Nullable text;

@property (nonatomic, strong) UIColor * _Nullable normalTextColor;

@property (nonatomic, strong) UIColor * _Nullable highLightedTextColor;

@property (nonatomic, strong) UIFont * _Nullable normalTextFont;

@property (nonatomic, strong) UIColor * _Nullable selecredTextColor;

@property (nonatomic, strong) UIColor * _Nullable defaultBackgroundColor;

@property (nonatomic, strong) UIColor * _Nullable selectedBackgroundColor;

@property (nonatomic, strong) UIColor * _Nullable highLightedBackgroundColor;

@property (nonatomic, strong)  UIImage * _Nullable backGroundImage;

@property (nonatomic, assign) CGFloat cornerRadius;

/** optional : 不写会自动计算的 */
@property (nonatomic, assign) CGSize size;

@end

#pragma mark -
#pragma mark 省份键盘渲染model
@interface SEEDLicensePlateModel : NSObject

@property (nonatomic, strong) UIColor * backGroundColor;

@property (nonatomic, assign) SEDDLicensePlateStyle style;

/** 每一行的的item 个数,optional */
@property (nonatomic, assign) NSInteger perLineCount;

/** 行数 */
@property (nonatomic, assign) NSInteger lineCount;

@property (nonatomic, assign) UIEdgeInsets contentInset;

/** 每一行的item间的间距 */
@property (nonatomic, assign) CGFloat itemSpace;

@property (nonatomic, assign) CGFloat inputViewHeight;

@property (nonatomic, assign) CGFloat lineSpace;

@property (nonatomic, strong) UIColor * _Nullable inPutViewBackGroundColor;

@property (nonatomic, strong) NSArray<SEEDLicensePlateItemModel *> * _Nullable itemModels;
@end


#pragma mark -
#pragma mark 省份键盘

NS_ASSUME_NONNULL_BEGIN
@interface SEEDLicensePlateView : UIView

@property (nonatomic, weak) id<SEEDLicensePlateDelegate> delegate;

@property (nonatomic, strong) UIView *inputView;
/** 渲染的model */
@property (nonatomic, strong, readonly) SEEDLicensePlateModel *renderModel;

- (instancetype)initWithModel:(SEEDLicensePlateModel *)renderModel;

- (instancetype)initWithStyle:(SEDDLicensePlateStyle)style;

- (void)renderViewWithModel:(SEEDLicensePlateModel *)renderModel;

- (void)renderViewWithWithStyle:(SEDDLicensePlateStyle)style;

@end
NS_ASSUME_NONNULL_END
