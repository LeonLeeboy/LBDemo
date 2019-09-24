//
//  EHINewItineraryAddressListView.h
//  LBDemo
//
//  Created by 李兵 on 2019/9/20.
//  Copyright © 2019 ivan. All rights reserved.
//
//  我的行程 “开始地点，停靠点，结束地点 list”
//

#import <UIKit/UIKit.h>

/** label 距离远点左边的距离 */
static  CGFloat kInterItemSpace() {
    return autoWidthOf6(21);
}

/** label 和 圆点之间的距离 */
static  CGFloat kInterItemSpaceBetweenDotAndLabel() {
    return kInterItemSpace() - 5;
}


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,EHIAddressListVerticalLineStyle) {
    EHIAddressListVerticalLineStyleFull,   //!> 从上到下
    EHIAddressListVerticalLineStyleUp,     //!> 从原点向上
    EHIAddressListVerticalLineStyleDown    //!> 从原点向下
};

@interface EHINewItineraryAddressListItemView : UIView

- (void)renderViewWithIconImage:(UIImage *)iconImage
                 attributedText:(NSAttributedString *)attributedText
                      lineStyle:(EHIAddressListVerticalLineStyle)lineStyle;

- (void)renderViewWithIconImage:(UIImage *)iconImage
                 attributedText:(NSAttributedString *)attributedText
                      lineStyle:(EHIAddressListVerticalLineStyle)lineStyle
              verticalLineWidth:(CGFloat)verticalLineWidth;
@end

#pragma mark -

@interface EHINewItineraryAddressListView : UIView

/** 渲染方法 */
- (void)renderViewWithBeginAddressModel:(id)beginAddressModel
                        endAddressModel:(id)endAddressModel
                                  stops:(NSArray *)stops;

@end

NS_ASSUME_NONNULL_END
