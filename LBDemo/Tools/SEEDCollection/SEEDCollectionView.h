//
//  SEEDCollectionView.h
//  1haiiPhone
//
//  Created by GanXiaoteng on 2020/1/15.
//  Copyright © 2020 EHi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SEEDCollectionViewLayoutDelegate.h"
#import "SEEDCollectionProxy.h"

@class SEEDCollectionSectionItem,SEEDCollectionProxy;
NS_ASSUME_NONNULL_BEGIN

@interface SEEDCollectionView : UICollectionView<SEEDCollectionViewLayoutDelegate>

@property (nonatomic, strong) SEEDCollectionProxy *proxy;
/// Sections数组
@property (nonatomic, strong) NSMutableArray <SEEDCollectionSectionItem *> *items;


/// 返回指定indexPath在collectionView中的位置
- (CGRect)collectionCellIndexPath:(NSIndexPath *)indexPath ;
@end

NS_ASSUME_NONNULL_END
