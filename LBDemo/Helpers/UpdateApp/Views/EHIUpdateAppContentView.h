//
//  EHIUpdateAppContentView.h
//  LBDemo
//
//  Created by 李兵 on 2019/9/12.
//  Copyright © 2019 ivan. All rights reserved.
//
// 更新APP 中间的View
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,EHIUpdateAppWay) {
    EHIUpdateAppWayForce,   //> 强制更新
    EHIUpdateAppWayNoForce  //> 非强制更新
};

NS_ASSUME_NONNULL_BEGIN

@interface EHIUpdateAppContentView : UIView

@property (nonatomic, copy) void(^nextTimeAction)(void);

@property (nonatomic, copy) void(^updateNowAction)(void);


- (instancetype)initWithUpdateWay:(EHIUpdateAppWay)updateWay;

- (void)renderViewWithTips:(NSArray<NSString *> *)tips;

@end

NS_ASSUME_NONNULL_END
