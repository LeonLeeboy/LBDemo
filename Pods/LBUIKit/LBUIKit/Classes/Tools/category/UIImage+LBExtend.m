//
//  UIImage+LBExtend.m
//  demo
//
//  Created by ivan on 2018/7/24.
//  Copyright © 2018年 ivan. All rights reserved.
//

#import "UIImage+LBExtend.h"

@implementation UIImage (LBExtend)

+ (UIImage *)imageFormColor:(UIColor *)color size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [color setFill];
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
    [path fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
