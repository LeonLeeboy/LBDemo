//
//  SEEDSelecteView.m
//  1haiiPhone
//
//  Created by 李兵 on 2019/7/4.
//  Copyright © 2019 EHi. All rights reserved.
//

#import "SEEDSelecteView.h"

static CGFloat defalutCornerRadius = 2;
static CGFloat defaultIconWithAndHeight = 12;
static UIColor *selectedColor() {
    return kLBAPPHexColor_FF7E00;
};
static NSString *defalultIconName() {
    return @"seed_DefalultIconName";
};
static NSString *SelectedIconName() {
    return @"creditCardTypeSelected";
};
static UIColor *defaultColor() {
    return kLBAPPHexColor_CCCCCC;
};
static UIFont *defalultFont() {
    return autoFONT(15);
};

@implementation SEEDSelectedItemModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.displayText forKey:@"displayText"];
    [aCoder encodeInteger:self.itemID forKey:@"itemID"];
    [aCoder encodeCGSize:self.itemSize forKey:@"itemSize"];
    [aCoder encodeBool:self.selected forKey:@"selected"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self=[super init]) {
        self.displayText = [aDecoder decodeObjectForKey:@"displayText"];
        self.itemID = [aDecoder decodeIntegerForKey:@"itemID"];
        self.selected = [aDecoder decodeBoolForKey:@"selected"];
        self.itemSize = [aDecoder decodeCGSizeForKey:@"itemSize"];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    SEEDSelectedItemModel *result = [[[self class] allocWithZone:zone] init];
    result->_displayText = [self.displayText copy];
    result->_itemID = self.itemID;
    result->_itemSize = self.itemSize;
    result->_selected = self.selected;
    result->_selectedIconWidth = self.selectedIconWidth;
    result->_displayTextFont = self.displayTextFont;
    result->_defalutBorderColor = self.defalutBorderColor;
    result->_defaultTextColor = self.defaultTextColor;
    result->_selectedBorderColor = self.selectedBorderColor;
    result->_selectedTextColor = self.selectedTextColor;
    result->_cornerRadius = self.cornerRadius;
    return result;
}

@end

#pragma mark -

@implementation SEEDSelecteModel

#pragma mark getter
- (NSMutableArray<SEEDSelectedItemModel *> *)items {
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

@end

#pragma mark -
@class SEEDSelecteItemContent;

@interface  SEEDSelecteItemContent : UIControl

/** displayText */
@property (nonatomic, strong) UILabel *displayText;
@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong, readwrite) SEEDSelectedItemModel *model;

+ (instancetype)itemWithModel:(SEEDSelectedItemModel *)model;

- (void)renderViewWithModel:(SEEDSelectedItemModel *)model;
@end

@implementation SEEDSelecteItemContent

+ (instancetype)itemWithModel:(SEEDSelectedItemModel *)model{
    return [[self alloc] initWithModel:model frame:CGRectZero];
    
}

/** 核心初始化方法 */
- (instancetype)initWithModel:(SEEDSelectedItemModel *)model frame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_dealDataWithModel:model];
        [self p_setupViews];
    }
    return self;
}

- (void)renderViewWithModel:(SEEDSelectedItemModel *)model {
    self.model = model;
    self.displayText.text = model.displayText?:@"请初始化model的displayText";
    self.displayText.font = model.displayTextFont?:defalultFont();
    self.layer.cornerRadius = model.cornerRadius?:defalutCornerRadius;
    self.layer.masksToBounds = YES;
    self.selected = model.selected;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.displayText.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    switch (self.model.iconPosition) {
        case SEEDIconPositionRightAndBottom: {
             self.imgView.frame = CGRectMake(self.frame.size.width - self.model.selectedIconWidth?:defaultIconWithAndHeight, self.frame.size.height - self.model.selectedIconWidth?:defaultIconWithAndHeight, self.model.selectedIconWidth?:defaultIconWithAndHeight, self.model.selectedIconWidth?:defaultIconWithAndHeight);
        }
            break;
            
        default: {
            self.imgView.frame = CGRectMake(self.frame.size.width - self.model.selectedIconWidth?:defaultIconWithAndHeight, self.frame.size.height - self.model.selectedIconWidth?:defaultIconWithAndHeight, self.model.selectedIconWidth?:defaultIconWithAndHeight, self.model.selectedIconWidth?:defaultIconWithAndHeight);
        }
            break;
    }
}


