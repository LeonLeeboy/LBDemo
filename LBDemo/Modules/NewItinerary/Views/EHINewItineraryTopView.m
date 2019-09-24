//
//  EHINewItineraryTopView.m
//  LBDemo
//
//  Created by 李兵 on 2019/9/20.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "EHINewItineraryTopView.h"

@interface EHINewItineraryTopView ()

/** begin address */
@property (nonatomic, strong) YYLabel *orderTitleLab;

/** end address */
@property (nonatomic, strong) YYLabel *getOntimeLab;

@end

@implementation EHINewItineraryTopView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kEHIHexColor_FF7E00;
        
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
    [self addSubview:self.orderTitleLab];
    [self addSubview:self.getOntimeLab];
    
    [self layoutViews];
}

- (void)layoutViews {
    [_orderTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(autoHeightOf6(12));
        make.bottom.mas_equalTo(-autoHeightOf6(18));
    }];
    
    [_getOntimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderTitleLab.mas_right);
        make.right.mas_equalTo(-autoWidthOf6(15));
        make.top.bottom.equalTo(self.orderTitleLab);
    }];
}

#pragma mark - public

- (void)renderViewWithOrderTitle:(NSString *)orderTitle getOnTime:(NSString *)getOntime getOnTimeLabHidden:(BOOL)getOnTimeLabHidden {
    
    self.getOntimeLab.hidden = getOnTimeLabHidden;
    
    self.orderTitleLab.text = @"专车-送机";
    self.getOntimeLab.text  = @"上车时间 07:00";
}

#pragma mark - private
/** 创建一个Label */
- (YYLabel *)p_createLabel {
    
    YYLabel *lab = [[YYLabel alloc] init];
    lab.numberOfLines = 0;
    lab.backgroundColor = [UIColor clearColor];
    lab.textColor = kEHIHexColor_FFFFFF;
    lab.text = @"  ";
    
    return lab;
}

#pragma mark - Getter && Setter
- (YYLabel *)getOntimeLab {
    if (!_getOntimeLab) {
        YYLabel *lab = [self p_createLabel];
        lab.font = autoFONT(12);
        _getOntimeLab = lab;
    }
    return _getOntimeLab;
}

- (YYLabel *)orderTitleLab {
    if (!_orderTitleLab) {
        YYLabel *lab = [self p_createLabel];
        lab.font = autoFONT(14);
        lab.textAlignment = NSTextAlignmentLeft;
        _orderTitleLab = lab;
    }
    return _orderTitleLab;
}

@end
