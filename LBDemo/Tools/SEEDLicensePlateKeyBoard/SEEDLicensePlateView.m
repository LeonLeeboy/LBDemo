//
//  SEEDLicensePlateView.m
//  LBDemo
//
//  Created by 李兵 on 2019/8/20.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "SEEDLicensePlateView.h"

#pragma mark -
#pragma mark 每个itemodel

@implementation SEEDLicensePlateItemModel
@end

#pragma mark -
#pragma mark 键盘Model

@implementation SEEDLicensePlateModel
@end

#pragma mark -
#pragma mark 键盘Item View

static UIColor *defaultItemNormalBackGroundColor() {
    return kEHIHexColor_FFFFFF;
}

static UIColor *defaultItemHighLightedBackGroundColor() {
    return kEHIHexColor_000000;
}

static UIColor *defaultItemNormalTitleGroundColor() {
    return kEHIHexColor_333333;
}

static UIColor *defaultItemHighLightedTitleGroundColor() {
    return kEHIHexColor_333333;
}

static UIFont *defaultItemTextFont() {
    return autoFONT(21);
}

@interface SEEDLicensePlateItemView : UIButton

@property (nonatomic, strong) SEEDLicensePlateItemModel *model;

- (void)renderViewWithModel:(SEEDLicensePlateItemModel *)model;

@end

@implementation SEEDLicensePlateItemView

#pragma mark public
- (void)renderViewWithModel:(SEEDLicensePlateItemModel *)model {
    
    self.model = model;
    
    [self setTitle:model.text?:@"" forState:UIControlStateNormal];
    [self setTitle:model.text?:@"" forState:UIControlStateSelected];
    
    if (model.backGroundImage) {
        [self setBackgroundColor:model.defaultBackgroundColor];
        [self setBackgroundImage:model.backGroundImage forState:UIControlStateNormal];
    } else {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setBackgroundImage:[UIImage imageWithColor:model.defaultBackgroundColor?:defaultItemNormalBackGroundColor()] forState:UIControlStateNormal];
        
        [self setBackgroundImage:[UIImage imageWithColor:model.highLightedTextColor?:defaultItemHighLightedBackGroundColor()] forState:UIControlStateHighlighted];
    }
    
    [self setTitleColor:model.normalTextColor?:defaultItemNormalTitleGroundColor() forState:UIControlStateNormal];
    [self setTitleColor:model.highLightedTextColor?:defaultItemHighLightedTitleGroundColor() forState:UIControlStateHighlighted];
    
    self.titleLabel.font = model.normalTextFont?:defaultItemTextFont();
    
    self.layer.cornerRadius = model.cornerRadius;
}


@end

#pragma mark -
#pragma mark 键盘View

static UIColor *defaultInputViewBackGroundColor() {
    return kEHIHexColor_F8F8F8;
}

#define kEHIHexColor_AAB4BE kEHIHexColor(0xAAB4BE);

@interface SEEDLicensePlateView ()

/** 渲染的model */
@property (nonatomic, strong, readwrite) SEEDLicensePlateModel *renderModel;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) SEEDLicensePlateItemView *abcOrProvinceButton;

@property (nonatomic, strong) NSArray<SEEDLicensePlateItemView *> *itemViews;

@property (nonatomic, strong) SEEDLicensePlateItemView *deleteButton;

@end

@implementation SEEDLicensePlateView

@synthesize inputView = _inputView;

#pragma mark life cycle

- (instancetype)initWithStyle:(SEDDLicensePlateStyle)style {
    if (self = [super initWithFrame:CGRectZero]) {
        self.renderModel.style = style;
        [self setupSubViews];
    }
    return self;
}

