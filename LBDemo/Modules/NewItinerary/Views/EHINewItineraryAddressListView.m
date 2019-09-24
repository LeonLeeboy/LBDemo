//
//  EHINewItineraryAddressListView.m
//  LBDemo
//
//  Created by 李兵 on 2019/9/20.
//  Copyright © 2019 ivan. All rights reserved.
//
//  我的行程列表 每个cell 中的 开始地址，停靠点，结束地址 List
//

#import "EHINewItineraryAddressListView.h"
#import "EHINewItineraryRender.h"

@interface EHINewItineraryAddressListItemView ()

@property (nonatomic, strong) YYLabel *valueLab;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UIView *verticalLineView;

@end


@implementation EHINewItineraryAddressListItemView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self addSubview:self.verticalLineView];
    [self addSubview:self.valueLab];
    [self addSubview:self.iconImageView];
    
    [self layoutViews];
}

- (void)layoutViews {
    [_valueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kInterItemSpace());
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-autoHeightOf6(16));
        make.right.mas_equalTo(0);
    }];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_greaterThanOrEqualTo(1);
        make.top.mas_equalTo(autoHeightOf6(2.5));
        make.centerX.equalTo(self.valueLab.mas_left).with.offset(-kInterItemSpaceBetweenDotAndLabel());
    }];
    
    
}

#pragma mark - public
- (void)renderViewWithIconImage:(UIImage *)iconImage
                 attributedText:(NSAttributedString *)attributedText
                      lineStyle:(EHIAddressListVerticalLineStyle)lineStyle {
    
    [self renderViewWithIconImage:iconImage
                   attributedText:attributedText
                        lineStyle:lineStyle verticalLineWidth:1];
   
}


- (void)renderViewWithIconImage:(UIImage *)iconImage
                 attributedText:(NSAttributedString *)attributedText
                      lineStyle:(EHIAddressListVerticalLineStyle)lineStyle
              verticalLineWidth:(CGFloat)verticalLineWidth {
    self.valueLab.attributedText = attributedText;
    
    self.iconImageView.image = iconImage;
    
    self.verticalLineView.backgroundColor = kEHIHexColor_333333;
    
    // layout
    switch (lineStyle) {
        case EHIAddressListVerticalLineStyleUp: {
            [_verticalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.width.mas_equalTo(verticalLineWidth);
                make.centerX.equalTo(self.valueLab.mas_left).with.offset(-kInterItemSpaceBetweenDotAndLabel());
                make.bottom.equalTo(self.iconImageView.mas_top);
            }];
        }
            break;
        case EHIAddressListVerticalLineStyleDown: {
            [_verticalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.iconImageView.mas_bottom);
                make.width.mas_equalTo(verticalLineWidth);
                make.centerX.equalTo(self.valueLab.mas_left).with.offset(-kInterItemSpaceBetweenDotAndLabel());
                make.bottom.mas_equalTo(0);
            }];
        }
            break;
            
        case EHIAddressListVerticalLineStyleFull: {
            [_verticalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.width.mas_equalTo(verticalLineWidth);
                make.centerX.equalTo(self.valueLab.mas_left).with.offset(-kInterItemSpaceBetweenDotAndLabel());
                make.bottom.mas_equalTo(0);
            }];
        }
            break;
    }
}

#pragma mark - private
/** 创建一个Label */
- (YYLabel *)p_createLabel {
    
    YYLabel *lab = [[YYLabel alloc] init];
    lab.numberOfLines = 0;
    lab.backgroundColor = [UIColor clearColor];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.text = @"  ";
    
    return lab;
}

#pragma mark - Getter && Setter

- (YYLabel *)valueLab {
    if (!_valueLab) {
        YYLabel *lab = [self p_createLabel];
        _valueLab = lab;
    }
    return _valueLab;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeCenter;
        _iconImageView = imageView;
    }
    return _iconImageView;
}

- (UIView *)verticalLineView {
    if (!_verticalLineView) {
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = kEHIHexColor_EEEEEE;
        
        _verticalLineView = line;
    }
    return _verticalLineView;
}

@end


#pragma mark - 
@interface EHINewItineraryAddressListView ()

