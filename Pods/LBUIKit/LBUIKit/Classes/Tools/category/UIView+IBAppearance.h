//
//  UIView+IBAppearance.h
//  demo
//
//  Created by ivan on 2018/7/12.
//  Copyright © 2018年 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (IBAppearance)

@property (nonatomic , assign) IBInspectable CGFloat borderWidth;

@property (nonatomic , strong) IBInspectable UIColor * borderColor;

@property (nonatomic , assign) IBInspectable CGFloat cornerRadius;

#pragma mark - shadow
//阴影偏移点
@property (nonatomic , assign) IBInspectable CGPoint shadowOffset;
//阴影颜色
@property (nonatomic , weak) IBInspectable UIColor *shadowColor;
//阴影圆角
@property(nonatomic , assign) IBInspectable CGFloat shadowRadius;
//阴影透明度
@property (nonatomic , assign) IBInspectable CGFloat shadowOpacity;


@property (nonatomic , assign) IBInspectable BOOL maskToBounds;

@end



@interface CALayer(IBAppearance)

@property (nonatomic , weak) UIColor *borderUIColor;

@end
