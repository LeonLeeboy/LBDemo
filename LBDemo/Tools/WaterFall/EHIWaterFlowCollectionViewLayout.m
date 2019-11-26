//
//  EHIWaterFlowCollectionViewLayout.m
//  LBCollectionViewLayout
//
//  Created by ivan on 2018/1/23.
//

#import "EHIWaterFlowCollectionViewLayout.h"

@interface EHIWaterFlowCollectionViewLayout ()
@property (nonatomic , assign) NSUInteger Colcount;
@property (strong , nonatomic) NSMutableDictionary<NSString *,NSNumber * > *heightDic;
@property (strong , nonatomic) NSMutableArray *attributesArray;
@property (assign , nonatomic) CGFloat lineSpace;
@property (assign , nonatomic) CGFloat itemSpace;
@property (strong , nonatomic) NSCache <NSString *,UICollectionViewLayoutAttributes *>*cache;
@end

@implementation EHIWaterFlowCollectionViewLayout

#pragma mark - lifecycle
+ (instancetype)layoutWithColumnsNumbers:(NSUInteger)numbers lineSpace:(CGFloat)lineSpace itemSpace:(CGFloat)itemSpace{
    EHIWaterFlowCollectionViewLayout *layout = [[self alloc] init];
    layout.Colcount = numbers;
    layout.lineSpace = lineSpace;
    layout.itemSpace = itemSpace;
    return  layout;
}


- (void)prepareLayout{
    [super prepareLayout];
    [self prepare];
}

- (CGSize)collectionViewContentSize{
    CGSize contentSize = CGSizeZero;
    contentSize =  CGSizeMake(self.collectionView.frame.size.width, [self getMaxHeight]);
    return contentSize;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return self.attributesArray;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self collectionViewlayoutAttributesWithIndexPath:indexPath];
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

#pragma mark - private
- (void)prepare {
    //data , 初始化记录
    for (int i = 0; i < _Colcount; i++) {
        [self.heightDic setObject:[NSNumber numberWithFloat:0.0] forKey:[self indexToKey:i]];
    }
    // attributes
    NSInteger count = [self itemsCount];
    [self.attributesArray removeAllObjects];
    for (int i =0 ; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attributes =  [self collectionViewlayoutAttributesWithIndexPath:indexPath];
        [self.attributesArray addObject:attributes];
    }
}

- (UICollectionViewLayoutAttributes *)collectionViewlayoutAttributesWithIndexPath:(NSIndexPath *)indexPath{
    NSString *keyStr = [self indexToKey:indexPath.row];
    UICollectionViewLayoutAttributes *attributes;
    
    CGFloat y = [self getMinHeight] + self.itemSpace;
    NSUInteger index = [self getMinHeightIndex];

    if ([self.cache objectForKey:keyStr] == nil) {
        attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.size = [self sizeFromIndexPath:indexPath];
        CGFloat x = ([self getItemWidth] + self.lineSpace) * index;
        attributes.frame = CGRectMake(x, y, [self getItemWidth], [self getItemHeightFromIndexPath:indexPath]);
        self.heightDic[[self indexToKey:index]] = [NSNumber numberWithFloat:y + [self getItemHeightFromIndexPath:indexPath]];
        [self.cache setObject:attributes forKey:keyStr];
    }else{
        self.heightDic[[self indexToKey:index]] = [NSNumber numberWithFloat:y + [self getItemHeightFromIndexPath:indexPath]];
        attributes = [self.cache objectForKey:keyStr];
    }
    
    return attributes;
}

/** 多少个item */
- (NSUInteger)itemsCount{
    return [self.collectionView numberOfItemsInSection:0];
}

/** 获得item 的size */
- (CGSize)sizeFromIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeZero;
    CGFloat w = [self getItemWidth];
    CGFloat h =  [self getItemHeightFromIndexPath:indexPath];
    size = CGSizeMake(w, h);
    return size;
}

- (CGFloat)getItemWidth{
    return  (self.collectionView.frame.size.width - (self.lineSpace * (self.Colcount - 1))) / self.Colcount;
}

- (CGFloat)getItemHeightFromIndexPath:(NSIndexPath *)indexPath{
    CGFloat h = 0;
    if ([self.delegate respondsToSelector:@selector(itemHeightAtIndexPath:)]) {
        h = [self.delegate itemHeightAtIndexPath:indexPath];
    }else{
        h = 100;
    }
    return h;
}

# pragma mark - 获得最短的长度
- (CGFloat)getMinHeight{
    __block CGFloat minHeight = CGFLOAT_MAX;
    [self.heightDic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
        CGFloat height = [obj floatValue];
        if (height < minHeight) {
            minHeight = height;
        }
    }];
    return minHeight;
}
# pragma mark - 获得最长的长度
- (CGFloat)getMaxHeight{
    __block CGFloat maxHeight = 0;
    [self.heightDic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
        CGFloat height = [obj floatValue];
        if (height > maxHeight) {
            maxHeight = height;
        }
    }];
    return maxHeight;
}
# pragma mark - 获得最短的列的索引
- (NSUInteger)getMinHeightIndex{
    __block NSUInteger index = 0;
    __block CGFloat minHeight = CGFLOAT_MAX;
    [self.heightDic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
        CGFloat height = [obj floatValue];
        if (height < minHeight) {
            minHeight = height;
            index = [self keyToIndex:key];
        }
    }];
    return index;
}

#pragma mark - key 转 index
- (NSInteger)keyToIndex:(NSString *)keyString{
    NSString *indexStr = [keyString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return [indexStr integerValue];
}
#pragma mark - index 转 key
- (NSString *)indexToKey:(NSUInteger)index{
    NSString *keyString = [NSString stringWithFormat:@"--%lu--",(unsigned long)index];
    return keyString;
}

#pragma mark - Getter && setter
- (NSMutableDictionary<NSString *,NSNumber *> *)heightDic{
    if (_heightDic == nil) {
        _heightDic = [NSMutableDictionary dictionary];
    }
    return _heightDic;
}
- (NSCache <NSString *,UICollectionViewLayoutAttributes *>*)cache{
    if (_cache == nil) {
        _cache = [[NSCache alloc] init];
    }
    return _cache;
}


- (NSMutableArray *)attributesArray{
    if (_attributesArray == nil) {
        _attributesArray = [NSMutableArray array];
    }
    return _attributesArray;
}

- (void)setLineSpace:(CGFloat)lineSpace{
    if (_lineSpace == lineSpace) {
        return;
    }
    _lineSpace = lineSpace;
}

- (void)setItemSpace:(CGFloat)itemSpace{
    if (_itemSpace == itemSpace) {
        return;
    }
    _itemSpace = itemSpace;
}

@end
