//
//  EHINewItineraryMessagesView.m
//  LBDemo
//
//  Created by 李兵 on 2019/9/20.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "EHINewItineraryMessagesView.h"
#import "EHINewItineraryMessagesItemModel.h"

@interface EHINewItineraryMessagesItemView ()

#pragma mark 暂存属性
/** 左边 */
@property (nonatomic, strong) UIImageView *iconImageView;

/** 左边描述label */
@property (nonatomic, strong) YYLabel *desLab;

/** 右边label */
@property (nonatomic, strong) YYLabel *desValueLab;

/** （没有描述lable的前提下，和desValueLab 出现 互斥）右边label  */
@property (nonatomic, strong) YYLabel *normalValueLab;

/** 底部线条 */
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation EHINewItineraryMessagesItemView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
    [self addSubview:self.iconImageView];
    [self addSubview:self.desLab];
    [self addSubview:self.desValueLab];
    [self addSubview:self.normalValueLab];
    [self addSubview:self.bottomLine];
    
    [self layoutViews];
}

- (void)layoutViews {
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(15);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(autoHeightOf6(12));
    }];
    
    [_desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImageView);
        make.left.equalTo(self.iconImageView.mas_right).with.offset(autoWidthOf6(8));
        make.right.equalTo(self.desValueLab.mas_left).with.offset(-autoWidthOf6(10));
    }];
    
    [_normalValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).with.offset(autoWidthOf6(8));
        make.centerY.equalTo(self.iconImageView);
        make.right.mas_equalTo(-autoWidthOf6(17));
        make.bottom.mas_equalTo(-autoHeightOf6(12));
    }];
    
    [_desValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView);
        make.bottom.mas_equalTo(-autoHeightOf6(12));
        make.right.mas_equalTo(-autoWidthOf6(17));
        make.width.mas_equalTo(autoWidthOf6(152));
    }];
    
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
        make.height.mas_equalTo(1);
        make.left.equalTo(self.desLab);
        make.right.mas_equalTo(0);
    }];
}

#pragma mark - public

- (void)renderViewWithModel:(EHINewItineraryMessagesItemModel *)model {
    self.normalValueLab.hidden = model.hiddenNormalValue;
    self.desLab.hidden = !model.hiddenNormalValue;
    self.desValueLab.hidden = !model.hiddenNormalValue;
    self.bottomLine.hidden = model.hiddenBottomLine;
    
    self.desLab.text = model.des;
    self.desValueLab.text = model.desValue;
    self.normalValueLab.text = model.normalValue;
    
    self.iconImageView.image = [UIImage imageNamed:model.iconImageName?:@""];
}


#pragma mark - private
/** 创建一个Label */
- (YYLabel *)p_createLabel {
    
    YYLabel *lab = [[YYLabel alloc] init];
    lab.numberOfLines = 1;
    lab.backgroundColor = [UIColor clearColor];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.font = autoFONT(14);
    lab.text = @"  ";
    
    return lab;
}

#pragma mark - Getter && Setter

- (YYLabel *)desLab {
    if (!_desLab) {
        YYLabel *lab = [self p_createLabel];
        lab.textColor = kEHIHexColor_7B7B7B;
        _desLab = lab;
    }
    return _desLab;
}

- (YYLabel *)desValueLab {
    if (!_desValueLab) {
        YYLabel *lab = [self p_createLabel];
        lab.textColor = kEHIHexColor_333333;
        lab.textAlignment = NSTextAlignmentRight;
        _desValueLab = lab;
    }
    return _desValueLab;
}

- (YYLabel *)normalValueLab {
    if (!_normalValueLab) {
        YYLabel *lab = [self p_createLabel];
        lab.textColor = kEHIHexColor_333333;
        lab.textAlignment = NSTextAlignmentRight;
        _normalValueLab = lab;
    }
    return _normalValueLab;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        
        _iconImageView = imgView;
    }
    return _iconImageView;
}


- (UIView *)bottomLine {
    if (!_bottomLine) {
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = kEHIHexColor_EEEEEE;
        
        _bottomLine = line;
    }
    return _bottomLine;
}


@end

#pragma mark - 

@interface EHINewItineraryMessagesView ()

/** 贮存itemView */
@property (nonatomic, strong) NSArray<EHINewItineraryMessagesItemView *> *itemViews;

@end

@implementation EHINewItineraryMessagesView

#pragma mark - public
- (void)renderViewWithModels:(NSArray<EHINewItineraryMessagesItemModel *> *)models {
    if (self.itemViews.count > 0) {
        [self.itemViews enumerateObjectsUsingBlock:^(EHINewItineraryMessagesItemView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }
    
    NSMutableArray<EHINewItineraryMessagesItemView *> *itemViews = [NSMutableArray arrayWithCapacity:models.count];
    for (int i = 0; i < models.count; i++) {
        EHINewItineraryMessagesItemModel *model = models[i];
        
        EHINewItineraryMessagesItemView *itemView = [[EHINewItineraryMessagesItemView alloc] init];
        [itemView renderViewWithModel:model];
        [self addSubview:itemView];
        [itemViews addObject:itemView];
        
    }
    
    EHINewItineraryMessagesItemView *preObj;
    for (int i = 0; i < itemViews.count; i++) {
        EHINewItineraryMessagesItemView *obj = itemViews[i];
        if (i == 0) {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.top.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.height.mas_greaterThanOrEqualTo(autoHeightOf6(38));
            }];
            preObj = obj;
            continue;
        }
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(preObj);
            make.top.equalTo(preObj.mas_bottom).with.offset(0);
        }];
        preObj = obj;
    }
    
    [itemViews.lastObject mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
    }];
    
    self.itemViews = itemViews;
}

@end
