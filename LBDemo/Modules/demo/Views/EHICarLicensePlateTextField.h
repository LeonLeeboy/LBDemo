//
//  EHICarLicensePlateTextField.h
//  LBDemo
//
//  Created by Bean lee on 2019/8/18.
//  Copyright © 2019 ivan. All rights reserved.
//
//  手动输入车牌页面
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EHICarLicensePlateTextFieldItemModel : NSObject

@property (nonatomic, assign, getter=isSelected) BOOL selected;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) UIColor *normalBorderColor;

@property (nonatomic, strong) UIColor *selectedBorderColor;

@property (nonatomic, strong) UIColor *normalBackGroundColor;

@property (nonatomic, strong) UIColor *selectedBackGroundColor;

@property (nonatomic, strong) UIColor *normalTextColor;

@property (nonatomic, strong) UIColor *selectedTextColor;

@property (nonatomic, assign) BOOL newEnergy;
@end

#pragma mark -

@interface EHICarLicensePlateTextField : UIView

@property (nonatomic, strong, readonly) NSArray<EHICarLicensePlateTextFieldItemModel *> *itemModels;

@property (nonatomic, strong) UIView *inputView;

@property (nonatomic, strong, readonly) NSString *carInfo;

/** 成为第一响应者 */
- (void)licensePlateBecomeFirstResponder;

- (void)renderViewWithItemModels:(NSArray<EHICarLicensePlateTextFieldItemModel *> *)items;

@end

NS_ASSUME_NONNULL_END
