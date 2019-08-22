//
//  EHiMemberShipRightsView.h
//  LBDemo
//
//  Created by 李兵 on 2019/8/9.
//  Copyright © 2019 ivan. All rights reserved.
//
//  会员权益底部view
//

#import <UIKit/UIKit.h>

@class EHiMemberShipRightsModel;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 

@interface EHiMemberShipRightsView : UIView

/** 回传参数类型：EHiMemberShipRightsItemModel  */
@property (nonatomic, copy) SelectedCallBack didClick;

@property (nonatomic, strong, readonly) EHiMemberShipRightsModel *renderModel;

- (void)renderViewWithModel:(EHiMemberShipRightsModel *)model;

@end

NS_ASSUME_NONNULL_END
