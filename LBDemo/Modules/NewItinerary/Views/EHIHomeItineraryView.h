//
//  EHIHomeItineraryView.h
//  LBDemo
//
//  Created by 李兵 on 2019/9/18.
//  Copyright © 2019 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EHIHomeItineraryView : UIView

/** 点击“更多行程” */
@property (nonatomic, copy) void(^moreItineraryClickAction)(void);

/** 点击 行程区域 */
@property (nonatomic, copy) void(^clickCurrentItineraryAction)(void);

- (void)renderViewWithContent:(id)parameters;

@end

NS_ASSUME_NONNULL_END
