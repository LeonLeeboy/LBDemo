//
//  EHIHicarOperationBottomView.m
//  LBDemo
//
//  Created by 李兵 on 2019/8/13.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "EHIHicarOperationBottomView.h"

#pragma mark -

typedef void(^AssignedViewDidClickBlock)(void);

@interface EHIHicarOperationBottomAssignedView : UIView

@property (nonatomic, copy) AssignedViewDidClickBlock changeCarBlock;

@property (nonatomic, copy) AssignedViewDidClickBlock confirmGetCar;

@property (nonatomic, copy) AssignedViewDidClickBlock searchCarBlock;

/** 左边 */
@property (nonatomic, strong) UIControl *leftControl;

/** 中间 */
@property (nonatomic, strong) UIControl *centerControl;

/** 右边 */
@property (nonatomic, strong) UIControl *RightControl;

@property (nonatomic, assign) BOOL haveSearchCarFunction;

@end

@implementation EHIHicarOperationBottomAssignedView

#pragma mark life cyle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {

    [self addSubview:self.leftControl];
    [self addSubview:self.centerControl];
    [self addSubview:self.RightControl];
    
    __block MASConstraint *centerControlRightConstraint;
    __block MASConstraint *rightControlRightConstraint;
    
    [_leftControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(autoWidthOf6(79));
        make.height.mas_equalTo(autoHeightOf6(55));
        make.left.top.bottom.mas_equalTo(0);
    }];
    [_centerControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(autoWidthOf6(165), 55));
        make.left.equalTo(self.leftControl.mas_right).with.offset(autoWidthOf6(7));
        make.centerY.equalTo(self.leftControl);
        centerControlRightConstraint = make.right.mas_equalTo(0);
    }];
    
    [_RightControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(autoWidthOf6(79));
        make.height.mas_equalTo(autoHeightOf6(55));
        make.left.equalTo(self.centerControl.mas_right).with.offset(autoWidthOf6(7));
        make.centerY.equalTo(self.leftControl);
        rightControlRightConstraint = make.right.mas_equalTo(0);
    }];
    
    [centerControlRightConstraint uninstall];
    [rightControlRightConstraint uninstall];
    
    //constraint
    [RACObserve(self, haveSearchCarFunction) subscribeNext:^(id  _Nullable x) {
        if ([x boolValue]) { //有
            [centerControlRightConstraint uninstall];
            [rightControlRightConstraint install];
        } else {
            [rightControlRightConstraint uninstall];
            [centerControlRightConstraint install];
        }
    }];
    
    //hidden
    RAC(self.RightControl,hidden) = [RACObserve(self, haveSearchCarFunction) map:^id _Nullable(id  _Nullable value) {
        return @(![value boolValue]);
    }];
    
}

#pragma mark private

- (UIControl *)p_sideViewWithIconName:(NSString *)iconImageName text:(NSString *)text {
    UIControl *leftControl = [[UIControl alloc] init];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:iconImageName]];
    
    UILabel *textLabel  = [[UILabel alloc] init];
    textLabel.numberOfLines = 0;
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textColor = kEHIHexColor_333333;
    textLabel.font = autoFONT(12);
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.text = text;

    [leftControl addSubview:imageView];
    [leftControl addSubview:textLabel];
 
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(21, 21));
        make.left.mas_equalTo(autoWidthOf6(29));
        make.top.mas_equalTo(autoHeightOf6(9));
        make.right.mas_equalTo(-autoWidthOf6(29));
    }];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView);
        make.top.equalTo(imageView.mas_bottom).with.offset(autoHeightOf6(3));
        make.bottom.mas_equalTo(-autoHeightOf6(9));
    }];
    
    leftControl.layer.cornerRadius = 27;
    
    leftControl.backgroundColor = kEHIHexColor_FFFFFF;
    
    return leftControl;
}


#pragma mark getter
- (UIControl *)leftControl {
    if (!_leftControl) {
        _leftControl = [self p_sideViewWithIconName:@"hicar_changeCar_Icon" text:@"更换车辆"];
        EHiWeakSelf(self)
        [_leftControl addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            EHiStrongSelf(self)
            if (self.changeCarBlock) {
                self.changeCarBlock();
            }
        }];
    }
    return _leftControl;
}

- (UIControl *)RightControl {
    if (!_RightControl) {
        _RightControl = [self p_sideViewWithIconName:@"hicar_searchCar_Icon" text:@"寻找车辆"];
        
        EHiWeakSelf(self)
        [_RightControl addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            EHiStrongSelf(self)
            if (self.searchCarBlock) {
                self.searchCarBlock();
            }
        }];
    }
    return _RightControl;
}

- (UIControl *)centerControl {
    if (!_centerControl) {
        _centerControl = [[UIControl alloc] init];
        
        UILabel *textLabel  = [[UILabel alloc] init];
        textLabel.numberOfLines = 0;
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = kEHIHexColor_FFFFFF;
        textLabel.font = autoFONT(15);
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.text = @"确认取车";
        
        [_centerControl addSubview:textLabel];
        
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(textLabel.superview);
        }];
        
        _centerControl.layer.cornerRadius = 27;
        _centerControl.backgroundColor = kEHIHexColor_FF7E00;
        EHiWeakSelf(self)
        [_centerControl addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            EHiStrongSelf(self)
            if (self.confirmGetCar) {
                self.confirmGetCar();
            }
        }];
    }
    return _centerControl;
}

@end

#pragma mark -

