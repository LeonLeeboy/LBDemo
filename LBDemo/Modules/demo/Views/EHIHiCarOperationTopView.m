//
//  EHIHiCarOperationTopView.m
//  LBDemo
//
//  Created by 李兵 on 2019/8/12.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "EHIHiCarOperationTopView.h"


@implementation EHIHiCarOperationTopModel
@end

#pragma mark -

@interface EHIHiCarOperationTopView ()

/** carImage */
@property (nonatomic, strong) UIImageView *carImageView;

/** carName */
@property (nonatomic, strong) UILabel *carNameLabel;

/** carSite */
@property (nonatomic, strong) UILabel *carSiteLabel;

/** getCartime */
@property (nonatomic, strong) UILabel *getCartimeLabel;

/** location */
@property (nonatomic, strong) UILabel *locationLabel;

/** locationDetail */
@property (nonatomic, strong) UILabel *locationDetailLabel;

/** phoneButton */
@property (nonatomic, strong) UIButton *phoneButton;

/**  */
@property (nonatomic, strong) CAShapeLayer *maskLayer;

@property (nonatomic, strong) UIView *contentView;

@end

@implementation EHIHiCarOperationTopView

#pragma mark life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self setupSubViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_maskLayer) {
        return;
    }
   self.contentView.layer.mask = self.maskLayer;
    
}

- (void)setupSubViews {
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = kEHIHexColor_FFFFFF;
    UIControl *getCarDetailControl = [self p_getCarDetailView];
    UIImageView *locationImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"usedcar_detail_location_icon"]];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = kEHIHexColor_EEEEEE;
    
    self.contentView = contentView;
    
    [self addSubview:contentView];
    [contentView addSubview:self.carImageView];
    [contentView addSubview:getCarDetailControl];
    [contentView addSubview:self.carNameLabel];
    [contentView addSubview:self.carSiteLabel];
    [contentView addSubview:self.getCartimeLabel];
    [contentView addSubview:line];
    [contentView addSubview:locationImageView];
    [contentView addSubview:self.locationLabel];
    [contentView addSubview:self.locationDetailLabel];
    [contentView addSubview:self.phoneButton];
    
    [getCarDetailControl addTarget:self action:@selector(didClickCarDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(contentView.superview);
    }];
    [_carImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(autoWidthOf6(113));
        make.height.mas_equalTo(autoHeightOf6(71));
        make.left.mas_equalTo(autoWidthOf6(49));
        make.top.mas_equalTo(0);
    }];
    [getCarDetailControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.carImageView);
        make.top.equalTo(self.carImageView.mas_bottom);
    }];
    
    [_carNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.carImageView.mas_right).with.offset(autoWidthOf6(31));
        make.width.mas_greaterThanOrEqualTo(autoWidthOf6(65));
        make.height.mas_greaterThanOrEqualTo(autoHeightOf6(24));
        make.top.mas_equalTo(autoHeightOf6(8));
    }];
    
    [_carSiteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.carNameLabel);
        make.top.equalTo(self.carNameLabel.mas_bottom).with.offset(autoHeightOf6(3));
        make.width.mas_greaterThanOrEqualTo(autoWidthOf6(50));
        make.height.mas_greaterThanOrEqualTo(autoHeightOf6(17));
    }];
    
    [_getCartimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.carNameLabel);
        make.top.equalTo(self.carSiteLabel.mas_bottom).with.offset(autoHeightOf6(5));
        make.right.mas_equalTo(-autoWidthOf6(25));
        make.width.mas_greaterThanOrEqualTo(autoWidthOf6(50));
        make.height.mas_greaterThanOrEqualTo(autoHeightOf6(17));
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(autoWidthOf6(21));
        make.right.mas_equalTo(-autoHeightOf6(21));
        make.height.mas_equalTo(1);
        make.top.greaterThanOrEqualTo(getCarDetailControl.mas_bottom).with.offset(autoHeightOf6(15));
        make.top.greaterThanOrEqualTo(self.getCartimeLabel.mas_bottom).with.offset(autoHeightOf6(15));
    }];
    
    [locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(autoWidthOf6(34));
        make.top.equalTo(line.mas_bottom).with.offset(autoHeightOf6(15));
        make.width.mas_equalTo(autoWidthOf6(12));
        make.height.mas_equalTo(autoHeightOf6(15));
    }];
    
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(locationImageView.mas_right).with.offset(autoWidthOf6(6));
        make.centerY.equalTo(locationImageView.mas_centerY);
        make.width.mas_lessThanOrEqualTo(autoWidthOf6(251));
        make.height.mas_greaterThanOrEqualTo(autoHeightOf6(17));
    }];
    
    [_locationDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.locationLabel);
        make.top.equalTo(self.locationLabel.mas_bottom).with.offset(autoHeightOf6(5));
        make.height.mas_greaterThanOrEqualTo(autoHeightOf6(17));
        make.bottom.mas_equalTo(-autoHeightOf6(21));
    }];
    
    [_phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20);
        make.top.equalTo(line.mas_bottom).with.offset(autoHeightOf6(24));
        make.right.mas_equalTo(-autoWidthOf6(33));
    }];
    
}

