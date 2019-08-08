//
//  SEEDSelecteView.h
//  1haiiPhone
//
//  Created by 李兵 on 2019/7/4.
//  Copyright © 2019 EHi. All rights reserved.
//
//  单选控件
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark -

typedef NS_ENUM(NSInteger , SEEDIconPosition) {
    SEEDIconPositionRightAndBottom             //!<默认右下角
};

@interface SEEDSelectedItemModel : NSObject <NSCoding,NSCopying>

/** 单选项展示的内容（required） */
@property (nonatomic, copy,)   NSString                *displayText;

/** 单选项展示的内容唯一标识符（required） */
@property (nonatomic, assign) NSInteger               itemID;

/** 每个item的size（required）*/
@property (nonatomic, assign) CGSize                  itemSize;

/** 是否选中（optional）*/
@property (nonatomic, assign, getter=isSelected) BOOL  selected;

/** 右下角icon的width（optional）*/
@property (nonatomic, assign) CGFloat                 selectedIconWidth;

/** 展现的字体font（optional） */
@property (nonatomic, strong) UIFont                  *displayTextFont;

/** 默认字体color（optional） */
@property (nonatomic, strong) UIColor                 *defaultTextColor;

/** 选中字体Color（optional） */
@property (nonatomic, strong) UIColor                 *selectedTextColor;

/** 默认边框Color（optional） */
@property (nonatomic, strong) UIColor                 *defalutBorderColor;

/** 选中边框Color（optional） */
@property (nonatomic, strong) UIColor                 *selectedBorderColor;

/** 选项的圆角（optional） */
@property (nonatomic, assign) CGFloat                 cornerRadius;

/** 图片的位置（optional，default 右下角） */
@property (nonatomic, assign) SEEDIconPosition            iconPosition;

/** 默认图标（optional) */
@property (nonatomic, copy)   NSString                *defalultIconName;

/** 选择图标（optional) */
@property (nonatomic, copy)   NSString                *selectedIconName;

@end

#pragma mark -

@interface SEEDSelecteModel : NSObject


/** optional（默认是不可取消） ，选中的按钮是否可取消 */
@property (nonatomic, assign) BOOL                                         cancelable;
/** optional */
@property (nonatomic, assign) UIEdgeInsets                                 contentInset;

@property (nonatomic, assign) CGFloat                                      interitemSpacing;

@property (nonatomic, assign) CGFloat                                      lineSpacing;

/** optional，整个view的高度 */
@property (nonatomic, assign) CGFloat                                      height;

@property (nonatomic, strong) NSMutableArray<__kindof SEEDSelectedItemModel *>      *items;

@end

#pragma mark -

/** 这个block的返回值控制该选项选中与否  */
typedef BOOL (^SEEDSelectViewDidClickhandler)(SEEDSelectedItemModel *model);

/** 点中回调 */
typedef void (^SEEDSelectViewDidSelecteBlock)(SEEDSelectedItemModel *model);

/** 初始化完成后 && 刷新后的回调 */
typedef void (^SEEDSelectViewRefreshBlock)(SEEDSelectedItemModel *model);

@interface SEEDSelecteView : UIView


/** 回调点击的model */
@property (nonatomic, copy) SEEDSelectViewDidSelecteBlock handleActionHandler;

/** 刷新后的回调 */
@property (nonatomic, copy) SEEDSelectViewRefreshBlock refreshBlock;

/** 返回点击的该选项是否选中 */
@property (nonatomic, copy) SEEDSelectViewDidClickhandler clickItemBlock;

@property (nonatomic, strong, readonly) SEEDSelecteModel *renderModel;

- (instancetype)initWithModel:(SEEDSelecteModel *)model;

/**
 此handler 会在该View在父view上显示的时候触发一个回调，回掉一个选中的模型，返回selected的item的model ,每次的点击事件也会走这个方法，
 点击的时候，handleActionHandler 已实现，优先级：handleActionHandler > handlerBlock
 @param model 初始化model
 @param handlerBlock 点击回调，初始化完成，以及渲染完成后（返回点击的model）回调。block 的返回值为BOOL 。
        return YES ，选中。
        return NO  ，不选中。
 @return 该对象
 
 */
- (instancetype)initWithModel:(SEEDSelecteModel *)model Handler:(SEEDSelectViewDidSelecteBlock)handlerBlock;

- (instancetype)initWithModel:(SEEDSelecteModel *)model complementation:(SEEDSelectViewRefreshBlock)complementation;

/** 重新渲染页面，记录值 */
- (void)renderViewWithModel:(SEEDSelecteModel *)model;

/** 切换被选中的类型 */
- (void)changeSeletedItemWithItemID:(NSInteger)itemID;
@end

NS_ASSUME_NONNULL_END
