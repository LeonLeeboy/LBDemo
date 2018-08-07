//
//  UIButton+IBAppearance.h
//  demo
//
//  Created by ivan on 2018/7/23.
//  Copyright © 2018年 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (IBAppearance)

@property (nonatomic , weak) IBInspectable UIColor *backgroundColorForNormal;

@property (nonatomic , weak) IBInspectable UIColor *backgroundColorForSelected;

@property (nonatomic , weak) IBInspectable UIColor *backgroundColorForHighlighted;

@property (nonatomic , weak) IBInspectable UIColor *backgroundColorForDisabled;

@end
