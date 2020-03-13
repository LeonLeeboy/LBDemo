//
//  EHICalendarTopView.m
//  LBDemo
//
//  Created by 李兵 on 2020/3/6.
//  Copyright © 2020 ivan. All rights reserved.
//

#import "EHICalendarTopView.h"

@interface EHICalendarTopView ()

/** 左边 */
@property (nonatomic, strong) UILabel *LDateLbl;
@property (nonatomic, strong) UILabel *LTimeLbl;
@property (nonatomic, strong) UIButton *LDateBtn;

/** 中间 */
//@property (nonatomic, strong) UILabel *CTimeLbl;
@property (nonatomic, strong) UIImageView *cIcon;

// 右边
@property (nonatomic, strong) UILabel *RDateLbl;
@property (nonatomic, strong) UILabel *RTimeLbl;
@property (nonatomic, strong) UIButton *RDateBtn;

@end

@implementation EHICalendarTopView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self addSubview:self.LTimeLbl];
    [self addSubview:self.LDateLbl];
    [self addSubview:self.LDateBtn];
    
    [self addSubview:self.cIcon];
    
    [self addSubview:self.RDateBtn];
    [self addSubview:self.RTimeLbl];
    [self addSubview:self.RDateLbl];
    
    [self layoutViews];
}

- (void)layoutViews {
     [_LDateLbl mas_updateConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.mas_left).mas_offset(20);
           make.bottom.equalTo(self.mas_centerY).mas_offset(-2.5);
       }];
    
       [_LTimeLbl mas_updateConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(_LDateLbl.mas_left);
           make.top.equalTo(self.mas_centerY).mas_offset(2.5);
       }];
       
       [_LDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.top.equalTo(self);
           make.bottom.equalTo(self.mas_top);
           make.right.equalTo(_cIcon.mas_left).mas_offset(-20);
       }];
       
       
       [_cIcon mas_updateConstraints:^(MASConstraintMaker *make) {
           make.centerX.centerY.equalTo(self);
       }];
       
       [_RDateLbl mas_updateConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(_LDateLbl.mas_centerY);
           make.right.equalTo(self.mas_right).mas_offset(-20);
       }];
       
       [_RTimeLbl mas_updateConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(_LTimeLbl.mas_centerY);
           make.right.equalTo(_RDateLbl.mas_right);
       }];
       
       [_RDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.right.equalTo(self);
           make.bottom.equalTo(self.mas_top);
           make.width.equalTo(_LDateBtn.mas_width);
       }];
       
}

#pragma mark - public
- (void)doClickRightAction {
    
}

#pragma mark - Action
- (void)doClickLeftAction {
    
}

#pragma mark - private
- (NSString *)p_dealDate:(EHICalendarDayModel *)dayModel {
    NSString *format = @"MM月dd日";
    NSString *rst = [dayModel.getDate stringWithFormat:format];
    return rst;
}

- (NSString *)p_dealTime:(EHICalendarDayModel *)model {
    NSString *format = @"HH:mm";
//    model.getDate.weekday;
    NSString *week = [self getWeekDes:model.getFullDate.weekday];
    NSString *HHmm = [model.getFullDate stringWithFormat:format];
    NSString *rst = [NSString stringWithFormat:@"%@  %@",week,HHmm];
    return rst;
}

#pragma mark - Getter && Setter

#pragma mark - private

- (void)setLeftModel:(EHICalendarDayModel *)leftModel {
    _leftModel = leftModel;
    
    self.LDateLbl.text = [self p_dealDate:leftModel];
    self.LTimeLbl.text = [self p_dealTime:leftModel];
}

- (void)setRightModel:(EHICalendarDayModel *)rightModel {
    _rightModel = rightModel;
    self.RDateLbl.text = [self p_dealDate:rightModel];
     self.RTimeLbl.text = [self p_dealTime:rightModel];
}

/** 创建一个Label */
- (UILabel *)p_createLabel {
    UILabel *lab = [[UILabel alloc] init];
    lab.numberOfLines = 0;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.textColor = Color333333();
    lab.font = autoFONT(18);
    lab.text = @"";
    return lab;
}

- (NSString *)getWeekDes:(NSInteger)weekDay {
     NSArray *weekdayAry = [NSArray arrayWithObjects:@"周天", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    if (weekdayAry.count > weekDay) {
        return weekdayAry[weekDay-1];
    }
    return @"";
}

#pragma mark - Getter
- (UILabel *)LDateLbl {
    if (!_LDateLbl) {
        UILabel *lab = [self p_createLabel];
        lab.text = @"取车日期";
        lab.textAlignment = NSTextAlignmentLeft;
        _LDateLbl = lab;
    }
    return _LDateLbl;
}

- (UILabel *)LTimeLbl {
    if (!_LTimeLbl) {
        UILabel *lab = [self p_createLabel];
        lab.textColor = Color7B7B7B();
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = autoFONT(12);
        lab.text = @"请选择";
        _LTimeLbl = lab;
    }
    return _LTimeLbl;
}

- (UILabel *)RDateLbl {
    if (!_RDateLbl) {
        UILabel *lab = [self p_createLabel];
        lab.textAlignment = NSTextAlignmentRight;
        lab.text = @"还车日期";
        _RDateLbl = lab;
    }
    return _RDateLbl;
}

- (UILabel *)RTimeLbl {
    if (!_RTimeLbl) {
        UILabel *lab = [self p_createLabel];
        lab.textColor = Color7B7B7B();
        lab.text = @"请选择";
        lab.textAlignment = NSTextAlignmentRight;
        lab.font = autoFONT(12);
        _RTimeLbl = lab;
    }
    return _RTimeLbl;
}

- (UIImageView *)cIcon {
    if (!_cIcon) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.image = [UIImage imageNamed:@"calendar_rightArrow"];
        _cIcon = imgView;
    }
    return _cIcon;
}


- (UIButton *)LDateBtn {
    
    if (!_LDateBtn) {
        
        _LDateBtn = [[UIButton alloc] init];
        [_LDateBtn setTitleColor:Color7B7B7B() forState:UIControlStateNormal];
        _LDateBtn.titleLabel.font = autoFONT(12);
        _LDateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_LDateBtn setTitle:@"" forState:UIControlStateNormal];
        [_LDateBtn setTitle:@"" forState:UIControlStateSelected];
        
        [_LDateBtn addTarget:self action:@selector(doClickLeftAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _LDateBtn;
}

- (UIButton *)RDateBtn {
    
    if (!_RDateBtn) {
        
        _RDateBtn = [[UIButton alloc] init];
        [_RDateBtn setTitleColor:Color7B7B7B() forState:UIControlStateNormal];
        _RDateBtn.titleLabel.font = autoFONT(12);
        _RDateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_RDateBtn setTitle:@"" forState:UIControlStateNormal];
        [_RDateBtn setTitle:@"" forState:UIControlStateSelected];
        
        [_RDateBtn addTarget:self action:@selector(doClickRightAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _RDateBtn;
}


@end