- (instancetype)initWithModel:(SEEDLicensePlateModel *)renderModel {
    if (self = [super initWithFrame:CGRectZero]) {
        
        self.renderModel = renderModel;
        
        [self setupSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //subviews
        [self setupSubViews];
        
    }
    return self;
}

- (void)setupSubViews {
    if (!self.contentView.superview) {
        [self addSubview:self.contentView];
    }
    
    for (SEEDLicensePlateItemView *obj in self.itemViews) {
        [self.contentView addSubview:obj];
    }
    
    // 左下角切换键
    [self.contentView addSubview:self.abcOrProvinceButton];
    // 右下角删除键
    [self.contentView addSubview:self.deleteButton];
   
    [self addSubview:self.inputView];
    
    [self p_layoutViews];
}

#pragma mark public
- (void)renderViewWithModel:(SEEDLicensePlateModel *)renderModel {
    //置空一些必要参数
//    [self p_emptyViews];
    
    self.renderModel = renderModel;
    
//    [self setupSubViews];
    
    [self p_renderItemView];
}

- (void)renderViewWithWithStyle:(SEDDLicensePlateStyle)style {
    
//    [self p_emptyViews];
    
    self.renderModel.style = style;
    
//    [self setupSubViews];
    
    [self p_renderItemView];

}

#pragma mark Action
/** 删除事件 */
- (void)doDeleteAction {
    if ([self.delegate respondsToSelector:@selector(licensePlateView:didClickText:clickEvent:)]) {
        [self.delegate licensePlateView:self didClickText:@"" clickEvent:SEDDLicesePlateViewEventClickDel];
    }
}

/** 点击ABC OR 省份 */
- (void)doChangeKeyBoardTypeStyleActionWithModel:(SEEDLicensePlateItemModel *)model {
    if ([model.text isEqualToString:@"省份"]) {
        if ([self.delegate respondsToSelector:@selector(licensePlateView:didClickText:clickEvent:)]) {
            [self.delegate licensePlateView:self didClickText:@"" clickEvent:SEDDLicesePlateViewEventClickLicensePlate];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(licensePlateView:didClickText:clickEvent:)]) {
            [self.delegate licensePlateView:self didClickText:@"" clickEvent:SEDDLicesePlateViewEventClickABC];
        }
    }
}

/** 点击响应的item */
- (void)doClickItemActionWithModel:(SEEDLicensePlateItemModel *)model {
    if ([self.delegate respondsToSelector:@selector(licensePlateView:didClickText:clickEvent:)]) {
        [self.delegate licensePlateView:self didClickText:model.text clickEvent:SEDDLicesePlateViewEventClickItem];
    }
}

#pragma mark private
- (void)p_layoutViews {
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputView.mas_bottom).with.offset(self.renderModel.contentInset.top);
        make.bottom.mas_equalTo(-self.renderModel.contentInset.bottom);
        make.left.mas_equalTo(self.renderModel.contentInset.left);
        make.right.mas_equalTo(-self.renderModel.contentInset.right);
    }];
    
    if (self.renderModel.style == SEDDLicensePlateStyleProvince) {
        [self p_layoutProvinceViews];
    } else {
        [self p_layoutABCViews];
    }
    
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.deleteButton.model.size.width);
        make.height.equalTo(self.itemViews.lastObject);
    }];
    
    [_abcOrProvinceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.abcOrProvinceButton.model.size.width);
        make.height.equalTo(self.itemViews.lastObject);
    }];
    
    
}

- (UIView *)p_createKeyBoardView {
    UIView *contentView = [[UIView alloc] init];
    
    return contentView;
}

- (void)p_layoutProvinceViews {
    SEEDLicensePlateItemView *preObjc = self.itemViews.firstObject;
    SEEDLicensePlateItemView *preLine = self.itemViews.firstObject;
    
    for (int i = 0; i < self.itemViews.count; i++) {
        NSInteger lineIndex = i / self.renderModel.perLineCount;
        NSInteger columnIdx = i % self.renderModel.perLineCount;
        SEEDLicensePlateItemView *itemView = self.itemViews[i];
        if (i == 0) {
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.mas_equalTo(0);
            }];
            preObjc = itemView;
        } else {
            if (lineIndex == 0) {
                [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(preObjc.mas_right).with.offset(self.renderModel.itemSpace);
                    make.top.equalTo(preObjc);
                    make.bottom.equalTo(preObjc);
                    make.width.equalTo(preObjc);
                }];
                //添加一个靠右约束
                if (columnIdx == self.renderModel.perLineCount - 1) {
                    [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.mas_equalTo(0);
                    }];
                }
                if (columnIdx == 0) {
                    preLine = itemView;
                }
                preObjc = itemView;
            } else {
                if (columnIdx == 0) {
                    if (lineIndex == self.renderModel.lineCount - 1) {
                        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.mas_equalTo(self.abcOrProvinceButton.model.size.width + self.renderModel.itemSpace);
                            make.top.equalTo(preLine.mas_bottom).with.offset(self.renderModel.lineSpace);
                            make.height.equalTo(preLine);
                            make.width.equalTo(preLine);
                        }];
                        
                    } else {
                        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.equalTo(preLine);
                            make.top.equalTo(preLine.mas_bottom).with.offset(self.renderModel.lineSpace);
                            make.height.equalTo(preLine);
                            make.width.equalTo(preLine);
                        }];
                    }
                    
                    preLine = itemView;
                    preObjc = itemView;
                } else {
                    [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(preObjc.mas_right).with.offset(self.renderModel.itemSpace);
                        make.top.equalTo(preObjc);
                        make.bottom.equalTo(preObjc);
                        make.width.equalTo(preObjc);
                    }];
                    preObjc = itemView;
                }
            }
        }
    }
    
    [self.itemViews.lastObject mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
    }];
}

