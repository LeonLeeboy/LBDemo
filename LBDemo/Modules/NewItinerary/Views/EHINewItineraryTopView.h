//
//  EHINewItineraryTopView.h
//  LBDemo
//
//  Created by 李兵 on 2019/9/20.
//  Copyright © 2019 ivan. All rights reserved.
//
//  我的行程 “专车-送机， 时间 || 自驾” 顶部view
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EHINewItineraryTopView : UIView

- (void)renderViewWithOrderTitle:(NSString *)orderTitle
                       getOnTime:(NSString *)getOntime
              getOnTimeLabHidden:(BOOL)getOnTimeLabHidden;

@end

NS_ASSUME_NONNULL_END
