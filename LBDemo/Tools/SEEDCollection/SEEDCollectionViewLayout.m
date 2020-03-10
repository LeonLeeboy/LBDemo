//
//  SEEDCollectionViewLayout.m
//  1haiiPhone
//
//  Created by GanXiaoteng on 2020/1/15.
//  Copyright © 2020 EHi. All rights reserved.
//

#import "SEEDCollectionViewLayout.h"
#import "SEEDCollectionViewLayoutDelegate.h"
#import "SEEDCollectionViewLayoutDataSourse.h"
#import "tgmath.h"
#import "SEEDCollectionViewLayoutAttributes.h"
#import "SEEDCollectionSectionItem.h"
#import "SEEDCollectionView.h"
#import "SEEDCollectionReusableView.h"

#define SEEDDecorationReuseIdentifier @"SEEDDecorationReuseIdentifier"
@interface SEEDCollectionViewLayout ()
@property (nonatomic, weak) id <SEEDCollectionViewLayoutDelegate> delegate;
/// Array to store height for each column
@property (nonatomic, strong) NSMutableArray *columnHeights;

///  二维数组 section对应item的布局有关的属性的数组
@property (nonatomic, strong) NSMutableArray *sectionItemAttributes;

/// section的布局有关的属性的数组
@property (nonatomic, strong) NSMutableArray *sectionAttributes;

/// item的布局有关的属性的数组
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *allItemAttributes;

/// Sections数组
@property (nonatomic, strong, nonnull) NSMutableArray <SEEDCollectionSectionItem *> *items;

@end

@implementation SEEDCollectionViewLayout
 
static CGFloat SEEDFloorCGFloat(CGFloat value) {
    return floor(value);
}

#pragma mark - Public Accessors



#pragma mark - set/get
- (NSMutableArray *)columnHeights {
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (NSMutableArray *)allItemAttributes {
    if (!_allItemAttributes) {
        _allItemAttributes = [NSMutableArray  array];
    }
    return _allItemAttributes;
}

- (NSMutableArray *)sectionItemAttributes {
    if (!_sectionItemAttributes) {
        _sectionItemAttributes = [NSMutableArray array];
    }
    return _sectionItemAttributes;
}

- (NSMutableArray *)sectionAttributes {
    if (!_sectionAttributes) {
        _sectionAttributes = [NSMutableArray array];
    }
    return _sectionAttributes;
}


- (id <SEEDCollectionViewLayoutDelegate> )delegate {
    return (id <SEEDCollectionViewLayoutDelegate> )self.collectionView.delegate;
}

#pragma mark - Init
- (void)commonInit {
}

- (id)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

#pragma mark - Methods to Override

/// 设置layout的结构和初始需要的参数等。
- (void)prepareLayout {
    [super prepareLayout];
    [self registerClass:[SEEDCollectionReusableView class] forDecorationViewOfKind:SEEDDecorationReuseIdentifier];
    [self.columnHeights removeAllObjects];
    [self.allItemAttributes removeAllObjects];
    [self.sectionItemAttributes removeAllObjects];
    [self.sectionAttributes removeAllObjects];
    
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    if (numberOfSections == 0) {
        return;
    }
    
    NSInteger idx = 0;
    
    for (NSInteger section = 0; section < numberOfSections; section++) {
        NSMutableArray <SEEDCollectionSectionItem *> *items = ((SEEDCollectionView *)self.collectionView).items;
        SEEDCollectionSectionItem *item = [items objectAtIndex:section];
        NSInteger columnCount = item.columnCount;
        
        
        NSMutableArray *sectionColumnHeights = [NSMutableArray arrayWithCapacity:columnCount];
        for (idx = 0; idx < columnCount; idx++) {
            [sectionColumnHeights addObject:@(0)];
        }
        [self.columnHeights addObject:sectionColumnHeights];
    }
    // Create attributes
    CGFloat top = 0;
    UICollectionViewLayoutAttributes *attributes;
    
    for (NSInteger section = 0; section < numberOfSections; ++section) {
        
        NSMutableArray <SEEDCollectionSectionItem *> *items = ((SEEDCollectionView *)self.collectionView).items;
        SEEDCollectionSectionItem *sectionItem = [items objectAtIndex:section];
        /*
         * 1. Get section-specific metrics (lineSpacing, sectionInset)
         */
        CGFloat lineSpacing = sectionItem.lineSpacing;
        
        CGFloat columnSpacing = sectionItem.columnSpacing;
        
        UIEdgeInsets sectionInset = sectionItem.sectionInset;
        
        NSInteger columnCount = sectionItem.columnCount;
        
        top += sectionInset.top;
        for (idx = 0; idx < columnCount; idx++) {
            self.columnHeights[section][idx] = @(top);
        }
        
        CGFloat width = self.collectionView.bounds.size.width - sectionInset.left - sectionInset.right;
        CGFloat itemWidth = SEEDFloorCGFloat((width - (columnCount - 1) * columnSpacing) / columnCount);
        
        
        /*
         * 3. Section items
         */
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        NSMutableArray *itemAttributes = [NSMutableArray arrayWithCapacity:itemCount];
        CGRect firstSize = CGRectZero;
        CGRect lastSize = CGRectZero;
        // Item will be put into shortest column.
        for (idx = 0; idx < itemCount; idx++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:section];
            NSMutableArray <SEEDCollectionSectionItem *> *items = ((SEEDCollectionView *)self.collectionView).items;
                   SEEDCollectionSectionItem *sectionItem = [items objectAtIndex:section];
            NSObject<SEEDCollectionCellItemProtocol> *item = [sectionItem.cellItems objectAtIndex:idx];
            item.seed_indexPath = indexPath;
            NSUInteger columnIndex = [self nextColumnIndexForItem:idx inSection:section];
            CGFloat xOffset = sectionInset.left + (itemWidth + columnSpacing) * columnIndex;
            CGFloat yOffset = [self.columnHeights[section][columnIndex] floatValue];
            CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
            CGFloat itemHeight = itemSize.height;
            itemWidth = itemSize.width;
            attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attributes.frame = CGRectMake(xOffset, yOffset, itemWidth, itemHeight);
            [itemAttributes addObject:attributes];
            [self.allItemAttributes addObject:attributes];
            self.columnHeights[section][columnIndex] = @(CGRectGetMaxY(attributes.frame) + lineSpacing);
            if (idx == 0) {
                firstSize = attributes.frame;
            }
            
            if (idx  == itemCount - 1) {
                lastSize = attributes.frame;
            }
        }
        
        [self.sectionItemAttributes addObject:itemAttributes];
        NSUInteger columnIndex = [self longestColumnIndexInSection:section];
        if (((NSArray *)self.columnHeights[section]).count > 0) {
            top = [self.columnHeights[section][columnIndex] floatValue] - lineSpacing + sectionInset.bottom;
        } else {
            top = 0;
        } 
        for (idx = 0; idx < columnCount; idx++) {
            self.columnHeights[section][idx] = @(top);
        }
        
        
        
        
        CGRect sectionFrame = CGRectUnion(firstSize, lastSize);
        sectionFrame.origin.x -= sectionItem.sectionInset.left;
        sectionFrame.origin.y -= sectionItem.sectionInset.top;
        sectionFrame.size.width = self.collectionView.frame.size.width;
        sectionFrame.size.height += sectionItem.sectionInset.top + sectionItem.sectionInset.bottom;
        SEEDCollectionViewLayoutAttributes *decorationAttributes =
              [SEEDCollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:SEEDDecorationReuseIdentifier
                                                                                  withIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
        decorationAttributes.frame = sectionFrame;
        decorationAttributes.zIndex = -1;
        decorationAttributes.sectionBgColor = sectionItem.sectionBgColor;
        
        [self.sectionAttributes addObject:decorationAttributes];
         
    }
    
}

/// 返回collectionView的内容的尺寸
- (CGSize)collectionViewContentSize {
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    if (numberOfSections == 0) {
        return CGSizeZero;
    }
    
    CGSize contentSize = self.collectionView.bounds.size;
    contentSize.height = MAX([[[_columnHeights lastObject] firstObject] floatValue], contentSize.height);
    
    return contentSize;
}

/// 返回对应于indexPath的位置的cell的布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path {
    if (path.section >= [self.sectionItemAttributes count]) {
        return nil;
    }
    if (path.item >= [self.sectionItemAttributes[path.section] count]) {
        return nil;
    }
    return (self.sectionItemAttributes[path.section])[path.item];
}

