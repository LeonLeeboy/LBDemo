//
//  SEEDPasswordInputView.h
//  XSGeneration
//
//  Created by 李兵 on 2017/12/13.
//  Copyright © 2017年 李兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SEEDPasswordInputView;

@protocol SEEDPassWorldDelegate <NSObject>

@optional
- (void)SEEDPassWordInputView:(SEEDPasswordInputView *)inputView text:(NSString *)text complete:(BOOL)complete;

@end

@interface SEEDPasswordInputView : UIView

@property (nonatomic, weak) id <SEEDPassWorldDelegate> delegate;

@property (nonatomic, assign, readonly) NSUInteger passWordLength;

/** 是否是密文形式 */
@property (nonatomic, assign, getter=isSecureTextEntry) BOOL secureTextEntry;

/** 密码 */
@property (nonatomic, copy, readonly) NSString *password;

/** gridView 的边框颜色 */
@property (nonatomic, strong) UIColor *defaultBorderColor;

/** gridView 的边框颜色 */
@property (nonatomic, strong) UIColor *selectedBorderColor;

/** 明文的颜色 */
@property (nonatomic, strong) UIColor *textColor;

/** 密码原点的颜色 */
@property (nonatomic, strong) UIColor *dotColor;

/** 每个方框间的间隔 */
@property (nonatomic, assign) CGFloat itemSpace;

/** 边框宽度 */
@property (nonatomic, assign) CGFloat gridLineWidth;

/** 每个方框间的圆角： 只有在itemSpace > 0 的时候work */
@property (nonatomic, assign) CGFloat itemCornerRadius;

+ (instancetype)viewWithPassworldLength:(NSUInteger)length;

- (void)seedBecomeFirstResponder;

@end