#pragma mark private
- (void)p_dealDataWithModel:(SEEDSelectedItemModel *)model {
    if (!model) {
        model = [[SEEDSelectedItemModel alloc] init];
        model.displayText = @"请输入文字";
    }
    self.model = model;
}

- (void)p_setupViews {
    self.enabled = NO;
    self.layer.borderWidth = SINGLE_LINE_WIDTH;
    self.layer.cornerRadius = 2;
    self.layer.borderColor = defaultColor().CGColor;
    self.layer.masksToBounds = YES;
    self.displayText.textColor = defaultColor();
    
    [self addSubview:self.displayText];
    self.displayText.text = self.model.displayText;
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:defalultIconName()];
    [self addSubview:imgView];
    self.imgView = imgView;
}

#pragma mark Action
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.displayText.textColor = self.model.selectedTextColor?:selectedColor();
        self.layer.borderColor = self.model.selectedBorderColor.CGColor?:selectedColor().CGColor;
        self.imgView.image = [UIImage imageNamed:self.model.selectedIconName?:SelectedIconName()];
    }else {
        self.displayText.textColor = self.model.defaultTextColor?:defaultColor();
        self.layer.borderColor = self.model.defalutBorderColor.CGColor?:defaultColor().CGColor;
        self.imgView.image = [UIImage imageNamed:self.model.defalultIconName?:defalultIconName()];
    }
}

#pragma mark getter and setter

- (UILabel *)displayText {
    if (!_displayText) {
        _displayText  = [[UILabel alloc] init];
        _displayText.numberOfLines = 0;
        _displayText.backgroundColor = [UIColor clearColor];
        _displayText.textColor = kLBAPPHexColor_CCCCCC;
        _displayText.font = autoFONT(15);
        _displayText.textAlignment = NSTextAlignmentCenter;
        
    }
    return _displayText;
}

@end

#pragma mark -

@interface SEEDSelecteItemCell : UICollectionViewCell

@property (strong , nonatomic) SEEDSelecteItemContent *content;

- (void)renderViewWithModel:(SEEDSelectedItemModel *)model;


+ (NSString *)cellReuseIdentifier;

@end

@implementation SEEDSelecteItemCell

#pragma mark life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.content = [SEEDSelecteItemContent itemWithModel:nil];
    [self.contentView addSubview:_content];
}

- (void)renderViewWithModel:(SEEDSelectedItemModel *)model {
    [self.content renderViewWithModel:model];
}

- (void)layoutSubviews {
    self.content.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

#pragma mark public
+ (NSString *)cellReuseIdentifier {
    return NSStringFromClass(self.class);
}

@end

#pragma mark -

@interface CustomFlowLayout : UICollectionViewFlowLayout

@property (nonatomic) CGFloat InteritemSpacing;

@property (nonatomic) CGFloat lineSpace;

@end


@implementation CustomFlowLayout
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //使用系统帮我们计算好的结果。
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    UICollectionViewLayoutAttributes *preAttr;
    for(int i = 0; i < [attributes count]; ++i) {
        UICollectionViewLayoutAttributes *curAttr = attributes[i];
        if(i == 0) {
            preAttr = attributes[0];
            continue;
        }
        //不需要换行 x 位置
        NSInteger preX = CGRectGetMaxX(preAttr.frame);
        CGFloat targetX = preX + _InteritemSpacing;
        //需要换行的y
        NSInteger preY = CGRectGetMaxY(preAttr.frame);
        CGFloat targetY = preY + _lineSpace;
        // 换行时不用调整
        if (targetX + CGRectGetWidth(curAttr.frame) < self.collectionViewContentSize.width) { //不换行
            CGRect frame = curAttr.frame;
            frame.origin.x = targetX;
            frame.origin.y = CGRectGetMinY(preAttr.frame);
            curAttr.frame = frame;
        } else { // 换行
            CGRect frame = curAttr.frame;
            frame.origin.x = 0;
            frame.origin.y = targetY;
            curAttr.frame = frame;
        }
        preAttr = curAttr;
    }
    return attributes;
}
@end