/** begin address */
@property (nonatomic, strong) EHINewItineraryAddressListItemView *beginAddressItem;

/** end address */
@property (nonatomic, strong) EHINewItineraryAddressListItemView *endAddressItem;

/** 停靠点 labels */
@property (nonatomic, strong) NSArray<EHINewItineraryAddressListItemView *> *stopArressItemViews;

#pragma mark 暂存属性

@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation EHINewItineraryAddressListView


#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
    [self addSubview:self.beginAddressItem];
    [self addSubview:self.endAddressItem];
    [self addSubview:self.bottomLine];
    
    [self layoutViews];
}

- (void)layoutViews {
    // layout
    [_beginAddressItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
    }];
    
    [_endAddressItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-1);
        make.left.equalTo(self.beginAddressItem);
        make.right.equalTo(self.beginAddressItem);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.endAddressItem.mas_bottom);
        make.height.mas_equalTo(1);
        make.left.equalTo(self.endAddressItem);
        make.right.mas_equalTo(0);
    }];
    
}

#pragma mark - public
- (void)renderViewWithBeginAddressModel:(id)beginAddressModel endAddressModel:(id)endAddressModel stops:(NSArray<NSString *> *)stops {
    if (!self.stopArressItemViews && self.stopArressItemViews.count) {
        for (EHINewItineraryAddressListItemView *obj in self.stopArressItemViews) {
            [obj removeFromSuperview];
        }
    }
    
    EHINewItineraryType type = (stops.count > 0) ? EHINewItineraryTypeChauffeur : EHINewItineraryTypeSelfDriving;
    
    NSAttributedString *begigAddressAttributed = [self
                                                  p_createBeginAndEndAttributedStringWithTitle:(type == EHINewItineraryTypeChauffeur)?@"上车地点":@"取车地点"
                                                  address:@"上海"
                                                  shop:@"华宏商务中心"];
    NSAttributedString *endAddressAttributed = [self
                                                p_createBeginAndEndAttributedStringWithTitle:(type == EHINewItineraryTypeChauffeur)?@"到达地点":@"还车地点"
                                                address:@"上海"
                                                shop:@"虹桥国际机场"];
    
    [self.beginAddressItem renderViewWithIconImage:[self p_createBeginCycleImage]
                                    attributedText:begigAddressAttributed
                                         lineStyle:EHIAddressListVerticalLineStyleDown];
    
    [self.endAddressItem renderViewWithIconImage:[self p_createEndCycleImage]
                                  attributedText:endAddressAttributed
                                       lineStyle:EHIAddressListVerticalLineStyleUp];
    
    if (!stops || stops.count <= 0) { // 没有停靠点
        [_endAddressItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.beginAddressItem.mas_bottom).with.offset(autoHeightOf6(16));
        }];
        return;
    }
    
    // continue 有停靠点 ，专车
    NSMutableArray *stopAddressListItems = [NSMutableArray arrayWithCapacity:stops.count];
    for (int i = 0; i < stops.count; i++) {
        EHINewItineraryAddressListItemView *obj = [self p_createAdressListItemView];
        
        [obj renderViewWithIconImage:[self p_createStopCycleImage]
                      attributedText:[self p_createStopAttributedWithStop:stops[i] index:i]
                           lineStyle:EHIAddressListVerticalLineStyleFull];
        [self addSubview:obj];
        [stopAddressListItems addObject:obj];
    }
    self.stopArressItemViews = stopAddressListItems;
    
    //layout
    UIView *preObj;
    for (int i = 0; i < stopAddressListItems.count; i++) {
        UIView *obj = stopAddressListItems[i];
        if (i == 0) {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.beginAddressItem);
                make.top.equalTo(self.beginAddressItem.mas_bottom);
                make.right.equalTo(self.beginAddressItem);
            }];
            preObj = obj;
            continue;
        }
        
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(preObj);
            make.top.equalTo(preObj.mas_bottom);
        }];
        
        preObj = obj;
    }
    
    [stopAddressListItems.lastObject mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.endAddressItem.mas_top);
    }];
    
}

#pragma mark - private