#pragma mark public
- (void)renderViewWithModel:(EHIHiCarOperationTopModel *)model {
    self.carNameLabel.text = [self p_getSafeString:model.carName];
    self.carSiteLabel.text = [self p_getSafeString:model.carSiteInfo];
    self.getCartimeLabel.text = [self p_getSafeString:model.getCarTime];
    self.locationLabel.text = [self p_getSafeString:model.location];
    self.locationDetailLabel.text = [self p_getSafeString:model.locationDetail];
    [self.carImageView setImageURL:[NSURL URLWithString:model.carImageURLStr]];
}

#pragma mark Action
- (void)didClickPhone:(UIButton *)sender {
    if (self.didClickPhone) {
        self.didClickPhone();
    }
}

- (void)didClickCarDetail:(UIControl *)sender {
    if (self.didClickCarDetail) {
        self.didClickCarDetail();
    }
}

#pragma mark private
- (UIControl *)p_getCarDetailView {
    
    UIControl *carDetailControl = [[UIControl alloc] init];
    
    UILabel *lab = [[UILabel alloc] init];
    lab  = [[UILabel alloc] init];
    lab.numberOfLines = 0;
    lab.backgroundColor = [UIColor clearColor];
    lab.textColor = kEHIHexColor_333333;
    lab.font = autoFONT(12);
    lab.text = @"车辆详情";
    lab.textAlignment = NSTextAlignmentCenter;
   
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hicar_operation_arrow_icon"]];
    
    [carDetailControl addSubview:lab];
    [carDetailControl addSubview:imgView];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(autoWidthOf6(12));
        make.centerY.equalTo(lab);
        make.left.equalTo(lab.mas_right).with.offset(2);
        make.right.mas_equalTo(0);
    }];
    
    return carDetailControl;
}

- (NSString *)p_getSafeString:(NSString *)str {
    if (str.length==0 || !str) {
        return @"";
    }
    return [str copy];
}

#pragma mark getter
- (UIImageView *)carImageView {
    if (!_carImageView) {
        _carImageView = [[UIImageView alloc] init];
        
    }
    return _carImageView;
}


- (UILabel *)carNameLabel {
    if (!_carNameLabel) {
        _carNameLabel  = [[UILabel alloc] init];
        _carNameLabel.numberOfLines = 0;
        _carNameLabel.backgroundColor = [UIColor clearColor];
        _carNameLabel.textColor = kEHIHexColor_333333;
        _carNameLabel.font = autoBoldFONT(17);
        _carNameLabel.text = @"标致301";
        _carNameLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _carNameLabel;
}


- (UILabel *)carSiteLabel {
    if (!_carSiteLabel) {
        _carSiteLabel  = [[UILabel alloc] init];
        _carSiteLabel.numberOfLines = 0;
        _carSiteLabel.backgroundColor = [UIColor clearColor];
        _carSiteLabel.textColor = kEHIHexColor_333333;
        _carSiteLabel.font = autoFONT(12);
        _carSiteLabel.text = @"5座/自动";
        _carSiteLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _carSiteLabel;
}


- (UILabel *)getCartimeLabel {
    if (!_getCartimeLabel) {
        _getCartimeLabel  = [[UILabel alloc] init];
        _getCartimeLabel.numberOfLines = 0;
        _getCartimeLabel.backgroundColor = [UIColor clearColor];
        _getCartimeLabel.textColor = kEHIHexColor_333333;
        _getCartimeLabel.font = autoFONT(12);
        _getCartimeLabel.text = @"取车时间 2019.07.22 09:30";
        _getCartimeLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _getCartimeLabel;
}


- (UILabel *)locationLabel {
    if (!_locationLabel) {
        _locationLabel  = [[UILabel alloc] init];
        _locationLabel.numberOfLines = 0;
        _locationLabel.backgroundColor = [UIColor clearColor];
        _locationLabel.textColor = kEHIHexColor_333333;
        _locationLabel.font = autoBoldFONT(14);
        _locationLabel.text = @"上海 长宁区";
        _locationLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _locationLabel;
}


- (UILabel *)locationDetailLabel {
    if (!_locationDetailLabel) {
        _locationDetailLabel  = [[UILabel alloc] init];
        _locationDetailLabel.numberOfLines = 0;
        _locationDetailLabel.backgroundColor = [UIColor clearColor];
        //FIXME: 颜色原来系统没有
        _locationDetailLabel.textColor = kEHIHexColor_7B7B7B;
        _locationDetailLabel.font = autoFONT(11);
        _locationDetailLabel.text = @"古北路21号一层靠近古北路长宁路口…";
        _locationDetailLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _locationDetailLabel;
}

- (UIButton *)phoneButton {
    if (!_phoneButton) {
        _phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phoneButton setBackgroundColor:[UIColor clearColor]];
        [_phoneButton setBackgroundImage:[UIImage imageNamed:@"nearby_Call"] forState:UIControlStateNormal];
        [_phoneButton setBackgroundImage:[UIImage imageNamed:@"nearby_Call"] forState:UIControlStateHighlighted];
        [_phoneButton addTarget:self action:@selector(didClickPhone:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneButton;
}




- (CAShapeLayer *)maskLayer {
    if (!_maskLayer) {
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(15, 15)];
        
        //创建 layer
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] initWithLayer:self.contentView.layer];
        maskLayer.frame = self.bounds;
        
        //赋值
        maskLayer.path = bezierPath.CGPath;
        _maskLayer = maskLayer;
    }
    return _maskLayer;
}

@end