#pragma mark -

@interface SEEDSelecteView ()<UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong, readwrite) SEEDSelecteModel       *renderModel;

/** 处理初始化完成后 + 刷新页面 + 点击后的回掉 */
@property (nonatomic, copy, readwrite) SEEDSelectViewDidClickhandler handlerBlock;

@property (nonatomic, strong, readwrite) UICollectionView       *listView;

@property (nonatomic, strong, readwrite) SEEDSelectedItemModel *currentSelectedModel;

@property (nonatomic, copy, readwrite) SEEDSelectViewRefreshBlock complementation;

@end

@implementation SEEDSelecteView

#pragma mark life Cycle
/** 核心初始化方法 */
- (instancetype)initWithFrame:(CGRect)frame model:(SEEDSelecteModel *)model{
    if (self = [super initWithFrame:frame]) {
        _renderModel = model;
        //预处理数据
        [self p_dealDataWithModel:model];
        //UI初始化
        [self setUpViews];
    }
    return self;
}

- (instancetype)initWithModel:(SEEDSelecteModel *)model {
    if (self  = [self initWithFrame:CGRectZero model:model]) {}
    return self;
}

- (instancetype)initWithModel:(SEEDSelecteModel *)model complementation:(SEEDSelectViewRefreshBlock)complementation {
    if (self  = [self initWithFrame:CGRectZero model:model]) {
        self.complementation = [complementation copy];
    }
    return self;
}

- (instancetype)initWithModel:(SEEDSelecteModel *)model Handler:(SEEDSelectViewDidSelecteBlock)handlerBlock {
    if (self  = [self initWithFrame:CGRectZero model:model]) {
        self.handlerBlock = [handlerBlock copy];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [self initWithFrame:frame model:nil]) {} return self;
}

- (void)didMoveToSuperview {
    SEEDSelectedItemModel *m = [self p_getSelectedModel];
    if (!m) {
        return;
    }
    // 暂存当前选中selectedmodel
    self.currentSelectedModel = m;
    if (self.complementation) {
        self.complementation(m);
    }
    
}

- (void)setUpViews {
    // flowLayout
    CustomFlowLayout* flowLayout = [[CustomFlowLayout alloc] init];
    flowLayout.InteritemSpacing = self.renderModel.interitemSpacing;
    flowLayout.lineSpace = self.renderModel.lineSpacing;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    // create list
    UICollectionView* listView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    listView.backgroundColor = self.backgroundColor;
    listView.showsHorizontalScrollIndicator = NO;
    listView.showsVerticalScrollIndicator = NO;
    listView.alwaysBounceVertical = NO;
    [listView registerClass:SEEDSelecteItemCell.class forCellWithReuseIdentifier:SEEDSelecteItemCell.cellReuseIdentifier];
    listView.delegate = self;
    listView.dataSource = self;
    
    listView.contentInset = self.renderModel.contentInset;
    [self addSubview:listView];
    [listView reloadData];
    listView.scrollEnabled = NO;
    self.listView = listView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.listView.frame = CGRectMake(0, 0, self.frame.size.width, self.renderModel.height?:self.frame.size.height);
}

#pragma mark Action
- (void)renderViewWithModel:(SEEDSelecteModel *)model {
    self.renderModel = model;
    [self.listView reloadData];
    SEEDSelectedItemModel *m = [self p_getSelectedModel];
    if (!m) {//为空返回
        return;
    }
    //暂存
    self.currentSelectedModel = m;
    
    if (self.refreshBlock) {
        self.refreshBlock(m);
    }
    
}

