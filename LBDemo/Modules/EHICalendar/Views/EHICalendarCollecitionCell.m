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

static CGFloat calendarTextWidth() {
    return autoWidthOf6(23);
}

@interface EHICalendarCollecitionCell ()

@property (nonatomic, strong) UILabel *textLab;

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
    
    [self addSubview:self.textLab];
    
    [self layoutViews];
}

- (void)layoutViews {
    [_textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(calendarTextWidth());
        make.center.mas_equalTo(self);
    }];
}

#pragma mark - public
- (void)seed_cellWithData:(EHICalendarDayCellViewModel *)itemModel {
    self.textLab.textColor = itemModel.textColor;
       self.textLab.text = itemModel.display;
}

#pragma mark - private
/** 创建一个Label */
- (UILabel *)p_createLabel {
    UILabel *lab = [[UILabel alloc] init];
    lab.numberOfLines = 0;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.textColor = kLBAPPHexColor_FFFFFF;
    lab.font = autoFONT(18);
    lab.text = @"";
    return lab;
}

#pragma mark - Getter && Setter
- (UILabel *)textLab {
    if(!_textLab) {
        UILabel *lab = [self p_createLabel];
        lab.text = @"19";
        _textLab = lab;
    }
    return _textLab;
}


@end
