//
//  SEEDCollectionSectionItem.m
//  1haiiPhone
//
//  Created by GanXiaoteng on 2020/1/15.
//  Copyright © 2020 EHi. All rights reserved.
//

#import "SEEDCollectionSectionItem.h"

@implementation SEEDCollectionSectionItem
- (instancetype)init {
    if (self = [super init]) {
        [self setUP];
    }
    return self;
}

- (void)setUP {
    /// section的内边距
    self.sectionInset = UIEdgeInsetsZero;

    /// section的列数（一行cell个数）
    self.columnCount = 1;

    /// section的列之间的间距
    self.columnSpacing = 0;
     
    /// 同列之间间距 垂直方向
    self.lineSpacing = 0;

    /// section的header高
    self.headerHeight = 0;

    /// section的headerEdge
    self.headerInset = UIEdgeInsetsZero;

    /// section的footer高
    self.footerHeight = 0;

    /// section的footerEdge
    self.footerInset = UIEdgeInsetsZero;

    /// section的BgColor
    self.sectionBgColor = [UIColor whiteColor];
    
    /// cell集合
    self.cellItems = [NSMutableArray array];;
}
@end
