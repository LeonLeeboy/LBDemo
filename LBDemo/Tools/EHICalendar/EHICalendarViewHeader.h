//
//  EHICalendarViewHeader.h
//  LBDemo
//
//  Created by 李兵 on 2020/3/6.
//  Copyright © 2020 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EHICalendarViewHeader : UICollectionReusableView

/**
 *  Label that display the month and year
 */
@property (nonatomic, strong) UILabel *titleLabel;

/** @name Customizing Appearance */

/**
 *  Customize the Month text color display.
 */
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;

/**
 *  Customize the Month text font.
 */
@property (nonatomic, strong) UIFont *textFont UI_APPEARANCE_SELECTOR;

/**
 *  Customize the separator color between the month name and the dates.
 */
@property (nonatomic, strong) UIColor *separatorColor UI_APPEARANCE_SELECTOR;

@end

NS_ASSUME_NONNULL_END
