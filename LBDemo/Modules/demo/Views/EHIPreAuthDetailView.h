//
//  EHIPreAuthDetailView.h
//  LBDemo
//
//  Created by 李兵 on 2019/7/23.
//  Copyright © 2019 EHi. All rights reserved.
//
//  嗨享车，确认还车页面中违章押金的显示样式
//

#import <UIKit/UIKit.h>

@class EHIOnlinePreAuthModel;

typedef NS_ENUM(NSInteger, EHIPreAuthFreezeStatus) {
    EHIPreAuthFreezeStatusUnauthorized,  // 未授权
    EHIPreAuthFreezeStatusAuthorized,    // 已授权
    EHIPreAuthFreezeStatusNoPermission,  // 不允许开通
};

NS_ASSUME_NONNULL_BEGIN

@interface EHIPreAuthDetailModel : NSObject

/** 提示文字 */
@property (nonatomic, copy) NSString *PreAuthFreezeTip;

/** 状态 */
@property (nonatomic , assign) EHIPreAuthFreezeStatus PreAuthFreezeStatus;

/** 修改订单时候的提示 */
@property (nonatomic, copy) NSString *ModifyPrompt;

@property (nonatomic, copy) NSString *PreAuthExplanation;

@property (nonatomic, copy) NSString *PreAuthTip;

@property (nonatomic, assign) BOOL haveDone;

@end

#pragma mark -

@interface EHIPreAuthDetailView : UIView

@property (nonatomic, strong, readonly) EHIOnlinePreAuthModel *renderModel;

/** 点击线上预授权回调事件 */
@property (nonatomic, copy) SelectedCallBack didClick;

- (void)renderViewWithModel:(EHIOnlinePreAuthModel *)renderModel;

@end

NS_ASSUME_NONNULL_END
