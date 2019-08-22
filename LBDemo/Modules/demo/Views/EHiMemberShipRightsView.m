//
//  EHiMemberShipRightsView.m
//  LBDemo
//
//  Created by 李兵 on 2019/8/9.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "EHiMemberShipRightsView.h"
#import "EHiMemberShipRightsModel.h"


@interface EHiMemberShipRightsItemView : UIView

/** 会员权益 */
@property (nonatomic, strong) UILabel *textLab;

/** 会员权益 */
@property (nonatomic, strong) UIButton *button;

@property (nonatomic, copy) SelectedCallBack clickBlock;

@property (nonatomic, strong) EHiMemberShipRightsItemModel *model;

- (void)renderViewWithModel:(EHiMemberShipRightsItemModel *)model;


@end

@implementation EHiMemberShipRightsItemView

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
    
    [_textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.height.mas_greaterThanOrEqualTo(13);
        make.centerY.equalTo(self.textLab.superview);
    }];
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(0);
        make.width.height.mas_greaterThanOrEqualTo(autoWidthOf6(17));
    }];
}

#pragma mark public
-(void)renderViewWithModel:(EHiMemberShipRightsItemModel *)model {
    self.model = model;
    
    self.textLab.text = self.model.text;
    self.button.selected = model.selected; //决定背景图片
}

#pragma mark Action
- (void)doClickAction {
    self.model.selected = !self.model.selected;
    [self renderViewWithModel:self.model];
    
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
        _textLab.font = autoFONT(12);
        _textLab.textAlignment = NSTextAlignmentLeft;
        _textLab.text = @" ";
    }
    return _textLab;
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
    
        EHiWeakSelf(self)
        [_button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            EHiStrongSelf(self)
            [self doClickAction];
        }];
        
        [_button setBackgroundImage:[UIImage imageWithColor:kEHIHexColor_FFFFFF] forState:UIControlStateNormal];
        [_button setBackgroundImage:[UIImage imageNamed:@"hicar_return_selected"] forState:UIControlStateSelected];
    }
    return _button;
}

@end

#pragma mark -

@interface EHiMemberShipRightsView ()

@property (nonatomic, strong, readwrite) EHiMemberShipRightsModel *renderModel;


@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) NSMutableArray <EHiMemberShipRightsItemView *> *itemViews;

@end

@implementation EHiMemberShipRightsView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self prepareData];
        
        [self setupSubViews];
        
        [self renderViewWithModel:self.renderModel];
    }
    return self;
}

- (void)setupSubViews {
    
    [self addSubview:self.titleLab];
    
    for (int i = 0; i < self.renderModel.itemModels.count ; i++) {
       
        EHiMemberShipRightsItemView *itemView = [[EHiMemberShipRightsItemView alloc] init];
        
        EHiWeakSelf(self)
        itemView.clickBlock = ^(EHiMemberShipRightsItemModel *model) {
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
    EHiMemberShipRightsItemView *preObj;
     for (int i = 0; i < self.itemViews.count ; i++) {
         EHiMemberShipRightsItemView *obj = self.itemViews[i];
         
         if (i == 0) {
             [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.top.mas_equalTo(self.titleLab.mas_bottom).with.offset(autoHeightOf6(13));
                 make.left.equalTo(self.titleLab);
                 make.height.mas_greaterThanOrEqualTo(16);
                 make.right.mas_equalTo(0);
             }];
         } else {
             [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.top.equalTo(preObj.mas_bottom).with.offset(self.renderModel.lineSpace?:13);
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

/** 准备数据 */
- (void)prepareData {
    self.renderModel = [[EHiMemberShipRightsModel alloc] init];
    
    NSArray<NSString *> *textArr = @[
                         @"2小时免费延时还车（剩余0次）",
                         @"免加油服务费（剩余0次"
                         ];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < textArr.count; i++) {
        EHiMemberShipRightsItemModel *itemModel = [[EHiMemberShipRightsItemModel alloc] init];
        itemModel.text = textArr[i];
        itemModel.selected = NO;
        [arr addObject:itemModel];
    }
    
    self.renderModel.itemModels = arr;
    
    self.renderModel.title = @"会员权益";
}

#pragma mark public
/** 渲染页面 */
-(void)renderViewWithModel:(EHiMemberShipRightsModel *)model {
    self.renderModel = model;
    
    [self.itemViews enumerateObjectsUsingBlock:^(EHiMemberShipRightsItemView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx >= self.renderModel.itemModels.count) {
            *stop = YES;
        }
        [obj renderViewWithModel:self.renderModel.itemModels[idx]];
    }];

    self.titleLab.text = model.title;
}

#pragma mark Action
/** 点击传递的model */
- (void)doClickActionWithModel:(EHiMemberShipRightsItemModel *)model {
    if (self.didClick) {
        self.didClick(model);
    }
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

- (NSMutableArray<EHiMemberShipRightsItemView *> *)itemViews {
    if (!_itemViews) {
        _itemViews = [NSMutableArray array];
    }
    
    return _itemViews;
}

@end
