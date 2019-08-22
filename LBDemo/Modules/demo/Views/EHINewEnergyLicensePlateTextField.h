//
//  EHINewEnergyLicensePlateTextField.h
//  LBDemo
//
//  Created by 李兵 on 2019/8/19.
//  Copyright © 2019 ivan. All rights reserved.
//
//  绿色能量汽车输入框
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EHINewEnergyLicensePlateTextField : UIView

@property (nonatomic, strong) UIView *inputView;

@property (nonatomic, strong, readonly) NSString *carInfo;

/** 成为第一响应者 */
- (void)licensePlateBecomeFirstResponder;

- (void)licensePlateResignFirstResponder;

@end

NS_ASSUME_NONNULL_END