- (void)p_layoutABCViews {
    SEEDLicensePlateItemView *preObjc = self.itemViews.firstObject;
    SEEDLicensePlateItemView *preLine = self.itemViews.firstObject;
    
    for (int i = 0; i < 10; i++) {
         SEEDLicensePlateItemView *itemView = self.itemViews[i];
        if (i == 0) {
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.mas_equalTo(0);
            }];
            preLine = itemView;
        } else {
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(preObjc.mas_right).with.offset(self.renderModel.itemSpace);
                make.top.equalTo(preObjc);
                make.bottom.equalTo(preObjc);
                make.width.equalTo(preObjc);
            }];
        }
        
        if (i == 9) {
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(0);
            }];
        }
        preObjc = itemView;
    }
    
    for (int i = 10; i < 20; i++) {
        SEEDLicensePlateItemView *itemView = self.itemViews[i];
        if (i == 10) {
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(preLine);
                make.top.equalTo(preLine.mas_bottom).with.offset(self.renderModel.lineSpace);
                make.height.equalTo(preLine);
                make.width.equalTo(preLine);
            }];
            preLine = itemView;
            
        } else {
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(preObjc.mas_right).with.offset(self.renderModel.itemSpace);
                make.top.equalTo(preObjc);
                make.bottom.equalTo(preObjc);
                make.width.equalTo(preObjc);
            }];
        }
        preObjc = itemView;
    }
    
    for (int i = 20; i < 29; i++) {
        SEEDLicensePlateItemView *itemView = self.itemViews[i];
        if (i == 20) {
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(preLine);
                make.top.equalTo(preLine.mas_bottom).with.offset(self.renderModel.lineSpace);
                make.height.equalTo(preLine);
                make.width.equalTo(preLine);
            }];
            preLine = itemView;
            
        } else {
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(preObjc.mas_right).with.offset(self.renderModel.itemSpace);
                make.top.equalTo(preObjc);
                make.bottom.equalTo(preObjc);
                make.width.equalTo(preObjc);
            }];
        }
        preObjc = itemView;
    }
    
    
    
    for (int i = 0; i < self.itemViews.count; i++) {
        NSInteger lineIndex = i / self.renderModel.perLineCount;
        NSInteger columnIdx = i % self.renderModel.perLineCount;
        SEEDLicensePlateItemView *itemView = self.itemViews[i];
        if (i == 0) {
           
        } else {
            if (lineIndex == 0) {
                [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(preObjc.mas_right).with.offset(self.renderModel.itemSpace);
                    make.top.equalTo(preObjc);
                    make.bottom.equalTo(preObjc);
                    make.width.equalTo(preObjc);
                }];
                //添加一个靠右约束
                if (columnIdx == self.renderModel.perLineCount - 1) {
                    [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.mas_equalTo(0);
                    }];
                }
                if (columnIdx == 0) {
                    preLine = itemView;
                }
                preObjc = itemView;
            } else if (lineIndex == 2) {
                
                if (columnIdx == 0) {
                    if (lineIndex == self.renderModel.lineCount - 1) {
                        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.mas_equalTo(self.abcOrProvinceButton.model.size.width + self.renderModel.itemSpace);
                            make.top.equalTo(preLine.mas_bottom).with.offset(self.renderModel.lineSpace);
                            make.height.equalTo(preLine);
                            make.width.equalTo(preLine);
                        }];
                        
                    } else {
                        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.equalTo(preLine);
                            make.top.equalTo(preLine.mas_bottom).with.offset(self.renderModel.lineSpace);
                            make.height.equalTo(preLine);
                            make.width.equalTo(preLine);
                        }];
                    }
                    
                    preLine = itemView;
                    preObjc = itemView;
                } else {
                    [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(preObjc.mas_right).with.offset(self.renderModel.itemSpace);
                        make.top.equalTo(preObjc);
                        make.bottom.equalTo(preObjc);
                        make.width.equalTo(preObjc);
                    }];
                    preObjc = itemView;
                }
                
            } else {
                if (columnIdx == 0) {
                    if (lineIndex == self.renderModel.lineCount - 1) {
                        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.mas_equalTo(self.abcOrProvinceButton.model.size.width + self.renderModel.itemSpace);
                            make.top.equalTo(preLine.mas_bottom).with.offset(self.renderModel.lineSpace);
                            make.height.equalTo(preLine);
                            make.width.equalTo(preLine);
                        }];
                        
                    } else {
                        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.equalTo(preLine);
                            make.top.equalTo(preLine.mas_bottom).with.offset(self.renderModel.lineSpace);
                            make.height.equalTo(preLine);
                            make.width.equalTo(preLine);
                        }];
                    }
                    
                    preLine = itemView;
                    preObjc = itemView;
                } else {
                    [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(preObjc.mas_right).with.offset(self.renderModel.itemSpace);
                        make.top.equalTo(preObjc);
                        make.bottom.equalTo(preObjc);
                        make.width.equalTo(preObjc);
                    }];
                    preObjc = itemView;
                }
            }
        }
    }
    
    [self.itemViews.lastObject mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
    }];
}


