//
//  EHICalendarView.m
//  LBDemo
//
//  Created by 李兵 on 2020/3/9.
//  Copyright © 2020 ivan. All rights reserved.
//

#import "EHICalendarView.h"
#import "EHICalendarFlowLayout.h"
#import "EHICalendarDayViewModel.h"
#import "EHICalendarDayCellViewModel.h"
#import "EHICalendarCollecitionCell.h"

@interface EHICalendarView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collecitonView;

@property (nonatomic, strong) EHICalendarDayViewModel *viewModel;

@property (nonatomic, strong) NSArray<NSArray<EHICalendarDayCellViewModel *> *> *dataSource;

@end

@implementation EHICalendarView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
        
        EHiWeakSelf(self)
        self.viewModel.refreshUIBlock = ^(NSArray<NSArray<EHICalendarDayCellViewModel *> *> * _Nonnull dataSource) {
            EHiStrongSelf(self)
            self.dataSource = dataSource;
            [self.collecitonView reloadData];
        };
        [self.viewModel getData];
    }
    return self;
}

- (void)setupSubViews {
    [self addSubview:self.collecitonView];
    [self layoutViews];
}

- (void)layoutViews {
    [_collecitonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

#pragma mark - public

#pragma mark - Action

#pragma mark - private

#pragma mark - delgate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataSource.count > section) {
        NSArray<EHICalendarDayCellViewModel *> *items = self.dataSource[section];
        return items.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 准备数据
    NSArray<EHICalendarDayCellViewModel *> *cellViewModels  = [NSMutableArray array];
    if (self.dataSource.count > indexPath.section) {
       cellViewModels = self.dataSource[indexPath.section];
    }
    EHICalendarDayCellViewModel *cellViewModel = nil;
    if (cellViewModels.count > indexPath.row) {
       cellViewModel = cellViewModels[indexPath.row];
    }
    
    // 取view对象
    NSString *identifier = cellViewModel? cellViewModel.reuseIdentifier : [EHICalendarCollecitionCell reuseIdentifier];
    EHICalendarCollecitionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    // 渲染
    if (cellViewModels.count > indexPath.row) {
       cell.viewModel = cellViewModels[indexPath.row];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 准备数据
      NSArray<EHICalendarDayCellViewModel *> *cellViewModels  = [NSMutableArray array];
      if (self.dataSource.count > indexPath.section) {
         cellViewModels = self.dataSource[indexPath.section];
      }
      EHICalendarDayCellViewModel *cellViewModel = nil;
      if (cellViewModels.count > indexPath.row) {
         cellViewModel = cellViewModels[indexPath.row];
      }
    
    return cellViewModel.itemSize;
    
}

#pragma mark - Getter && Setter
- (UICollectionView *)collecitonView {
    if (!_collecitonView) {
        EHICalendarFlowLayout *flowLayout = [[EHICalendarFlowLayout alloc] init];
        _collecitonView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collecitonView.backgroundColor = [UIColor whiteColor];
        _collecitonView.delegate = self;
        _collecitonView.dataSource = self;
        _collecitonView.showsVerticalScrollIndicator = NO;
        _collecitonView.showsHorizontalScrollIndicator = NO;
        
        [_collecitonView registerClass:[EHICalendarCollecitionCell class] forCellWithReuseIdentifier:EHICalendarCollecitionCell.reuseIdentifier];
    }
    return _collecitonView;
}

- (EHICalendarDayViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel  = [[EHICalendarDayViewModel alloc] init];
    }
    return _viewModel;
}

@end
