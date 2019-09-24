//
//  EHIUpdateAppContentView.m
//  LBDemo
//
//  Created by 李兵 on 2019/9/12.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "EHIUpdateAppContentView.h"

static CGFloat MediumViewHeight() {
    return autoHeightOf6(160);
}

@interface EHIUpdateAppContentView ()

/** 顶部图片 */
@property (nonatomic, strong) UIView *topView;

/** 中间内容View */
@property (nonatomic, strong) UIView *mediumView;

/** 底部 */
@property (nonatomic, strong) UIView *bottomView;

/** 裁剪layer的mask */
@property (nonatomic, strong) CAShapeLayer *maskLayer;


@end

@implementation EHIUpdateAppContentView


#pragma mark - 构造函数
- (instancetype)initWithUpdateWay:(EHIUpdateAppWay)updateWay {
    if (self = [super initWithFrame:CGRectZero]) {
        [self setupSubViewsWithType:updateWay];
    }
    return self;
}

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViewsWithType:EHIUpdateAppWayNoForce];
    }
    return self;
}

- (void)setupSubViewsWithType:(EHIUpdateAppWay)updateWay {
    [self addSubview:self.topView];
    
    [self p_createMediumView];
    
    self.bottomView = [self p_createBottomViewWithUpdateWay:updateWay];
    [self addSubview:self.bottomView];
    
    [self layoutViews];
    
}

- (void)layoutViews {
    // 宽高在创建view时候图片撑开
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).with.offset(MediumViewHeight());
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(autoHeightOf6(71));
    }];
    
}

#pragma mark - Action
/** 立即更新 */
- (void)doNowUpdateAppAction {
    if (self.updateNowAction) {
        self.updateNowAction();
    }
}

/** 下次再说 */
- (void)doCancleAction {
    if (self.nextTimeAction) {
        self.nextTimeAction();
    }
}

#pragma mark - public
- (void)renderViewWithTips:(NSArray<NSString *> *)tips {
    //移除所有子 view
    if (self.mediumView.subviews.count > 0) {
        [self.mediumView removeAllSubviews];
    }
    
    if (!tips || tips.count <= 0) {
        return;
    }
    NSMutableArray<YYLabel *> *labels = [NSMutableArray array];
    for (NSString *obj in tips) {
       YYLabel *lab = [self p_createContentLabelWithString:obj];
        [self.mediumView addSubview:lab];
        [labels addObject:lab];
    }
    
    YYLabel *preViousObj;
    for (int i = 0; i < labels.count; i++) {
        YYLabel *obj = labels[i];
        if (i == 0) {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.left.mas_equalTo(20);
                make.right.mas_equalTo(-20);
            }];
            preViousObj = obj;
            continue;
        }
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(preViousObj.mas_bottom).with.offset(autoHeightOf6(4));
            make.left.right.mas_equalTo(preViousObj);
        }];
        preViousObj = obj;
    }
    
    [preViousObj mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
    }];
}

#pragma mark - private
- (void)p_createMediumView {
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    UIView *contentV = [[UIView alloc] init];
    contentV.backgroundColor = kEHIHexColor_FFFFFF;
    contentScrollView.backgroundColor = kEHIHexColor_FFFFFF;
    
    [self addSubview:contentScrollView];
    [contentScrollView addSubview:contentV];
    
    [contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.topView.mas_bottom);
        make.height.mas_equalTo(MediumViewHeight());
    }];
    
    [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.width.equalTo(contentScrollView);
        make.height.mas_greaterThanOrEqualTo(contentScrollView);
    }];
    
    self.mediumView = contentV;
}

