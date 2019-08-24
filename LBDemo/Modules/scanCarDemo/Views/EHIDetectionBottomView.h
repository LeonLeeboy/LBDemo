//
//  EHIDetectionBottomView.h
//  LBDemo
//
//  Created by 李兵 on 2019/8/23.
//  Copyright © 2019 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHIDetecctionItemView.h"

NS_ASSUME_NONNULL_BEGIN

@interface EHIDetectionBottomView : UIView

@property (nonatomic, assign) NSNumber *haveError;

@property (nonatomic, strong, readonly) NSArray<EHIDetecctionItemModel *> *itemModels;

@property (nonatomic, strong, readonly) NSArray<EHIDetecctionItemView *> *itemViews;

@property (nonatomic, copy) EHIOperationBlock didFinishedBock;

- (void)renderViewWithModels:(NSArray *)itemModels;

- (void)startCheck;

@end

NS_ASSUME_NONNULL_END
