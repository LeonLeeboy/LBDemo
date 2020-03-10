//
//  SEEDCollectionViewLayoutDelegate.h
//  1haiiPhone
//
//  Created by GanXiaoteng on 2020/1/15.
//  Copyright © 2020 EHi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SEEDCollectionViewLayoutDelegate <UICollectionViewDelegate>

 @required
 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
  
 @end

NS_ASSUME_NONNULL_END