- (YYLabel *)p_createContentLabelWithString:(NSString *)title {
    YYLabel *contentLabel = [[YYLabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.preferredMaxLayoutWidth = 255;
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.textColor = kEHIHexColor_333333;
    contentLabel.font = autoFONT(14);
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.text = title;
    return contentLabel;
}

/** 创建底部View */
- (UIView *)p_createBottomViewWithUpdateWay:(EHIUpdateAppWay)updateWay {
    UIView *rstView = [[UIView alloc] init];// 防止崩溃，理论上无虞
    switch (updateWay) {
        case EHIUpdateAppWayNoForce: { //非强制更新View
            rstView = [self p_createNoForceBottomView];
        }
            break;
        case EHIUpdateAppWayForce: { //强制更新View
            rstView = [self p_createForceBottomView];
        }
            break;
    }
    rstView.backgroundColor = kEHIHexColor_FFFFFF;
    return rstView;
}

/** 强制更新底部 view */
- (UIView *)p_createForceBottomView {
    CGFloat buttonWidth = autoWidthOf6(134);
    CGFloat buttonHeight = autoHeightOf6(38);
    
    UIView *contentV = [[UIView alloc] init];
    
    // 立即更新
    UIButton *updateNowBtn = [self p_createButtonWithBackGroundColor:kEHIHexColor_FF7E00 title:@"立即更新" textColor:kEHIHexColor_FFFFFF borderWidth:0 borderColor:kEHIHexColor_FF7E00];
    
    [contentV addSubview:updateNowBtn];
    
    [updateNowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(buttonWidth);
        make.height.mas_equalTo(buttonHeight);
        make.center.equalTo(updateNowBtn.superview);
    }];
    [updateNowBtn addTarget:self action:@selector(doNowUpdateAppAction) forControlEvents:UIControlEventTouchUpInside];
    
    return contentV;
}

/** 非强制更新底部 view */
- (UIView *)p_createNoForceBottomView {
    
    CGFloat buttonWidth = autoWidthOf6(100);
    CGFloat buttonHeight = autoHeightOf6(38);
    //两个button 之间的距离
    CGFloat innerItemSpace = 20;
    // “下次再说” 按钮 向左偏移的value值
    CGFloat cancelButtonOffset = (innerItemSpace + buttonWidth) / 2.0;
    
    UIView *contentV = [[UIView alloc] init];
    
    // 下次再说
    UIButton *cancleBtn = [self p_createButtonWithBackGroundColor:kEHIHexColor_FFFFFF title:@"下次再说" textColor:kEHIHexColor_333333 borderWidth:1 borderColor:kEHIHexColor_CCCCCC];
    // 立即更新
    UIButton *updateNowBtn = [self p_createButtonWithBackGroundColor:kEHIHexColor_FF7E00 title:@"立即更新" textColor:kEHIHexColor_FFFFFF borderWidth:0 borderColor:kEHIHexColor_FF7E00];
    
    // add
    [contentV addSubview:cancleBtn];
    [contentV addSubview:updateNowBtn];
    
   //layout
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(buttonWidth);
        make.height.mas_equalTo(buttonHeight);
        make.centerY.equalTo(cancleBtn.superview);
        make.centerX.equalTo(cancleBtn.superview).with.offset(-cancelButtonOffset);
    }];
    [updateNowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(buttonWidth);
        make.height.mas_equalTo(buttonHeight);
        make.centerY.equalTo(cancleBtn.superview);
        make.left.mas_equalTo(cancleBtn.mas_right).with.offset(innerItemSpace);
    }];
    
    //event
     [updateNowBtn addTarget:self action:@selector(doNowUpdateAppAction) forControlEvents:UIControlEventTouchUpInside];
     [cancleBtn addTarget:self action:@selector(doCancleAction) forControlEvents:UIControlEventTouchUpInside];
    
     return contentV;
}

/** 创建一个Button */
- (UIButton *)p_createButtonWithBackGroundColor:(UIColor *)bgColor title:(NSString *)title textColor:(UIColor *)textColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    btn.titleLabel.font = autoFONT(16);
    [btn setBackgroundImage:[UIImage imageWithColor:bgColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.layer.cornerRadius = 19;
    btn.layer.borderWidth = borderWidth;
    btn.layer.borderColor = borderColor.CGColor;
    btn.layer.masksToBounds = YES;
    return btn;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bottomView.layer.mask = self.maskLayer;
}


#pragma mark - Getter

- (UIView *)topView {
    if (!_topView) {
        UIView *contentV = [[UIView alloc] init];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"helper_updateApp_top_bgView"];
        
        UILabel *topTipLable = [[UILabel alloc] init];
        topTipLable  = [[UILabel alloc] init];
        topTipLable.numberOfLines = 0;
        topTipLable.backgroundColor = [UIColor clearColor];
        topTipLable.textColor = kEHIHexColor_FF7E00;
        topTipLable.font = autoFONT(17);
        topTipLable.textAlignment = NSTextAlignmentCenter;
        topTipLable.text = @"发现新版本";
        
        [contentV addSubview:imageView];
        [contentV addSubview:topTipLable];
        
        // layout
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
            make.width.mas_equalTo(imageView.image.size.width);
            make.height.mas_equalTo(imageView.image.size.height);
        }];
        
        [topTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(topTipLable.superview);
            make.bottom.mas_equalTo(-autoHeightOf6(8));
        }];
        
        _topView = contentV;
    }
    return _topView;
}

- (CAShapeLayer *)maskLayer {
    if (!_maskLayer) {
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8, 8)];
        
        //创建 layer
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] initWithLayer:self.bottomView.layer];
        maskLayer.frame = self.bounds;
        
        //赋值
        maskLayer.path = bezierPath.CGPath;
        _maskLayer = maskLayer;
    }
    return _maskLayer;
}


@end
