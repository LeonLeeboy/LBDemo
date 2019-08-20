//
//  LBEHIDemoViewController.m
//  LBDemo
//
//  Created by 李兵 on 2019/8/9.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBEHIDemoViewController.h"
#import "EHIHiCarOperationTopView.h"
#import "EHIGetAndChangeCarInputView.h"
#import "EHICarLicensePlateTextField.h"

#import "EHIHicarOperationBottomView.h"

@interface LBEHIDemoViewController ()

@property (nonatomic, strong) EHIGetAndChangeCarInputView *inputView;

@property (nonatomic, strong) EHICarLicensePlateTextField *textField;

@end

@implementation LBEHIDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    EHIHiCarOperationTopView *topView = [[EHIHiCarOperationTopView alloc] init];
    topView.didClickPhone = ^{
        NSLog(@"didClickPhone");
    };
    topView.didClickCarDetail = ^{
        NSLog(@"didClickCarDetail");
    };
    
    [self.view addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.right.mas_equalTo(0);
        make.height.mas_greaterThanOrEqualTo(autoHeightOf6(171));
    }];

    topView.layer.shadowOffset = CGSizeMake(0, 10);
    topView.layer.shadowColor = [UIColor blackColor].CGColor;
    topView.layer.shadowOpacity = 1.0;

    //设置阴影的半径
    topView.layer.shadowRadius = 5;
    
    
    
    EHIHicarOperationBottomView *bottomView = [[EHIHicarOperationBottomView alloc] initWhtBottomViewWithStyle:EHIHicarBottomViewStyleAssigned];
    bottomView.haveSearCar = YES;
       [self.view addSubview:bottomView];
    EHiWeakSelf(self)
    bottomView.didClickBlock = ^(EHIHicarBottomEventType type) {
        EHiStrongSelf(self)
        [self doBottomJumpActionWithEvent:type];
    };
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(topView.mas_bottom).with.offset(100);
        make.height.mas_greaterThanOrEqualTo(autoHeightOf6(55));
    }];
    

    EHICarLicensePlateTextField *textField = [[EHICarLicensePlateTextField alloc] init];
    [self.view addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_bottom).with.offset(100);
        make.left.mas_equalTo(autoWidthOf6(17));
        make.right.mas_equalTo(-autoWidthOf6(18));
        make.height.mas_equalTo(autoHeightOf6(45));
    }];
    self.textField = textField;
    [self.textField licensePlateBecomeFirstResponder];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textField licensePlateBecomeFirstResponder];
}

#pragma mark private
- (void)doBottomJumpActionWithEvent:(EHIHicarBottomEventType)type {
    
    switch (type) {
        case EHIHicarBottomEventTypeScan: {
            NSLog(@"扫车牌取车");
        }
            break;
        case EHIHicarBottomEventTypeConfirmGetCar: {
            NSLog(@"确认取车事件");
        }
            break;
        case EHIHicarBottomEventTypeChangeCar: {
            NSLog(@" 更换车辆");
        }
            break;
        case EHIHicarBottomEventTypeSearchCar: {
            NSLog(@"寻找车辆");
        }
            break;
    }
}



@end
