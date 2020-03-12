//
//  EHICalendarCollecitionCell.m
//  LBDemo
//
//  Created by 李兵 on 2020/3/9.
//  Copyright © 2020 ivan. All rights reserved.
//

#import "EHICalendarCollecitionCell.h"
#import "EHICalendarDayCellViewModel.h"
#import "EHICalendarDayModel.h"

@interface EHICalendarCollecitionCell ()

@property (nonatomic, strong) UILabel *textLab;

@property (nonatomic, strong) UILabel *desLab;

@property (nonatomic, strong) EHICalendarDayCellViewModel *cellVm;

#pragma mark - 暂存属性
@property (nonatomic, strong) CALayer *leftLayer;

@property (nonatomic, strong) CALayer *rightLayer;

@property (nonatomic, strong) CALayer *textBgLayer;

@property (nonatomic, strong) CALayer *cycleLayer;

@end

@implementation EHICalendarCollecitionCell

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
    [self.contentView addSubview:self.textLab];
    
    [self.contentView addSubview:self.desLab];
    
    [self layoutViews];
}

- (void)layoutViews {
    [_textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(disPlayTextHeight());
        make.top.equalTo(self.contentView).with.offset(disPlayTextTop());
        make.centerX.equalTo(self.contentView);
    }];
    
    [_desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(3);
        make.right.mas_equalTo(-3);
        make.top.equalTo(self.textLab.mas_bottom);
    }];
}

#pragma mark - public
- (void)seed_cellWithData:(EHICalendarDayCellViewModel *)itemModel {
    self.cellVm = itemModel;
 
    switch (itemModel.identityType) {
        case EHICalendarDayCellTypeNormal:  // 正常显示
        case EHICalendarDayCellTypeDisabled:
        case EHICalendarDayCellTypeEmpty:
        case EHICalendarDayCellTypeLeftRightConcidence: {
            [self p_dealCycleLayer];
        }
            break;
        case EHICalendarDayCellTypeLeftCorner: {
            [self p_dealRightLayerWithColor:self.cellVm.layerColor];
            [self p_dealCycleLayer];
        }
            break;
        case EHICalendarDayCellTypeRightCoorner: {
            [self p_dealLeftLayerWithColor:self.cellVm.layerColor];
            [self p_dealCycleLayer];
        }
            break;
        case EHICalendarDayCellTypeIntecellLeft: { // 开始 结束时间切圆 cell 中间 左边切圆cell
            [self p_dealRightLayerWithColor:self.cellVm.layerColor];
        }
            break;
        case EHICalendarDayCellTypeIntecellRight: { // 开始 结束时间切圆 cell 中间 右边边切圆cell
            [self p_dealLeftLayerWithColor:self.cellVm.layerColor];
        }
            break;
            
        case EHICalendarDayCellTypeIntecellNomal: { // 开始 结束时间切圆 cell 中间 正常
            [self p_dealFullLayer];
        }
            break;
        default:
            break;
    }
    
     self.textLab.attributedText = itemModel.displayAttributed;
     self.desLab.attributedText = itemModel.desDisplayAttributed;
    
    
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self p_clearLayer];
}

#pragma mark - private
/** 创建一个Label */
- (UILabel *)p_createLabel {
    UILabel *lab = [[UILabel alloc] init];
    lab.numberOfLines = 1;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = kLBAPPHexColor_FFFFFF;
    lab.font = autoFONT(18);
    lab.text = @"";
    return lab;
}

/** 处理开口向左 */
- (void)p_dealLeftLayerWithColor:(UIColor *)color {

    CGFloat leftAndRight = (self.bounds.size.width - disPlayTextHeight()) * 0.5;
    CGFloat h = disPlayTextHeight();
    CGFloat w = leftAndRight + disPlayTextHeight();
    CGFloat radius = h / 2.0;
    CGRect frame = CGRectMake(0, disPlayTextTop(), w, h);
      
    CGRect pathFrame = CGRectMake(0, 0, w, h);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *mask = [[CAShapeLayer alloc] init];
    mask.path = path.CGPath;
    
    CALayer *layer = [[CALayer alloc] init];
    layer.mask = mask;
    layer.frame = frame;
    layer.backgroundColor = color.CGColor;
      
    [self.contentView.layer insertSublayer:layer below:self.textLab.layer];
    self.leftLayer = layer;
}

/** 开口向右 */
- (void)p_dealRightLayerWithColor:(UIColor *)color {
    
    
    CGFloat h = disPlayTextHeight();
    CGFloat leftAndRight = (self.bounds.size.width - disPlayTextHeight()) * 0.5;
    CGFloat w = self.bounds.size.width - leftAndRight;
    CGFloat radius = h / 2.0;
    
    CGRect frame = CGRectMake(leftAndRight, disPlayTextTop(), w, h);
    
    CGRect pathFrame = CGRectMake(0, 0, w, h);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *mask = [[CAShapeLayer alloc] init];
    mask.path = path.CGPath;
    
    CALayer *layer = [[CALayer alloc] init];
    layer.mask = mask;
    layer.frame = frame;
    layer.backgroundColor = color.CGColor;
    
    [self.contentView.layer insertSublayer:layer below:self.textLab.layer];
    self.rightLayer = layer;
}

- (void)p_dealFullLayer {
    CALayer *layer = [[CALayer alloc] init];
    [self.contentView.layer insertSublayer:layer below:self.textLab.layer];
    CGFloat h = disPlayTextHeight();
    layer.frame = CGRectMake(0,disPlayTextTop(), self.bounds.size.width, h);
    layer.backgroundColor = self.cellVm.layerColor.CGColor;
    self.textBgLayer = layer;
}

- (void)p_dealCycleLayer {
    CALayer *layer = [[CALayer alloc] init];
    [self.contentView.layer insertSublayer:layer atIndex:0];
    [self.contentView.layer insertSublayer:layer below:self.textLab.layer];
    CGFloat h = disPlayTextHeight();
    CGFloat leftAndRight = (self.bounds.size.width - disPlayTextHeight()) * 0.5;
    layer.frame = CGRectMake(leftAndRight, disPlayTextTop(), h, h);
    layer.backgroundColor = self.cellVm.cycleColor.CGColor;
    layer.cornerRadius = layer.frame.size.width * 0.5;
    self.cycleLayer = layer;
}

- (void)p_clearLayer {
    if (self.rightLayer) {
        [self.rightLayer removeFromSuperlayer];
        self.rightLayer = nil;
    }
    
    if (self.leftLayer) {
        [self.leftLayer removeFromSuperlayer];
        self.leftLayer = nil;
    }
    
    if (self.textBgLayer) {
        [self.textBgLayer removeFromSuperlayer];
        self.textBgLayer = nil;
    }
    
    if (self.cycleLayer) {
        [self.cycleLayer removeFromSuperlayer];
        self.cycleLayer = nil;
    }
}

#pragma mark - Getter && Setter
- (UILabel *)textLab {
    if(!_textLab) {
        UILabel *lab = [self p_createLabel];
        lab.text = @"";
        _textLab = lab;
    }
    return _textLab;
}

- (UILabel *)desLab {
    if(!_desLab) {
        UILabel *lab = [self p_createLabel];
        lab.text = @"";
        lab.font = autoFONT(12);
        _desLab = lab;
    }
    return _desLab;
}


@end