/** province Name */
- (NSArray<NSString *> *)p_getProvincesName {
    NSArray *arr = @[
                     @"京",@"沪",@"粤",@"津",@"冀",@"晋",@"蒙",@"辽",@"吉",@"黑",
                     @"苏",@"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"桂",
                     @"琼",@"渝",@"川",@"贵",@"云",@"藏",@"陕",@"甘",@"青",@"宁",
                     @"新",@"使",@"领",@"警",@"学",@"港",@"澳"
                     ];
    return arr;
}

/** ABC */
- (NSArray<NSString *> *)p_getABC {
    NSArray *rst = @[
                     @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",
                      @"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",
                      @"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",
                      @"U",@"V",@"W",@"X",@"Y",@"Z"
                     ];
    return rst;
}

/** 获得显示的字符串集合 */
- (NSArray *)p_getContentsStrings {
    if (self.renderModel.style == SEDDLicensePlateStyleABC) {
        return [self p_getABC];
    } else {
        return [self p_getProvincesName];
    }
}

/**  */
- (SEEDLicensePlateItemModel *)p_createDefaultItemModel {
    SEEDLicensePlateItemModel *itemModel = [[SEEDLicensePlateItemModel alloc] init];
    itemModel.normalTextFont = autoFONT(21);
    itemModel.cornerRadius = 4;
    return itemModel;
}

/** 核心reload方法 */
- (void)p_renderItemView {
    
    NSArray<NSString *> *arr = [self p_getContentsStrings];
    [self.renderModel.itemModels enumerateObjectsUsingBlock:^(SEEDLicensePlateItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < arr.count) {
            obj.text = arr[idx];
        }
    }];
    
    EHiWeakSelf(self)
    [self.renderModel.itemModels enumerateObjectsUsingBlock:^(SEEDLicensePlateItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        EHiStrongSelf(self)
        if (idx < self.itemViews.count) {
            [self.itemViews[idx] renderViewWithModel:obj];
        }
    }];
    
    [self p_setProvinceAbcButton];
}

- (void)p_setProvinceAbcButton {
    if (self.renderModel.style == SEDDLicensePlateStyleProvince) {
        self.abcOrProvinceButton.model.text = @"省份";
    } else {
        self.abcOrProvinceButton.model.text = @"ABC";
    }
}

/** 置空一些view */
- (void)p_emptyViews {
    self.itemViews = nil;
    self.renderModel = nil;
    self.abcOrProvinceButton = nil;
    self.deleteButton = nil;
    
    [self removeAllSubviews];
}

