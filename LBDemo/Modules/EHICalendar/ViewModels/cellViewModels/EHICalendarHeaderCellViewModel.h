//
//  EHICalendarHeaderCellViewModel.h
//  LBDemo
//
//  Created by 李兵 on 2020/3/10.
//  Copyright © 2020 ivan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SEEDCollectionCellItemProtocol.h"
@class EHICalendarDayModel;

NS_ASSUME_NONNULL_BEGIN

@interface EHICalendarHeaderCellViewModel : NSObject<SEEDCollectionCellItemProtocol>

@property (nonatomic, strong) NSAttributedString *titleAttributed;

- (void)updateWith:(EHICalendarDayModel *)model edgeInset:(UIEdgeInsets)edges;

/// 对应cell的类
- (Class )seed_CellClass;

@end

NS_ASSUME_NONNULL_END
