//
//  SEEDCollectionCellItemProtocol.h
//  1haiiPhone
//
//  Created by GanXiaoteng on 2020/1/15.
//  Copyright © 2020 EHi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SEEDCollectionCellItemProtocol <NSObject>

@required
/// 需要自己计算的cellSize
@property (nonatomic, assign) CGSize seed_cellSize;


///  在SEEDCollectionViewLayout计算得到
@property (nonatomic, assign) NSIndexPath *seed_indexPath;

///  刷新回调
@property (nonatomic, copy) SelectedCallBack seed_refreshBlock;

///  刷新回调
@property (nonatomic, copy) SelectedCallBack seed_didSelectActionBlock;

/// 对应cell的类
- (Class )seed_CellClass;
 
@optional
 

/// 设置圆弧度
/// @param corners 弧度的位置
/// @param radius 度数
- (void)setCcorners:(UIRectCorner)corners withRadius:(NSInteger)radius ;
@end

NS_ASSUME_NONNULL_END
