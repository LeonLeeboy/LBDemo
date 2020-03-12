//
//  EHICalendarSectinonViewModel.h
//  LBDemo
//
//  Created by 李兵 on 2020/3/10.
//  Copyright © 2020 ivan. All rights reserved.
//

#import "SEEDCollectionSectionItem.h"

@class EHICalendarDayModel;
NS_ASSUME_NONNULL_BEGIN

@interface EHICalendarSectinonViewModel : SEEDCollectionSectionItem

/** 传入每个月的天数模型 */
- (void)updateWithModel:(NSArray<EHICalendarDayModel *> *)models;

@end

NS_ASSUME_NONNULL_END
