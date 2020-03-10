//
//  SEEDCollectionSectionItem.h
//  1haiiPhone
//
//  Created by GanXiaoteng on 2020/1/15.
//  Copyright © 2020 EHi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SEEDCollectionCellItemProtocol.h" 

NS_ASSUME_NONNULL_BEGIN

@interface SEEDCollectionSectionItem : NSObject

/// section的内边距
@property (nonatomic, assign) UIEdgeInsets sectionInset;

/// section的列数（一行cell个数）
@property (nonatomic, assign) NSInteger columnCount;

/// section的列之间的间距
@property (nonatomic, assign) CGFloat columnSpacing;
 
/// 同列之间间距 垂直方向
@property (nonatomic, assign) CGFloat lineSpacing;

/// section的header高
@property (nonatomic, assign) CGFloat headerHeight;

/// section的headerEdge
@property (nonatomic, assign) UIEdgeInsets headerInset;

/// section的footer高
@property (nonatomic, assign) CGFloat footerHeight;

/// section的footerEdge
@property (nonatomic, assign) UIEdgeInsets footerInset;

/// section的BgColor
@property (nonatomic, strong) UIColor *sectionBgColor;

/// cell集合
@property (nonatomic, strong, nonnull) NSMutableArray <NSObject<SEEDCollectionCellItemProtocol> *> *cellItems;

@end

NS_ASSUME_NONNULL_END