/// 返回对应于indexPath的位置的追加视图的布局属性，如果没有追加视图可不重载
- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attribute = nil;
    
    return attribute;
}

/// 返回rect中的所有的元素的布局属性
/// 返回的是包含UICollectionViewLayoutAttributes的NSArray
/// UICollectionViewLayoutAttributes可以是cell，追加视图或装饰视图的信息，通过不同的UICollectionViewLayoutAttributes初始化方法可以得到不同类型的UICollectionViewLayoutAttributes：
///1)layoutAttributesForCellWithIndexPath:
///2)layoutAttributesForSupplementaryViewOfKind:withIndexPath:
///3)layoutAttributesForDecorationViewOfKind:withIndexPath:

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if ([elementKind isEqualToString:SEEDDecorationReuseIdentifier]) {
        return [self.sectionAttributes objectAtIndex:indexPath.section];
    }
    return [super layoutAttributesForDecorationViewOfKind:elementKind atIndexPath:indexPath];
}



- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    for (UICollectionViewLayoutAttributes *attr in self.sectionAttributes) { 
        if (CGRectIntersectsRect(rect, attr.frame)) {
            [self.allItemAttributes addObject:attr];
        }
    }
    return self.allItemAttributes;
}


/// 当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息。
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    return NO;
}

#pragma mark - Private Methods

/// 查找 section中item的height最小的index
- (NSUInteger)shortestColumnIndexInSection:(NSInteger)section {
    __block NSUInteger index = 0;
    __block CGFloat shortestHeight = MAXFLOAT;
    
    [self.columnHeights[section] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat height = [obj floatValue];
        if (height < shortestHeight) {
            shortestHeight = height;
            index = idx;
        }
    }];
    
    return index;
}

/// 查找 section中item的height最大的index
- (NSUInteger)longestColumnIndexInSection:(NSInteger)section {
    __block NSUInteger index = 0;
    __block CGFloat longestHeight = 0;
    
    [self.columnHeights[section] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat height = [obj floatValue];
        if (height > longestHeight) {
            longestHeight = height;
            index = idx;
        }
    }];
    
    return index;
}

/// 返回下一列的索引
- (NSUInteger)nextColumnIndexForItem:(NSInteger)item inSection:(NSInteger)section {
    NSUInteger index = 0;
    NSInteger columnCount = 0;
    NSMutableArray <SEEDCollectionSectionItem *> *items = ((SEEDCollectionView *)self.collectionView).items;
    SEEDCollectionSectionItem *sectionItem = [items objectAtIndex:section];
    columnCount = sectionItem.columnCount;
    index = (item % columnCount);
    return index;
}

@end

