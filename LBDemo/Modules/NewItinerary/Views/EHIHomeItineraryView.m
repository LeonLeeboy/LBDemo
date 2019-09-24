//
//  EHIHomeItineraryView.m
//  LBDemo
//
//  Created by 李兵 on 2019/9/18.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "EHIHomeItineraryView.h"

/** 更多行程订单Tag */
static NSInteger kMoreItineraryTag = 10001;

@interface EHIHomeItineraryView ()

#pragma mark 可改变对象
/** titleLabel */
@property (nonatomic, strong) UILabel *titleLabel;

#pragma mark  用于初始化
@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *bottomView;


@end

@implementation EHIHomeItineraryView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = kEHIHexColor_FFFFFF;
        
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
    [self addSubview:self.topView];
    [self addSubview:self.lineView];
    [self addSubview:self.bottomView];
    
    [self layoutViews];
}


- (void)layoutViews {
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.topView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).with.offset(autoHeightOf6(12));
        make.left.mas_equalTo(autoWidthOf6(12));
        make.right.bottom.mas_equalTo(-autoWidthOf6(12));
    }];
}

#pragma mark - public

- (void)renderViewWithContent:(id)parameters {
    
    if (self.bottomView.subviews.count > 0) {
        [self.bottomView removeAllSubviews];
    }
    
    UIControl *moreItineraryControl = [self p_getMoreItineraryControl];
    
    self.titleLabel.text = @"您有新的行程 (2)";
    
    if (true) {
        moreItineraryControl.hidden = NO;
    }
    
    NSArray *contentStrings = @[
                                @"专车-送机",
                                @"上车时间：2019/09/11 07:00",
                                @"上车地点：上海 - 华宏商务渡河务中心大渡河务大asfd;lj;alsdf"
                                ];
    
    NSMutableArray<UILabel *> *labels = [NSMutableArray array];
    for (int i = 0; i < contentStrings.count; i++) {
        UILabel *lab;
        if (i == 0) {
            lab = [self p_createLabelWithTitle:contentStrings[i] font:autoBoldFONT(12) textColor:kEHIHexColor_7B7B7B];
            
            [self.bottomView addSubview:lab];
            [labels addObject:lab];
            continue;
        }
        lab = [self p_createLabelWithTitle:contentStrings[i] font:autoFONT(12) textColor:kEHIHexColor_7B7B7B];
        
        [self.bottomView addSubview:lab];
        [labels addObject:lab];
        
    }
   
    UILabel *preObj;
    for (int i = 0; i < labels.count; i++) {
        UILabel *obj = labels[i];
        if (i==0) {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.mas_equalTo(autoWidthOf6(15));
                make.right.mas_equalTo(-autoWidthOf6(15));
            }];
            preObj = obj;
            continue;
        }
        
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(preObj.mas_bottom).with.offset(autoHeightOf6(8));
            make.left.right.equalTo(preObj);
        }];
        preObj = obj;
    }
    [labels.lastObject mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-autoHeightOf6(15));
    }];
    
    
    
}

#pragma mark - Action
/** 点击 “更多行程” */
- (void)doMoreItineraryAction {
    if (self.moreItineraryClickAction) {
        self.moreItineraryClickAction();
    }
}

/** 点击 当前行程区域 */
- (void)doCurrentItineraryAction {
    if (self.clickCurrentItineraryAction) {
        self.clickCurrentItineraryAction();
    }
}

#pragma mark - private
/** 创建 “更多行程按钮” */
- (UIControl *)p_createMoreItineraryControl {
    UIControl *moreItinerarycontrol = [[UIControl alloc] init];
    
    UILabel *topTipLable = [[UILabel alloc] init];
    topTipLable  = [[UILabel alloc] init];
    topTipLable.numberOfLines = 0;
    topTipLable.backgroundColor = [UIColor clearColor];
    topTipLable.textColor = kEHIHexColor_29B7B7;
    topTipLable.font = autoFONT(12);
    topTipLable.textAlignment = NSTextAlignmentCenter;
    topTipLable.text = @"更多行程";
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"home_newItinerary_plan"];
    
    
    [moreItinerarycontrol addSubview:topTipLable];
    [moreItinerarycontrol addSubview:imageView];
    
    
    [topTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(12);
        make.left.equalTo(topTipLable.mas_right).with.offset(4);
        make.centerY.equalTo(topTipLable);
        make.right.mas_equalTo(0);
    }];
    
    return moreItinerarycontrol;
}

/** 创建UIlabel */
- (UILabel *)p_createLabelWithTitle:(NSString *)title font:(UIFont *)font textColor:(UIColor *)textColor {
    UILabel *lab = [[UILabel alloc] init];
    lab  = [[UILabel alloc] init];
    lab.numberOfLines = 1;
    lab.backgroundColor = [UIColor clearColor];
    lab.textColor = textColor;
    lab.font = font;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.text = title;
    return lab;
}

/** 获得更多按钮 */
- (UIControl *)p_getMoreItineraryControl {
    for (UIView *v in self.topView.subviews) {
        if (v.tag == kMoreItineraryTag) {
            return (UIControl *)v;
        }
    }
    return nil;
}

#pragma mark - Getter && Setter

- (UIView *)topView{
    if (!_topView) {
        UIView *contentV = [[UIView alloc] init];
        contentV.backgroundColor = kEHIHexColor_FFFFFF;
        
        UIImageView *imageView = [[UIImageView alloc] init];
          imageView.image = [UIImage imageNamed:@"home_newItinerary_plan"];
        
        UIControl *moreItinerary = [self p_createMoreItineraryControl];
        moreItinerary.tag = kMoreItineraryTag;
        
        [contentV addSubview:imageView];
        [contentV addSubview:self.titleLabel];
        [contentV addSubview:moreItinerary];
        
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(16);
            make.left.mas_equalTo(autoWidthOf6(13));
            make.top.mas_equalTo(autoWidthOf6(13));
            make.bottom.mas_equalTo(-autoWidthOf6(13));
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).with.offset(autoWidthOf6(8));
            make.centerY.equalTo(imageView);
        }];
        
        [moreItinerary mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(imageView);
            make.right.mas_equalTo(-autoWidthOf6(12));
        }];
        
        // event
        [moreItinerary addTarget:self action:@selector(doMoreItineraryAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        _topView = contentV;
    }
    return _topView;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel  = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = kEHIHexColor_333333;
        _titleLabel.font = autoBoldFONT(14);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @" ";
    }
    return _titleLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kEHIHexColor_EEEEEE;
    }
    return _lineView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        UIView *contentV = [[UIView alloc] init];
        contentV.backgroundColor = kEHIHexColor_CCCCCC;
        contentV.layer.cornerRadius = 4;
        
        // 添加手势
        UITapGestureRecognizer *tapgest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doCurrentItineraryAction)];
        [contentV addGestureRecognizer:tapgest];
        _bottomView = contentV;
        
    }
    return _bottomView;
}


@end
