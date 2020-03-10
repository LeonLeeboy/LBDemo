//
//  EHICalendarCollecitionCell.h
//  LBDemo
//
//  Created by 李兵 on 2020/3/9.
//  Copyright © 2020 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SEEDCollectionCellProtocol.h"

@class EHICalendarDayCellViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface EHICalendarCollecitionCell : UICollectionViewCell <SEEDCollectionCellProtocol>


@property (nonatomic, strong) EHICalendarDayCellViewModel *viewModel;


+ (NSString *)reuseIdentifier;


@end

NS_ASSUME_NONNULL_END
