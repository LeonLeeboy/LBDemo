//
//  EHINewItineraryCellContentView.h
//  LBDemo
//
//  Created by 李兵 on 2019/9/19.
//  Copyright © 2019 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EHINewItineraryCellContentModel;

NS_ASSUME_NONNULL_BEGIN

@interface EHINewItineraryCellContentView : UIView


- (void)renderViewWithModel:(EHINewItineraryCellContentModel *)contentModel;

@end

NS_ASSUME_NONNULL_END
