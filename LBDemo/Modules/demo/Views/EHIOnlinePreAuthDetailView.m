//
//  EHIOnlinePreAuthDetailView.m
//  1haiiPhone
//
//  Created by 李兵 on 2019/7/23.
//  Copyright © 2019 EHi. All rights reserved.
//

#import "EHIOnlinePreAuthDetailView.h"
#import "EHIOnlinePreAuthModel.h"

@interface EHIOnlinePreAuthItemView : UIView

/** value：会员权益 */
@property (nonatomic, strong) UILabel *textLab;

/** value 已支付 */
@property (nonatomic, strong) UILabel *rightTextLab;

/** 会员权益 */
@property (nonatomic, strong) UIButton *button;

@property (nonatomic, copy) SelectedCallBack clickBlock;

@property (nonatomic, strong) EHIOnlinePreAuthItemModel *model;

- (void)renderViewWithModel:(EHIOnlinePreAuthItemModel *)model;


@end

@implementation EHIOnlinePreAuthItemView

#pragma mark life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    
    return self;
}

- (void)setupSubViews {
    [self addSubview:self.textLab];
    [self addSubview:self.button];
    [self addSubview:self.rightTextLab];
    
    [_textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.height.mas_greaterThanOrEqualTo(13);
        make.centerY.equalTo(self.textLab.superview);
    }];
    
    [_rightTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.centerY.equalTo(self.rightTextLab.superview);
    }];
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(0);
        make.width.mas_greaterThanOrEqualTo(autoWidthOf6(49));
        make.height.mas_greaterThanOrEqualTo(autoWidthOf6(24));
    }];
    
    
}

#pragma mark public
-(void)renderViewWithModel:(EHIOnlinePreAuthItemModel *)model {
    self.model = model;
    
    self.rightTextLab.text = self.model.havePreAuthedText?:@"已支付";
    self.rightTextLab.hidden = !self.model.havePreAuthed;
    self.rightTextLab.textColor = kEHIHexColor_7B7B7B;
    
    [self.button setTitle:self.model.noPreAuthedText?:@"去支付" forState:UIControlStateNormal];
    [self.button setTitle:self.model.noPreAuthedText?:@"去支付" forState:UIControlStateHighlighted];
    
    self.textLab.text = self.model.text;
    
    self.button.hidden = self.model.havePreAuthed;
}

#pragma mark Action
- (void)doClickAction {
    if (self.model.havePreAuthed) {
        return;
    }
    
    if (self.clickBlock) {
        self.clickBlock(self.model);
    }
}

#pragma mark getter
- (UILabel *)textLab {
    if (!_textLab) {
        _textLab  = [[UILabel alloc] init];
        _textLab.numberOfLines = 0;
        _textLab.textColor = kEHIHexColor_333333;
        _textLab.font = autoBoldFONT(12);
        _textLab.textAlignment = NSTextAlignmentLeft;
        _textLab.text = @" ";
    }
    return _textLab;
}

- (UILabel *)rightTextLab {
    if (!_rightTextLab) {
        _rightTextLab  = [[UILabel alloc] init];
        _rightTextLab.numberOfLines = 0;
        _rightTextLab.textColor = kEHIHexColor_333333;
        _rightTextLab.font = autoFONT(12);
        _rightTextLab.textAlignment = NSTextAlignmentRight;
        _rightTextLab.text = @" ";
    }
    return _rightTextLab;
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        EHiWeakSelf(self)
        [_button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            EHiStrongSelf(self)
            [self doClickAction];
        }];
        
        [_button setTitleColor:kEHIHexColor_FF7E00 forState:UIControlStateNormal];
         [_button setTitleColor:kEHIHexColor_FF7E00 forState:UIControlStateHighlighted];
        
        _button.titleLabel.font = autoFONT(12);
        
        _button.layer.borderWidth = SINGLE_LINE_WIDTH;
        _button.layer.borderColor = kEHIHexColor_FF7E00.CGColor;
    }
    return _button;
}

@end


#pragma mark -

