//
//  EHINewItineraryRender.h
//  LBDemo
//
//  Created by 李兵 on 2019/9/20.
//  Copyright © 2019 ivan. All rights reserved.
//
//  我的行程渲染类
//

#import <Foundation/Foundation.h>



@interface EHINewItineraryRender : NSObject


/**
创建一个圆形图片

 @param backGroundColor 背景颜色
 @param contentColor 内部的颜色
 @param imageSize 自身的大小
 @param contentSize 图片内部的大小
 @return 一张图片
 */
+ (UIImage *)getImageWithColor:(UIColor *)backGroundColor contentColor:(UIColor *)contentColor imageSize:(CGSize)imageSize contentSize:(CGSize)contentSize;

@end

