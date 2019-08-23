//
//  EHIDetecctionItemView.h
//  LBDemo
//
//  Created by 李兵 on 2019/8/23.
//  Copyright © 2019 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EHIDetectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EHIDetecctionItemView : UIView

/** 动画完成后回调 */
@property (nonatomic, copy)EHIOperationBlock  didFinishedAnimationBlcok;


/** 渲染model */
@property (nonatomic, strong, readonly) EHIDetecctionItemModel *renderModel;

- (void)renderViewWithModel:(EHIDetecctionItemModel *)model;

- (void)startAnimation;
@end

NS_ASSUME_NONNULL_END
