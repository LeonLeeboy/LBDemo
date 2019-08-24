//
//  EHIDetectionViewController.m
//  LBDemo
//
//  Created by 李兵 on 2019/8/23.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "EHIDetectionViewController.h"

#import "EHIScanCarAnimationView.h"
#import "EHIDetectionBottomView.h"

#import "EHIDetectionModel.h"

@interface EHIDetectionViewController ()

@property (nonatomic, strong) EHIScanCarAnimationView *carAnimaitonView;

@property (nonatomic, strong) EHIDetectionBottomView *bottomDetectionView;

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UILabel *subTitleLab;

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) EHIDetectionModel *renderModel;

@property (nonatomic, strong) UIButton *cancleButton;

/** 继续还车 */
@property (nonatomic, strong) UIButton *continueReturnCar;

@end

@implementation EHIDetectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self prepareData];
    
    [self setupSubViews];
    
    [self renderViewWithModel:self.renderModel];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.carAnimaitonView starAnimation];
    
    [self.bottomDetectionView startCheck];
    
}

- (void)prepareData {
    self.renderModel = [[EHIDetectionModel alloc] init];
    self.renderModel.title = @"请确保以下设备均已关闭";
    self.renderModel.subTitle = @"打开蓝牙，还车速度更快";
    self.renderModel.checkDone = NO;
    
    NSArray<NSString *> *strings = [self p_checkStrings];
    NSMutableArray *content = [NSMutableArray array];
    for (int i = 0; i < strings.count; i++) {
        
        EHIDetecctionItemModel *model = [[EHIDetecctionItemModel alloc] init];
        model.itemName = strings[i];
        model.itemID = i;
        model.success = YES;
        [content addObject:model];
        
        if (i == 1) {
            model.success = NO;
        }
    }
    self.renderModel.itemModels = content.copy;

    RAC(self.continueReturnCar,hidden) = [RACObserve(self.bottomDetectionView, haveError) map:^id _Nullable(id  _Nullable value) {
        NSLog(@"sdf");
        return @(![value boolValue]);
    }];
    
}

- (void)setupSubViews {
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.carAnimaitonView];
    [self.view addSubview:self.cancleButton];
    [self.view addSubview:self.continueReturnCar];
    [self.view addSubview:self.bottomDetectionView];
    
    [self laytoutViews];
    
   
    
}

#pragma mark Action
/** 关闭控制器 */
- (void)doCloseViewControllerAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/** 继续还车事件 */
- (void)doContinueReturnCarAction {
    
}

- (void)doDetectionFineshedActionWithRst:(BOOL)rst {
    
    if (rst) {//检查通过
        self.renderModel = [[EHIDetectionModel alloc] init];
        self.renderModel.title = @"请确保以下设备均已关闭";
        self.renderModel.subTitle = @"打开蓝牙，还车速度更快";
        self.renderModel.titleColor = self.renderModel.titleColor?:kEHIHexColor_333333;
        self.renderModel.subTitleColor = self.renderModel.titleColor?:kEHIHexColor_7B7B7B;
    } else {//检查没通过
        self.renderModel = [[EHIDetectionModel alloc] init];
        self.renderModel.title = @"请确保以下设备均已关闭";
        self.renderModel.subTitle = @"打开蓝牙，还车速度更快";
        self.renderModel.titleColor = self.renderModel.titleColor?:kEHIHexColor_F43530;
        self.renderModel.subTitleColor = self.renderModel.titleColor?:kEHIHexColor_F43530;
    }
    
    self.renderModel.checkDone = rst;
    [self renderViewWithModel:self.renderModel];
}

#pragma mark public
- (void)renderViewWithModel:(EHIDetectionModel *)model {
    self.renderModel = model;
   
    [self p_renderTopView];
    
    [self p_renderCarAnimationViewWithRst:self.renderModel.checkDone];
    
    [self p_renderBottomAnimationView];
    
}

#pragma mark private
- (NSArray<NSString *> *)p_checkStrings {
    return @[@"车灯",@"车窗",@"车门",@"后备箱",@"熄火"];
}

- (void)p_renderTopView {
    self.titleLab.text = self.renderModel.title;
    self.subTitleLab.text = self.renderModel.title;
}


/**
 渲染中间扫描car的动画

 @param haveDone 检查item的动画结束后是否是成功的
 */
- (void)p_renderCarAnimationViewWithRst:(BOOL)haveDone {
    if (haveDone) {
        [self.carAnimaitonView stopAnimation];
    } else {
        [self.carAnimaitonView starAnimation];
    }
}

