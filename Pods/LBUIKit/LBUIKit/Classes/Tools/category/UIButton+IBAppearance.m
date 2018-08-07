//
//  UIButton+IBAppearance.m
//  demo
//
//  Created by ivan on 2018/7/23.
//  Copyright © 2018年 ivan. All rights reserved.
//

#import "UIButton+IBAppearance.h"
#import "UIImage+LBExtend.h"

IB_DESIGNABLE
@implementation UIButton (IBAppearance)

- (UIColor *)backgroundColorForNormal{
    return nil;
}

- (void)setBackgroundColorForNormal:(UIColor *)backgroundColorForNormal{
    [self setBackgroundImage:[UIImage imageFormColor:backgroundColorForNormal size:self.bounds.size] forState:UIControlStateNormal];
}

- (UIColor *)backgroundColorForDisabled{
    return nil;
    
}

- (void)setBackgroundColorForDisabled:(UIColor *)backgroundColorForDisabled{
    [self setBackgroundImage:[UIImage imageFormColor:backgroundColorForDisabled size:self.bounds.size] forState:UIControlStateDisabled];
}

- (UIColor *)backgroundColorForSelected{
    return nil;
}

- (void)setBackgroundColorForSelected:(UIColor *)backgroundColorForSelected{
    [self setBackgroundImage:[UIImage imageFormColor:backgroundColorForSelected size:self.bounds.size] forState:UIControlStateSelected];
}

- (UIColor *)backgroundColorForHighlighted{
    return nil;
}
- (void)setBackgroundColorForHighlighted:(UIColor *)backgroundColorForHighlighted{
    [self setImage:[UIImage imageFormColor:backgroundColorForHighlighted size:self.bounds.size] forState:UIControlStateHighlighted];
}



@end
