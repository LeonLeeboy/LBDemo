//
//  EHICalendarHeaderCell.h
//  LBDemo
//
//  Created by 李兵 on 2020/3/10.
//  Copyright © 2020 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SEEDCollectionCellProtocol.h"

@class EHICalendarSectinonViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface EHICalendarHeaderCell : UICollectionViewCell<SEEDCollectionCellProtocol>

- (void)seed_cellWithData:(EHICalendarSectinonViewModel *)itemModel;

@end

NS_ASSUME_NONNULL_END