#pragma mark getter && setter
- (SEEDLicensePlateModel *)renderModel {
    
    if (!_renderModel) {
        _renderModel = [[SEEDLicensePlateModel alloc] init];
        _renderModel.style = SEDDLicensePlateStyleProvince;
        _renderModel.lineCount = 4;
        _renderModel.contentInset = UIEdgeInsetsMake(9, 4, 9, 4);
        _renderModel.itemSpace = 3;
        _renderModel.lineSpace = 4.0;
        _renderModel.perLineCount = 10;
        
        NSArray<NSString *> *tmp = [self p_getContentsStrings];
        NSMutableArray *content = [NSMutableArray arrayWithCapacity:tmp.count];
        
        for (int i = 0; i < tmp.count; i++) {
            SEEDLicensePlateItemModel *model = [[SEEDLicensePlateItemModel alloc] init];
            model.text = tmp[i];
            [content addObject:model];
        }
    
        _renderModel.itemModels = [NSArray arrayWithArray:content];
        
    }
    
    return _renderModel;
}

- (UIView *)inputView {
    if (!_inputView) {
        _inputView = [[UIView alloc] init];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _inputView.backgroundColor = self.renderModel.inPutViewBackGroundColor ? : defaultInputViewBackGroundColor();
        [button setTitle:@"完成" forState:UIControlStateNormal | UIControlStateHighlighted | UIControlStateSelected];
        
        [_inputView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(autoHeightOf6(8));
            make.right.bottom.mas_equalTo(-autoHeightOf6(8));
        }];
        
    }
    return _inputView;
}

- (void)setInputView:(UIView *)inputView {
    if (!inputView) {
        return;
    }
    _inputView = inputView;
}

- (UIView *)contentView {
    if (!_contentView) {
        
        _contentView = [[UIView alloc] init];
        
    }
    return _contentView;
}

- (NSArray<SEEDLicensePlateItemView *> *)itemViews {
    if (!_itemViews) {
        NSArray *tmp = [self p_getContentsStrings];
        NSMutableArray *content = [NSMutableArray arrayWithCapacity:tmp.count];

        for (int i = 0; i < tmp.count; ++i) {
          SEEDLicensePlateItemView *itemView = [[SEEDLicensePlateItemView alloc] init];
            
           SEEDLicensePlateItemModel *model = self.renderModel.itemModels[i];
            
            EHiWeakSelf(self)
            [itemView addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                EHiStrongSelf(self)
                [self doClickItemActionWithModel:model];
            }];
            
            [itemView renderViewWithModel:model];
            
            [content addObject:itemView];
        }
        
        _itemViews = content;
    }
    
    return _itemViews;
}

- (SEEDLicensePlateItemView *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[SEEDLicensePlateItemView alloc] init];
        
        SEEDLicensePlateItemModel *model = [[SEEDLicensePlateItemModel alloc] init];
        model.backGroundImage = [UIImage imageNamed:@"SEED_Delete_image"];
        model.defaultBackgroundColor = kEHIHexColor_000000;
        model.highLightedTextColor = kEHIHexColor_333333;
        model.normalTextFont = autoBoldFONT(16);
        model.cornerRadius = 4;
        model.size = CGSizeMake(autoWidthOf6(52), autoHeightOf6(49));
        
        [_deleteButton addTarget:self action:@selector(doDeleteAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_deleteButton renderViewWithModel:model];
    }
    return _deleteButton;
}

- (SEEDLicensePlateItemView *)abcOrProvinceButton {
    if (!_abcOrProvinceButton) {
        _abcOrProvinceButton = [[SEEDLicensePlateItemView alloc] init];
        
        SEEDLicensePlateItemModel *model = [[SEEDLicensePlateItemModel alloc] init];
        if (self.renderModel.style == SEDDLicensePlateStyleABC) {
            model.text = @"ABC";
        } else if (self.renderModel.style == SEDDLicensePlateStyleProvince) {
            model.text = @"省份";
        }
        
        model.defaultBackgroundColor = kEHIHexColor_AAB4BE;
        model.highLightedTextColor = kEHIHexColor_333333;
        model.normalTextColor = kEHIHexColor_333333;
        model.normalTextFont = autoBoldFONT(16);
        model.cornerRadius = 4;
        model.size = CGSizeMake(autoWidthOf6(52), autoHeightOf6(49));
        EHiWeakSelf(self)
        [_abcOrProvinceButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            EHiStrongSelf(self)
            [self doChangeKeyBoardTypeStyleActionWithModel:model];
        }];
       
        
        [_abcOrProvinceButton renderViewWithModel:model];
    }
    return _abcOrProvinceButton;
}

@end