typedef void(^notAssignedViewDidClickBlock)(void);

@interface EHIHicarOperationBottomNotAssignedView : UIControl

/** 扫车牌取车 */
@property (nonatomic, strong) UILabel *sacanLabel;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, copy) notAssignedViewDidClickBlock didClickBlock;

@end

@implementation EHIHicarOperationBottomNotAssignedView

#pragma mark life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self addSubview:self.imageView];
    [self addSubview:self.sacanLabel];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(21, 21));
        make.left.mas_equalTo(autoWidthOf6(27));
        make.top.mas_equalTo(autoHeightOf6(17));
        make.bottom.mas_equalTo(-autoHeightOf6(17));
    }];
 
    [_sacanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.mas_right).with.offset(autoWidthOf6(9));
        make.width.mas_greaterThanOrEqualTo(autoWidthOf6(86));
        make.centerY.equalTo(self.imageView.mas_centerY);
        make.right.mas_equalTo(-autoWidthOf6(26));
    }];
    
    self.backgroundColor = kEHIHexColor_FF7E00;
    self.layer.cornerRadius = 27;
    
    [self addTarget:self action:@selector(didClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didClick {
    if (self.didClickBlock) {
        self.didClickBlock();
    }
}


- (UILabel *)sacanLabel {
    if (!_sacanLabel) {
        _sacanLabel  = [[UILabel alloc] init];
        _sacanLabel.numberOfLines = 0;
        _sacanLabel.backgroundColor = [UIColor clearColor];
        _sacanLabel.textColor = kEHIHexColor_FFFFFF;
        _sacanLabel.font = autoFONT(15);
        _sacanLabel.text = @"扫车牌取车";
        _sacanLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _sacanLabel;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hiCar_returnCar _Scan"]];
    }
    return _imageView;
}


@end

#pragma mark -

@interface EHIHicarOperationBottomView ()

/** 当前样式 */
@property (nonatomic, assign) EHIHicarBottomViewStyle currentViewStyle;

@property (nonatomic, strong) UIView *contentView;

@end

@implementation EHIHicarOperationBottomView

#pragma mark life cycle

- (instancetype)init {
    NSString *reason = [NSString stringWithFormat:@"%@ must use @selector(initWhtBottomViewWithType) ", NSStringFromSelector(_cmd)];
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:reason userInfo:nil];
}

- (instancetype)initWhtBottomViewWithStyle:(EHIHicarBottomViewStyle)viewStyle {
    if (self = [super initWithFrame:CGRectZero]) {
        self.currentViewStyle = viewStyle;
        
        [self p_setupSubviews];
    }
    return self;
}

#pragma mark public
- (void)renderViewWithViewStyle:(EHIHicarBottomViewStyle)viewStyle {
    
    self.currentViewStyle = viewStyle;
    
    [self p_removeAllSubViews];
    
    [self p_addContentSubView];
}

#pragma mark private
- (void)p_setupSubviews {
    
    [self p_removeAllSubViews];
    
    [self addSubview:self.contentView];
    
    [self p_addContentSubView];
   
    //layout
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
}

- (void)p_addContentSubView {
    
    UIView *subView;
    switch (_currentViewStyle) {
        case EHIHicarBottomViewStyleAssigned: {
            EHIHicarOperationBottomAssignedView *assignedView = [[EHIHicarOperationBottomAssignedView alloc] init];
            EHiWeakSelf(self)
            assignedView.changeCarBlock = ^{
                EHiStrongSelf(self)
                if (self.didClickBlock) {
                    self.didClickBlock(EHIHicarBottomEventTypeChangeCar);
                }
            };
            assignedView.confirmGetCar = ^{
                EHiStrongSelf(self)
                if (self.didClickBlock) {
                    self.didClickBlock(EHIHicarBottomEventTypeConfirmGetCar);
                }
            };
            
            assignedView.searchCarBlock = ^{
                EHiStrongSelf(self)
                if (self.didClickBlock) {
                    self.didClickBlock(EHIHicarBottomEventTypeSearchCar);
                }
            };
            subView = assignedView;
        }
            break;
        case EHIHicarBottomViewStyleNotAssigned: {
            EHIHicarOperationBottomNotAssignedView *notAssignedView = [[EHIHicarOperationBottomNotAssignedView alloc] init];
             EHiWeakSelf(self)
            notAssignedView.didClickBlock = ^{
                 EHiStrongSelf(self)
                if (self.didClickBlock) {
                    self.didClickBlock(EHIHicarBottomEventTypeScan);
                }
            };
            subView = notAssignedView;
        }
    }
    
    [self.contentView addSubview:subView];
    
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(subView.superview);
        make.centerY.equalTo(subView.superview);
    }];
}

/** 去除contentView里面的subView */
- (void)p_removeAllSubViews {
    
    if (self.contentView.subviews.count == 0) {
        return;
    }
    
    [self.contentView removeAllSubviews];
}

#pragma mark getter
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (void)setHaveSearCar:(BOOL)haveSearCar {
    _haveSearCar = haveSearCar;
    
    if (self.contentView.subviews.count == 0) {
        return;
    }
    UIView *v = self.contentView.subviews[0];
    if ([v isKindOfClass:[EHIHicarOperationBottomAssignedView class]]) {
        EHIHicarOperationBottomAssignedView *temp = (EHIHicarOperationBottomAssignedView *)v;
        temp.haveSearchCarFunction = haveSearCar;
    }
}

@end