@interface EHIOnlinePreAuthDetailView()

@property (nonatomic, strong, readwrite) EHIOnlinePreAuthModel *renderModel;

@property (nonatomic, strong, readwrite) UILabel *titleLab;

@property (nonatomic, strong) NSMutableArray <EHIOnlinePreAuthItemView *> *itemViews;

@end

@implementation EHIOnlinePreAuthDetailView

#pragma mark  life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self prepareData];
        
        [self setupSubViews];
        
        [self renderViewWithModel:self.renderModel];
    }
    return self;
}


/** 准备数据 */
- (void)prepareData {
    self.renderModel = [[EHIOnlinePreAuthModel alloc] init];
    
    NSArray<NSString *> *textArr = @[
                                     @"车辆押金￥5000（可退）",
                                     @"违章押金￥2000（可退）"
                                     ];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < textArr.count; i++) {
        EHIOnlinePreAuthItemModel *itemModel = [[EHIOnlinePreAuthItemModel alloc] init];
        itemModel.text = textArr[i];
        if (i == 0) {
            itemModel.havePreAuthed = YES;
        } else {
            itemModel.havePreAuthed = NO;
        }
        
        [arr addObject:itemModel];
    }
    
    self.renderModel.itemModels = arr;
    
    self.renderModel.title = @"车辆＋违章押金";
}

- (void)setupSubViews {
    self.backgroundColor = UIColor.whiteColor;
    
    [self addSubview:self.titleLab];
    
    for (int i = 0; i < self.renderModel.itemModels.count ; i++) {
        
        EHIOnlinePreAuthItemView *itemView = [[EHIOnlinePreAuthItemView alloc] init];
        
        EHiWeakSelf(self)
        itemView.clickBlock = ^(EHIOnlinePreAuthItemModel *model) {
            EHiStrongSelf(self)
            [self doClickActionWithModel:model];
        };
        
        [self addSubview:itemView];
        
        [self.itemViews addObject:itemView];
        
    }
    
    //layout
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
    }];
    EHIOnlinePreAuthItemView *preObj;
    for (int i = 0; i < self.itemViews.count ; i++) {
        EHIOnlinePreAuthItemView *obj = self.itemViews[i];
        
        if (i == 0) {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.titleLab.mas_bottom).with.offset(autoHeightOf6(13));
                make.left.equalTo(self.titleLab);
                make.height.mas_greaterThanOrEqualTo(16);
                make.right.mas_equalTo(0);
            }];
        } else {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(preObj.mas_bottom).with.offset(self.renderModel.lineSpace?:0);
                make.left.equalTo(preObj);
                make.height.equalTo(preObj);
                make.right.mas_equalTo(0);
            }];
        }
        
        if (i == self.itemViews.count - 1) {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(0);
            }];
        }
        preObj = obj;
        
    }
}

#pragma mark Action
- (void)doClickActionWithModel:(EHIOnlinePreAuthItemModel *)model {
    if (self.didClick) {
        self.didClick(model);
    }
}

#pragma mark public

- (void)renderViewWithModel:(EHIOnlinePreAuthModel *)renderModel {
    self.renderModel = renderModel;
    
    [self.itemViews enumerateObjectsUsingBlock:^(EHIOnlinePreAuthItemView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx >= self.renderModel.itemModels.count) {
            *stop = YES;
        }
        
        [obj renderViewWithModel:self.renderModel.itemModels[idx]];
    }];
    
    self.titleLab.text = self.renderModel.title?:@"车辆＋违章押金";
    
}

#pragma mark getter
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab  = [[UILabel alloc] init];
        _titleLab.numberOfLines = 0;
        _titleLab.textColor = kEHIHexColor_333333;
        _titleLab.font = autoBoldFONT(14);
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.text = @" ";
    }
    return _titleLab;
}


- (NSMutableArray<EHIOnlinePreAuthItemView *> *)itemViews {
    if (!_itemViews) {
        _itemViews = [NSMutableArray array];
    }
    
    return _itemViews;
}

@end
