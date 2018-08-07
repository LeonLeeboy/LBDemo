//
//  UIView+IBAppearance.m
//  demo
//
//  Created by ivan on 2018/7/12.
//  Copyright © 2018年 ivan. All rights reserved.
//

#import "UIView+IBAppearance.h"
IB_DESIGNABLE
@implementation UIView (IBAppearance)

- (CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat)borderWidth{
    return self.layer.borderWidth;
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}

- (UIColor *)borderColor{
    return self.layer.borderUIColor;
}

- (void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderUIColor = borderColor;
}

#pragma mark - shadow
- (CGPoint)shadowOffset{
    return CGPointMake(self.layer.shadowOffset.width, self.layer.shadowOffset.height);
}

- (void)setShadowOffset:(CGPoint)shadowOffset{
    self.layer.shadowOffset = CGSizeMake(shadowOffset.x, shadowOffset.y);
}

- (UIColor *)shadowColor{
    return [UIColor colorWithCGColor: self.layer.shadowColor];
}

- (void)setShadowColor:(UIColor *)shadowColor{
    self.layer.shadowColor = shadowColor.CGColor;
}

- (CGFloat)shadowRadius{
    return self.layer.shadowRadius;
}

- (void)setShadowRadius:(CGFloat)shadowRadius{
    self.layer.shadowRadius = shadowRadius;
}

- (CGFloat)shadowOpacity{
    return self.layer.shadowOpacity;
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity{
    self.layer.shadowOpacity = shadowOpacity;
}

- (BOOL)maskToBounds{
    return self.layer.masksToBounds;
}

- (void)setMaskToBounds:(BOOL)maskToBounds{
    self.layer.masksToBounds = maskToBounds;
}

@end

IB_DESIGNABLE
@implementation CALayer(IBAppearance)

- (UIColor *)borderUIColor{
    return [UIColor colorWithCGColor:self.borderColor];
}

- (void)setBorderUIColor:(UIColor *)borderUIColor{
    self.borderColor = borderUIColor.CGColor;
}

@end
