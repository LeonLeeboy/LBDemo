//
//  EHIHiCarDetectionSingleView.h
//  1haiiPhone
//
//  Created by LuckyCat on 2018/12/13.
//  Copyright © 2018年 EHi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHIHiCarDetectionModel.h"

@interface EHIHiCarDetectionSingleView : UIView

/** 赋值 */
@property (nonatomic, copy) EHIHiCarDetectionDetailModel *detailModel;

/** 动画完成后回调 */
@property (nonatomic, copy) ActionBlock didFinishedAnimationBlcok;

/** 开始动画 */
- (void)startAnimation;

@end
