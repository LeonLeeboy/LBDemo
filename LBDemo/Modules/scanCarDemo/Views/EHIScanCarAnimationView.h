//
//  EHIScanCarAnimationView.h
//  LBDemo
//
//  Created by 李兵 on 2019/8/23.
//  Copyright © 2019 ivan. All rights reserved.
//
//  嗨车检查车辆的状态汽车动画View
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EHIScanCarAnimationModel : NSObject

@property (nonatomic, strong) UIImage *normalBackGroundImage;

@property (nonatomic, strong) UIImage *highLightedBackGroundImage;

//扫描的图片
@property (nonatomic, strong) UIImage *scanLineImage;

@property (nonatomic, assign) CGFloat duration;

@end


@interface EHIScanCarAnimationView : UIView

- (void)starAnimation;

- (void)renderViewWithModel:(EHIScanCarAnimationModel *)model;

@end

NS_ASSUME_NONNULL_END