/**
 创建 开始地址，结束地址 attibutedString
 
 @param title 取车地址，还车地址，取车地点，还车地点
 @param address 上海
 @param shop 南山寺便捷点
 @return 对应UI的 attributedString
 */
- (NSMutableAttributedString *)p_createBeginAndEndAttributedStringWithTitle:(NSString *)title address:(NSString *)address shop:(NSString *)shop {
    
    NSMutableAttributedString *rst = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString *titleDes = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",title]];
    NSMutableAttributedString *addressValue = [[NSMutableAttributedString alloc] initWithString:address];
    NSMutableAttributedString *lineValue = [[NSMutableAttributedString alloc] initWithString:@" - "];
    NSMutableAttributedString *shopValue = [[NSMutableAttributedString alloc] initWithString:shop];
    
    titleDes.font = autoFONT(12);
    titleDes.color = kEHIHexColor_7B7B7B;
    
    addressValue.font = autoBoldFONT(16);
    addressValue.color = kEHIHexColor_333333;
    
    lineValue.font = autoFONT(16);
    lineValue.color = kEHIHexColor_7B7B7B;
    
    shopValue.font = autoBoldFONT(16);
    shopValue.color = kEHIHexColor_333333;
    
    [rst appendAttributedString:titleDes];
    [rst appendAttributedString:addressValue];
    [rst appendAttributedString:lineValue];
    [rst appendAttributedString:shopValue];
    rst.lineSpacing = 8;
    
    return rst;
}

/** 停靠点 attributed string */
- (NSMutableAttributedString *)p_createStopAttributedWithStop:(NSString *)stop index:(NSInteger)index {
    NSMutableAttributedString *rst = [[NSMutableAttributedString alloc] init];
    
    NSMutableAttributedString *stopDes = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"停靠%ld",(long)index + 1]];
    NSMutableAttributedString *lineValue = [[NSMutableAttributedString alloc] initWithString:@" - "];
    
    NSMutableAttributedString *addressValue = [[NSMutableAttributedString alloc] initWithString:stop];
    
    stopDes.font = autoFONT(14);
    stopDes.color = kEHIHexColor_FF7E00;
    
    lineValue.font = autoFONT(14);
    lineValue.color = kEHIHexColor_7B7B7B;
    
    addressValue.font = autoFONT(14);
    addressValue.color = kEHIHexColor_FF7E00;
    
    [rst appendAttributedString:stopDes];
    [rst appendAttributedString:lineValue];
    [rst appendAttributedString:addressValue];
    
    return rst;
}

/** 开始地点的圆 */
- (UIImage *)p_createBeginCycleImage {
    UIImage *img = [EHINewItineraryRender getImageWithColor:kEHIHexColor_FF7E00 contentColor:nil imageSize:CGSizeMake(7, 7) contentSize:CGSizeZero];
    return img;
}

/** 结束地点的圆 */
- (UIImage *)p_createEndCycleImage {
    UIImage *img = [EHINewItineraryRender getImageWithColor:kEHIHexColor_29B7B7 contentColor:nil imageSize:CGSizeMake(7, 7) contentSize:CGSizeZero];
    return img;
}

/** 停靠点的圆 */
- (UIImage *)p_createStopCycleImage {
    UIImage *img = [EHINewItineraryRender getImageWithColor:kEHIHexColor_646774 contentColor:kEHIHexColor_FFFFFF imageSize:CGSizeMake(10, 10) contentSize:CGSizeMake(5, 5)];
    return img;
}

/** 创建一个list item */
- (EHINewItineraryAddressListItemView *)p_createAdressListItemView {
    EHINewItineraryAddressListItemView *itemView = [[EHINewItineraryAddressListItemView alloc] init];
    
    return itemView;
}

#pragma mark - Getter && Setter

- (EHINewItineraryAddressListItemView *)beginAddressItem {
    if (!_beginAddressItem) {
        _beginAddressItem = [self p_createAdressListItemView];
    }
    return _beginAddressItem;
}

- (EHINewItineraryAddressListItemView *)endAddressItem {
    if (!_endAddressItem) {
        _endAddressItem = [self p_createAdressListItemView];
    }
    return _endAddressItem;
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
