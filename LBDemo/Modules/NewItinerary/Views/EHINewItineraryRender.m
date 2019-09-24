//
//  EHINewItineraryRender.m
//  LBDemo
//
//  Created by 李兵 on 2019/9/20.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "EHINewItineraryRender.h"

@implementation EHINewItineraryRender

+ (UIImage *)getImageWithColor:(UIColor *)backGroundColor contentColor:(UIColor *)contentColor imageSize:(CGSize)imageSize contentSize:(CGSize)contentSize {
    //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
    //2.获得上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 外圆
    CGMutablePathRef outPath = [EHINewItineraryRender createCyclePahtWithSize:imageSize];
    CGContextAddPath(context, outPath);
    

    if (backGroundColor) {
        CGContextSetFillColorWithColor(context, backGroundColor.CGColor);
    }
    CGContextSetLineWidth(context, 1);
    CGContextDrawPath(context,kCGPathFill);
    
    // 内圆
    if (contentColor) {
        CGMutablePathRef innerPath = [EHINewItineraryRender createCyclePahtWithSize:contentSize bgSize:imageSize];
        CGContextAddPath(context, innerPath);
        if (contentColor) {
            CGContextSetFillColorWithColor(context, contentColor.CGColor);
        }
        CGContextSetLineWidth(context, 1);
        
        CGContextDrawPath(context,kCGPathFill);
    }
    
   
    
    //4.裁剪
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //5. 关闭上下文
    UIGraphicsEndImageContext();
    
    free(outPath);
    
    return image;
    
}

/** 创建背景圆 */
+ (CGMutablePathRef)createCyclePahtWithSize:(CGSize)size {
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat centerX = size.width / 2.0;
    CGFloat centerY = size.width / 2.0;
    CGFloat cornerRadius = size.width / 2.0;
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(centerX, centerY);
    CGPathAddArc(path, &transform, 0, 0, cornerRadius, 0, 2 * M_PI, NO);
    return path;
}

/** 创建内部圆 */
+ (CGMutablePathRef)createCyclePahtWithSize:(CGSize)size bgSize:(CGSize)bgSize {
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat centerX = bgSize.width / 2.0;
    CGFloat centerY = bgSize.width / 2.0;
    CGFloat cornerRadius = size.width / 2.0;
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(centerX, centerY);
    CGPathAddArc(path, &transform, 0, 0, cornerRadius, 0, 2 * M_PI, NO);
    return path;
}
@end
