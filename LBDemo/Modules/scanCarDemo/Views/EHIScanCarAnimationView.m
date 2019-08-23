//
//  EHIScanCarAnimationView.m
//  LBDemo
//
//  Created by 李兵 on 2019/8/23.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "EHIScanCarAnimationView.h"

static CGFloat kDefaultDuration = 4;

@implementation EHIScanCarAnimationModel

@end
#pragma mark -

@interface EHIScanCarAnimationView ()

/** 内容 */
@property (nonatomic, strong) UIImageView *normalBackGroundImageView;

@property (nonatomic, strong) UIImageView *highLightedBackGroundImageView;

@property (nonatomic, strong) UIImageView *scanLineImageView;

@property (nonatomic, strong) CALayer *highLightedBackGroundImageLayer;

@property (nonatomic, strong) UIView *hightBackGroundView;

@property (nonatomic, strong) EHIScanCarAnimationModel *model;

@end

@implementation EHIScanCarAnimationView

#pragma mark life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self prepareData];
        
        [self setupSubViews];
        
        [self renderViewWithModel:self.model];;
    }
    
    return self;
}

- (void)prepareData {
    self.model = [[EHIScanCarAnimationModel alloc] init];
    self.model.normalBackGroundImage = [UIImage imageNamed:@"hicar_scan_Normal"];
    self.model.highLightedBackGroundImage = [UIImage imageNamed:@"hicar_scan_highLighted"];
    self.model.scanLineImage = [UIImage imageNamed:@"hicar_scan_line"];
}

- (void)setupSubViews {
    [self addSubview:self.normalBackGroundImageView];
    [self addSubview:self.hightBackGroundView];
    [self addSubview:self.scanLineImageView];
    
    [self layoutViews];
}

- (void)layoutViews {
    [_normalBackGroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_hightBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_highLightedBackGroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [_scanLineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_top);
        make.width.equalTo(self);
        make.height.mas_equalTo(27);
    }];
}

#pragma mark public
- (void)renderViewWithModel:(EHIScanCarAnimationModel *)model {
    self.model = model;
    
    self.normalBackGroundImageView.image = model.normalBackGroundImage;
    self.highLightedBackGroundImageView.image = model.highLightedBackGroundImage;
    self.scanLineImageView.image = model.scanLineImage;
}

- (void)starAnimation {
    //扫描线的动画
    [self p_scanLineAnimation];
    
    //高亮图片的动画
    [self p_highLightedAnimation];
}

#pragma mark private


- (void)p_scanLineAnimation {
    POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    positionAnimation.fromValue = @(0);
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    positionAnimation.toValue = @(self.height);
    positionAnimation.duration = self.model.duration?:kDefaultDuration;
    positionAnimation.repeatCount= MAXFLOAT;
    positionAnimation.beginTime = CACurrentMediaTime();
    [self.scanLineImageView.layer pop_addAnimation:positionAnimation forKey:@"scanLinePositionAnimation"];
}

- (void)p_highLightedAnimation {
    POPBasicAnimation *basicAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
    basicAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, self.width, 0)];
    basicAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, self.width, self.height)];
    basicAnimation.duration = self.model.duration?:kDefaultDuration;
    basicAnimation.repeatCount = MAXFLOAT;
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    basicAnimation.beginTime = CACurrentMediaTime();
    [self.hightBackGroundView.layer pop_addAnimation:basicAnimation forKey:@"basicAnimationa"];
    
}


#pragma mark getter && setter

- (UIImageView *)normalBackGroundImageView {
    if (!_normalBackGroundImageView) {
        _normalBackGroundImageView = [[UIImageView alloc] initWithImage:self.model.normalBackGroundImage?:[UIImage imageNamed:@"hicar_empty"]];
        _normalBackGroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _normalBackGroundImageView;
}

- (UIImageView *)highLightedBackGroundImageView {
    if (!_highLightedBackGroundImageView) {
        _highLightedBackGroundImageView = [[UIImageView alloc] initWithImage:self.model.highLightedBackGroundImage?:[UIImage imageNamed:@"hicar_empty"]];
        _highLightedBackGroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _highLightedBackGroundImageView;
}

- (UIImageView *)scanLineImageView {
    if (!_scanLineImageView) {
        _scanLineImageView = [[UIImageView alloc] initWithImage:self.model.scanLineImage?:[UIImage imageNamed:@"hicar_empty"]];
        _scanLineImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _scanLineImageView;
}


- (UIView *)hightBackGroundView {
    if (!_hightBackGroundView) {
        _hightBackGroundView = [[UIView alloc] init];
        [_hightBackGroundView addSubview:self.highLightedBackGroundImageView];
        _hightBackGroundView.layer.masksToBounds = YES;

    }
    return _hightBackGroundView;
}

@end