- (void)changeSeletedItemWithItemID:(NSInteger)itemID {
    // 找需被选中的model
    SEEDSelectedItemModel *m = [self p_getSeletedItemModelWithItemID:itemID];
    if (!m) {
        return;
    }
    // 取消所有的选中状态
    [self p_cancleAllItemSelected];
    // 设置为选中，这个操作直接修改了array里面的数组
    m.selected = YES;
    // 更新UI
    [self.listView reloadData];
}

#pragma mark private
- (void)p_dealDataWithModel:(SEEDSelecteModel *)model { //model预操作
    self.renderModel = model;
}

- (void)p_cancleAllItemSelected {
    for (SEEDSelectedItemModel *obj in self.renderModel.items) {
        obj.selected = NO;
    }
}

- (SEEDSelectedItemModel *)p_getSeletedItemModelWithItemID:(NSInteger)itemID {
    SEEDSelectedItemModel *m = nil;
    for (SEEDSelectedItemModel *temp in self.renderModel.items) {
        if (temp.itemID == itemID) {
            m = temp;
            break;
        }
    }
    return m;
}

/** 该选项是否需要选中 */
- (BOOL)p_isSelectedWithModel:(SEEDSelectedItemModel *)m {
    BOOL rst = YES;
    if (self.clickItemBlock) {
        rst = self.clickItemBlock(m);
    } else {
        rst = !m.selected;
    }
    return rst;
}

/** 返回第一个被选中的model */
- (SEEDSelectedItemModel *)p_getSelectedModel {
    SEEDSelectedItemModel *result = nil;
    for (SEEDSelectedItemModel *m in self.renderModel.items) {
        if (m.selected) {
            result = m;
            break;
        }
    }
    return result;
}

#pragma mark Delegate and dataSource
/** UIColleecrionViewDatasource */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.renderModel.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SEEDSelecteItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SEEDSelecteItemCell.cellReuseIdentifier forIndexPath:indexPath];
    if (self.renderModel.items.count > indexPath.row) {
        [cell renderViewWithModel:self.renderModel.items[indexPath.row]];
    }
    
    return cell;
}

/** UICollecrtionViewDeledate */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.renderModel.items.count <= indexPath.row) {
        return;
    }
    SEEDSelectedItemModel *m = self.renderModel.items[indexPath.row];
    if (self.renderModel.cancelable) { //可取消
        SEEDSelectedItemModel *tmp = [m copy];
        tmp.selected = [self p_isSelectedWithModel:m];
        if (self.handleActionHandler) {
            self.handleActionHandler(tmp);
        } else if (self.handlerBlock) {
            self.handlerBlock(tmp);
        }
        if (self.currentSelectedModel.itemID != m.itemID && !tmp.selected) {//如果点击的不是选中的item,且设置选中状态为NO. 保持选中的原来那个按钮
            return;
        }
        // 更换选中的model
        self.currentSelectedModel = tmp;
        [self p_cancleAllItemSelected];
        [self.renderModel.items replaceObjectAtIndex:indexPath.row withObject:tmp];
    } else { //不可取消
        if (m.selected) { // 如果被选择了，不做操作
            return;
        }
        SEEDSelectedItemModel *tmp = [m copy];
        tmp.selected = [self p_isSelectedWithModel:m];
        if (self.currentSelectedModel.itemID != m.itemID &&!tmp.selected) {//如果点击的不是选中的item,且设置选中状态为NO. 保持选中的原来那个按钮
            return;
        }
        if (self.handleActionHandler) {
            self.handleActionHandler(tmp);
        } else if (self.handlerBlock) {
            self.handlerBlock(tmp);
        }
        self.currentSelectedModel = tmp;
        [self p_cancleAllItemSelected];
        [self.renderModel.items replaceObjectAtIndex:indexPath.row withObject:tmp];
    }
    [self.listView reloadData];
    
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.renderModel.lineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.renderModel.interitemSpacing;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.renderModel.items.count > indexPath.row) {
        return self.renderModel.items[indexPath.row].itemSize;
    }else {
        return CGSizeMake(0, 0);
    }
}


@end
