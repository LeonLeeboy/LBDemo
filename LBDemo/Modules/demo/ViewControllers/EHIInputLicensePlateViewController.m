//
//  EHIInputLicensePlateViewController.m
//  1haiiPhone
//
//  Created by 李兵 on 2019/8/19.
//  Copyright © 2019 EHi. All rights reserved.
//

#import "EHIInputLicensePlateViewController.h"
#import "EHINewEnergyLicensePlateTextField.h"
#import "SEEDLicensePlateView.h"

@interface EHIInputLicensePlateViewController ()

@property (nonatomic, strong) EHINewEnergyLicensePlateTextField *textField;

/** carImage */
@property (nonatomic, strong) UIImageView *carImageView;

@property (nonatomic, strong) UIControl *scanControl;

@property (nonatomic, strong) UIControl *CarDetailControl;

/** 确认取车 */
@property (nonatomic, strong) UIButton *confirmGetCar;

/** value : "车牌号码" */
@property (nonatomic, strong) UILabel *carNumberLab;

@end

@implementation EHIInputLicensePlateViewController

#pragma mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kEHIHexColor_FFFFFF;
    
    [self setupSubViews];
    
    
}

- (void)setupSubViews {
    
    [self.view addSubview:self.carImageView];
    [self.view addSubview:self.CarDetailControl];
    [self.view addSubview:self.carNumberLab];
    [self.view addSubview:self.textField];
    [self.view addSubview:self.scanControl];
    [self.view addSubview:self.confirmGetCar];
    
    [self layoutViews];
    
    
}

- (void)layoutViews {
    [_carImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(autoWidthOf6(113));
        make.height.mas_equalTo(autoHeightOf6(71));
        make.top.mas_equalTo(autoHeightOf6(6));
        make.centerX.equalTo(self.carImageView.superview);
    }];
    
    [_CarDetailControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.carImageView.mas_centerX);
        make.top.equalTo(self.carImageView.mas_bottom).with.offset(autoHeightOf6(8));
        make.height.mas_equalTo(autoHeightOf6(17));
    }];
    
    [_carNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(autoWidthOf6(18));
        make.top.equalTo(self.CarDetailControl.mas_bottom).with.offset(autoHeightOf6(11));
    }];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.carNumberLab.mas_bottom).with.offset(autoHeightOf6(11));
        make.left.equalTo(self.carNumberLab);
        make.right.mas_equalTo(-autoWidthOf6(17));
        make.height.mas_equalTo(autoHeightOf6(45));
    }];
    
    [_scanControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.mas_bottom).with.offset(autoHeightOf6(22));
        make.centerX.equalTo(self.scanControl.superview);
        make.height.mas_greaterThanOrEqualTo(autoHeightOf6(21));
    }];
    
    [_confirmGetCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(autoWidthOf6(311));
        make.height.mas_equalTo(autoHeightOf6(40));
        make.centerX.equalTo(self.confirmGetCar.superview);
        make.top.equalTo(self.scanControl.mas_bottom).with.offset(autoHeightOf6(29));
    }];
    
    RAC(self.confirmGetCar,enabled) = [RACObserve(self.textField, carInfo) map:^id _Nullable(NSString *  _Nullable value) {
        return (value.length == 7 || value.length == 8)?@(YES):@(NO);
    }];
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
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hicar_carDetail_rightNavigator"]];
    
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



#pragma mark getter
- (UIImageView *)carImageView {
    if (!_carImageView) {
        _carImageView = [[UIImageView alloc] init];
        
    }
    return _carImageView;
}


- (UIControl *)scanControl {
    if (!_scanControl) {
        _scanControl = [[UIControl alloc] init];
        
        UILabel *lab = [[UILabel alloc] init];
        lab  = [[UILabel alloc] init];
        lab.numberOfLines = 0;
        lab.backgroundColor = [UIColor clearColor];
        lab.textColor = kEHIHexColor_FF7E00;
        lab.font = autoFONT(15);
        lab.text = @"扫车牌";
        lab.textAlignment = NSTextAlignmentCenter;
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hicar_inputLicensePlaste_Scan"]];
        
        [_scanControl addSubview:lab];
        [_scanControl addSubview:imgView];
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.centerY.equalTo(imgView.superview);
            make.width.height.mas_equalTo(18);
        }];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_greaterThanOrEqualTo(autoWidthOf6(21));
            make.centerY.equalTo(imgView);
            make.left.equalTo(imgView.mas_right).with.offset(autoWidthOf6(6));
            make.right.mas_equalTo(0);
        }];
    }
    return _scanControl;
}

- (UIControl *)CarDetailControl {
    if (!_CarDetailControl) {
        _CarDetailControl = [self p_getCarDetailView];
    }
    return _CarDetailControl;
}

- (EHINewEnergyLicensePlateTextField *)textField {
    if (!_textField) {
        _textField = [[EHINewEnergyLicensePlateTextField alloc] init];
    }
    return _textField;
}

-(UILabel *)carNumberLab {
    if (!_carNumberLab) {
        _carNumberLab = [[UILabel alloc] init];
        _carNumberLab.textAlignment = NSTextAlignmentLeft;
        _carNumberLab.textColor = kEHIHexColor_CCCCCC;
        _carNumberLab.font = autoBoldFONT(15);
        _carNumberLab.text = @"车牌号码";
    }
    return _carNumberLab;
}

- (UIControl *)confirmGetCar {
    if (!_confirmGetCar) {
        _confirmGetCar = [[UIButton alloc] init];
        
        [_confirmGetCar setTitle:@"确认取车" forState:UIControlStateNormal];
        [_confirmGetCar setTitle:@"确认取车" forState:UIControlStateHighlighted];
        [_confirmGetCar setTitle:@"确认取车" forState:UIControlStateDisabled];
        
        [_confirmGetCar setBackgroundImage:[UIImage imageWithColor:kEHIHexColor_FF7E00] forState:UIControlStateNormal];
        [_confirmGetCar setBackgroundImage:[UIImage imageWithColor:kEHIHexColor(0xFFCB99)] forState:UIControlStateDisabled];
        
        [_confirmGetCar setTitleColor:kEHIHexColor_FFFFFF forState:UIControlStateNormal];
        [_confirmGetCar setTitleColor:kEHIHexColor_FFFFFF forState:UIControlStateDisabled];
    }
    return _confirmGetCar;
}

@end
