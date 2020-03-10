//
//  SEEDCollectionView.m
//  1haiiPhone
//
//  Created by GanXiaoteng on 2020/1/15.
//  Copyright © 2020 EHi. All rights reserved.
//

#import "SEEDCollectionView.h"
#import "SEEDCollectionViewLayout.h"
#import "SEEDCollectionSectionItem.h"
#import "SEEDCollectionCellProtocol.h"

@interface SEEDCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableSet *reuseIdentifierSet;
 
@end

@implementation SEEDCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    SEEDCollectionViewLayout *layout = [[SEEDCollectionViewLayout alloc] init];
    self = [self initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.proxy.impDelegate = self;
        self.delegate = (id<UICollectionViewDelegate>)self.proxy;
        self.dataSource = (id<UICollectionViewDataSource>)self.proxy;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (CGRect)collectionCellIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes * att = [self layoutAttributesForItemAtIndexPath:indexPath];
    CGRect cellRect = att.frame;
    return cellRect; 
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    SEEDCollectionSectionItem *sectionItem = self.items[section];
    return sectionItem.cellItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SEEDCollectionSectionItem *sectionItem = self.items[indexPath.section];
    NSObject<SEEDCollectionCellItemProtocol> *cellItem = sectionItem.cellItems[indexPath.row];
    Class cellClass = cellItem.seed_CellClass;
    NSString *identifier = NSStringFromClass(cellClass);
    if (![self.reuseIdentifierSet containsObject:cellClass]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:identifier ofType:@"nib"];
        if (path) {
            [self registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellWithReuseIdentifier:identifier];
        } else {
            [self registerClass:cellClass forCellWithReuseIdentifier:identifier];
        }
        [self.reuseIdentifierSet addObject:cellClass];
    }
    UICollectionViewCell <SEEDCollectionCellProtocol> *cell = [self dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(seed_cellWithData:)]) {
        [cell seed_cellWithData:cellItem];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.items.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray <SEEDCollectionSectionItem *> *items = self.items;
    SEEDCollectionSectionItem *sectionItem = [items objectAtIndex:indexPath.section];
    NSMutableArray <NSObject<SEEDCollectionCellItemProtocol> *> *cellItems =  sectionItem.cellItems;
    NSObject<SEEDCollectionCellItemProtocol> *object = [cellItems objectAtIndex:indexPath.row];
    CGSize itemSize = object.seed_cellSize;
    return itemSize;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   NSMutableArray <SEEDCollectionSectionItem *> *items = self.items;
   SEEDCollectionSectionItem *sectionItem = [items objectAtIndex:indexPath.section];
   NSMutableArray <NSObject<SEEDCollectionCellItemProtocol> *> *cellItems =  sectionItem.cellItems;
   NSObject<SEEDCollectionCellItemProtocol> *object = [cellItems objectAtIndex:indexPath.row];
  if (object.seed_didSelectActionBlock) {
        object.seed_didSelectActionBlock(object);
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (SEEDCollectionProxy *)proxy {
    if(!_proxy){
        _proxy = [SEEDCollectionProxy alloc];
    }
    return _proxy;
}

- (NSMutableSet *)reuseIdentifierSet {
    if (!_reuseIdentifierSet) {
        _reuseIdentifierSet = [NSMutableSet set];
    }
    return _reuseIdentifierSet;
}
@end