- (void)p_renderBottomAnimationView {
    [self.bottomDetectionView renderViewWithModels:self.renderModel.itemModels];
}

#pragma mark layoutViews
- (void)laytoutViews {
    
    [_cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo([UIApplication sharedApplication].statusBarFrame.size.height + 10);
        make.left.mas_equalTo(autoWidthOf6(22));
        make.height.width.mas_equalTo(autoWidthOf6(14));
    }];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(autoHeightOf6(93));
        make.centerX.equalTo(self.topView.superview);
    }];
    
    [_carAnimaitonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topView);
        make.top.equalTo(self.topView.mas_bottom).with.offset(autoHeightOf6(48));
        make.left.right.mas_equalTo(0);
    }];
    
    [_bottomDetectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.carAnimaitonView.mas_bottom).with.offset(autoHeightOf6(50));
        make.centerX.equalTo(self.carAnimaitonView);
    }];
   
    [_continueReturnCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-autoHeightOf6(45));
        make.width.mas_greaterThanOrEqualTo(autoWidthOf6(203));
        make.height.mas_greaterThanOrEqualTo(autoHeightOf6(40));
        make.centerX.equalTo(self.continueReturnCar.superview);
    }];
}

#pragma mark - getter && setter
- (EHIScanCarAnimationView *)carAnimaitonView {
    if (!_carAnimaitonView) {
        _carAnimaitonView = [[EHIScanCarAnimationView alloc] init];
    }
    return _carAnimaitonView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        [_topView addSubview:self.titleLab];
        [_topView addSubview:self.subTitleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            
        }];
        
        [_subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLab.mas_bottom).with.offset(autoHeightOf6(6));
            make.centerX.equalTo(self.titleLab);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _topView;
}


- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab  = [[UILabel alloc] init];
        _titleLab.numberOfLines = 0;
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.textColor = kEHIHexColor_333333;
        _titleLab.font = autoBoldFONT(16);
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.text = @" ";
    }
    return _titleLab;
}


- (UILabel *)subTitleLab {
    if (!_subTitleLab) {
        _subTitleLab  = [[UILabel alloc] init];
        _subTitleLab.numberOfLines = 0;
        _subTitleLab.backgroundColor = [UIColor clearColor];
        _subTitleLab.textColor = kEHIHexColor_7B7B7B;
        _subTitleLab.font = autoFONT(12);
        _subTitleLab.textAlignment = NSTextAlignmentCenter;
        _subTitleLab.text = @" ";
    }
    return _subTitleLab;
}

- (UIButton *)cancleButton {
    if (!_cancleButton) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleButton setBackgroundImage:[UIImage imageNamed:@"hicar_detectionViewController_close"] forState:UIControlStateNormal];
        [_cancleButton addTarget:self action:@selector(doCloseViewControllerAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}




- (UIButton *)continueReturnCar {
    if (!_continueReturnCar) {
        _continueReturnCar = [[UIButton alloc] init];
        
        [_continueReturnCar setTitle:@"均已关闭 继续还车" forState:UIControlStateNormal];
        [_continueReturnCar setTitle:@"均已关闭 继续还车" forState:UIControlStateHighlighted];
        [_continueReturnCar setTitle:@"均已关闭 继续还车" forState:UIControlStateDisabled];
        
        [_continueReturnCar setBackgroundImage:[UIImage imageWithColor:kEHIHexColor_FF7E00] forState:UIControlStateNormal];
        [_continueReturnCar setBackgroundImage:[UIImage imageWithColor:kEHIHexColor(0xFFCB99)] forState:UIControlStateDisabled];
        
        [_continueReturnCar setTitleColor:kEHIHexColor_FFFFFF forState:UIControlStateNormal];
        [_continueReturnCar setTitleColor:kEHIHexColor_FFFFFF forState:UIControlStateDisabled];
        
        _continueReturnCar.layer.cornerRadius = 22;
        _continueReturnCar.layer.masksToBounds = YES;
        
        EHiWeakSelf(self)
        [_continueReturnCar addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            EHiStrongSelf(self)
            [self doContinueReturnCarAction];
        }];
    }
    return _continueReturnCar;
}

- (EHIDetectionBottomView *)bottomDetectionView {
    if (!_bottomDetectionView) {
        _bottomDetectionView = [[EHIDetectionBottomView alloc] init];
        EHiWeakSelf(self)
        _bottomDetectionView.didFinishedBock = ^(BOOL isSuccess) {
             EHiStrongSelf(self)
            [self doDetectionFineshedActionWithRst:YES];
        };
    }
    return _bottomDetectionView;
}

@end
