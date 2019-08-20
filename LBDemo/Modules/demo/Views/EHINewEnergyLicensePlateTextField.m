//
//  EHINewEnergyLicensePlateTextField.m
//  LBDemo
//
//  Created by 李兵 on 2019/8/19.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "EHINewEnergyLicensePlateTextField.h"
#import "EHICarLicensePlateTextField.h"

@interface EHINewEnergyLicensePlateTextField ()

@property (nonatomic, strong) UIControl *energyControl;

@property (nonatomic, strong) EHICarLicensePlateTextField *textField;

@property (nonatomic, strong, readwrite) NSString *carInfo;

@end

@implementation EHINewEnergyLicensePlateTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configView];
    }
    return self;
}

- (void)configView {
    
    EHICarLicensePlateTextField *textField = [[EHICarLicensePlateTextField alloc] init];
    self.textField = textField;
    
    [self addSubview:textField];
    [self addSubview:self.energyControl];
    
    [_energyControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(0);
        make.width.mas_equalTo(autoWidthOf6(34));
        make.height.mas_lessThanOrEqualTo(autoHeightOf6(45));
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(autoWidthOf6(0));
        make.bottom.mas_equalTo(autoWidthOf6(0));
        make.left.mas_equalTo(autoWidthOf6(0));
        make.right.equalTo(self.energyControl.mas_left).with.offset(-autoWidthOf6(9));
    }];
    
    RAC(self,carInfo) = RACObserve(self.textField, carInfo);
}

#pragma mark public
- (void)licensePlateBecomeFirstResponder {
    [self.textField licensePlateBecomeFirstResponder];
}

#pragma mark Action
/** 点击新能源 */
- (void)EnergyControlDidClick {
    NSMutableArray<EHICarLicensePlateTextFieldItemModel *> * itemModels=  [NSArray arrayWithArray:self.textField.itemModels].mutableCopy;
    [itemModels enumerateObjectsUsingBlock:^(EHICarLicensePlateTextFieldItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = NO;
    }];
    
    EHICarLicensePlateTextFieldItemModel *last = [[EHICarLicensePlateTextFieldItemModel alloc] init];
    last.text = @"";
    last.normalBackGroundColor = [kEHIHexColor_29B7B7 colorWithAlphaComponent:0.12];
    last.selectedBackGroundColor = kEHIHexColor_FF7E00;
    last.selected = YES;
    
    [itemModels addObject:last];
    
    [self.textField renderViewWithItemModels:itemModels.copy];
    
    self.energyControl.hidden = YES;
    [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
    }];
    
    [self.textField licensePlateBecomeFirstResponder];
}

#pragma mark getter && setter
- (UIControl *)energyControl {
    if (!_energyControl) {
        _energyControl = [[UIControl alloc] init];
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hicar_leaf"]];
        UILabel *lab = [[UILabel alloc] init];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = kEHIHexColor_7B7B7B;
        lab.text = @"新能源";
        lab.font = autoFONT(9);
        
        
        [_energyControl addSubview:imgView];
        [_energyControl addSubview:lab];
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(autoWidthOf6(18));
            make.height.mas_equalTo(autoHeightOf6(13));
            make.centerX.equalTo(imgView.superview);
            make.top.mas_equalTo(autoHeightOf6(8));
        }];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(imgView);
            make.top.equalTo(imgView.mas_bottom).with.offset(autoHeightOf6(2));
            make.bottom.mas_equalTo(autoHeightOf6(9));
        }];
        EHiWeakSelf(self)
        [_energyControl addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            EHiStrongSelf(self)
            [self EnergyControlDidClick];
        }];
        
        _energyControl.backgroundColor = [kEHIHexColor_29B7B7 colorWithAlphaComponent:0.12];
    }
    return _energyControl;
}

- (void)setInputView:(UIView *)inputView {
    self.textField.inputView = inputView;
}

@end
