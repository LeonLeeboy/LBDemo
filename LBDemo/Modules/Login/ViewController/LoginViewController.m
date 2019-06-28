//
//  LoginViewController.m
//  LBDemo
//
//  Created by 李兵 on 2019/6/25.
//  Copyright © 2019 ivan. All rights reserved.
//


#import "LoginViewController.h"
#import <BlocksKit+UIKit.h>
#import "LBLoginViewModel.h"


#define FontHeiti(fontSize) [UIFont fontWithName:@"STHeitiSC-Light" size:(fontSize)]
// 颜色
static inline UIColor *RGBA(int R, int G, int B, double A) {
    return [UIColor colorWithRed: R/255.0 green: G/255.0 blue: B/255.0 alpha: A];
}

static inline UIColor *HexColor(int v) {
    return RGBA((double)((v&0xff0000)>>16), (double)((v&0xff00)>>8), (double)(v&0xff), 1.0f);
}

@interface LoginViewController ()

@property(nonatomic,strong)  LoginBlock block;

@property (strong , nonatomic) UIButton *loginBtn;

@property (strong , nonatomic) UITextField *nameText;

@property (strong , nonatomic) UITextField *pwdText;

@end

@implementation LoginViewController

#pragma mark life Cycle
-(id)initWithBlock:(LoginBlock)block {
    self=[super init];
    if (self) {
        self.block = block;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self p_setupView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    IQKeyboardManager.sharedManager.enable = YES;
    IQKeyboardManager.sharedManager.enableAutoToolbar = YES;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    IQKeyboardManager.sharedManager.enable = NO;
    IQKeyboardManager.sharedManager.enableAutoToolbar = NO;
}

#pragma mark private
///初始化view
-(void)p_setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *headerImg = UIImageView.new;
    headerImg.image = [UIImage imageNamed:@"loginLogo"];
    headerImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:headerImg];
    [headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerImg.superview);
        make.top.mas_equalTo(100);
        make.size.mas_equalTo(60);
    }];
    //帐号栏
    UIView *nameView = UIView.new;
    nameView.backgroundColor = UIColor.lightGrayColor;
    nameView.layer.cornerRadius = 8;
    [self.view addSubview:nameView];
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerImg.mas_bottom).offset(30);
        make.centerX.equalTo(headerImg.superview);
        make.size.mas_equalTo(CGSizeMake(225, 40));
        
    }];
    
    //帐号图
    UIImageView *nameImg = UIImageView.new;
    nameImg.image=[UIImage imageNamed:@"loginZhanghao"];
    [self.view addSubview:nameImg];
    [nameImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameView.mas_left).offset(10);
        make.centerY.equalTo(nameView);
    }];
    
    //竖线
    UIImageView *nameImgLine = UIImageView.new;
    nameImgLine.backgroundColor = UIColor.darkGrayColor;
    [self.view addSubview:nameImgLine];
    [nameImgLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameImg.mas_right).offset(7.5);
        make.top.mas_equalTo(nameImg);
        make.height.mas_equalTo(nameImg);
        make.width.mas_equalTo(1);
    }];
    //    账户文本框
    UITextField *nameText = UITextField.new;
    nameText.tag=10;
    nameText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@ \
                                      { NSFontAttributeName : FontHeiti(12), NSForegroundColorAttributeName: UIColor.whiteColor }];
    nameText.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:nameText];
    [nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameImgLine.mas_right).offset(15);
        make.top.equalTo(nameView);
        make.height.equalTo(nameView);
        make.width.mas_equalTo(170);
    }];
    nameText.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    nameText.layer.masksToBounds = YES;
    nameText.layer.cornerRadius = 4;
    //键盘风格
    nameText.returnKeyType = UIReturnKeyNext;
    self.nameText = nameText;
    
    // 密码栏
    UIView *pwdView = UIView.new;
    pwdView.backgroundColor = HexColor(0xe3e3e3);
    pwdView.layer.cornerRadius = 8;
    [self.view addSubview:pwdView];
    [pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameView.mas_bottom).offset(15);
        make.centerX.equalTo(pwdView.superview);
        make.size.mas_equalTo(CGSizeMake(225, 40));
    }];
    
    // 密码图
    UIImageView *pwdImg = UIImageView.new;
    pwdImg.image = [UIImage imageNamed:@"loginMima"];
    [self.view addSubview:pwdImg];
    [pwdImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pwdView.mas_left).offset(10);
        make.centerY.equalTo(pwdView);
    }];
    
    //竖线
    UIImageView *pwdImgLine = UIImageView.new;
    pwdImgLine.backgroundColor = HexColor(0x1b6bb6);
    [self.view  addSubview:pwdImgLine];
    [pwdImgLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pwdImg.mas_right).offset(7.5);
        make.top.mas_equalTo(pwdImg);
        make.height.mas_equalTo(pwdImg);
        make.width.mas_equalTo(1);
    }];
    
    //密码文本框
    UITextField *pwdText = UITextField.new;
    pwdText.tag = 11;
    pwdText.secureTextEntry = YES;
    pwdText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@ \
                                     { NSFontAttributeName : FontHeiti(12), NSForegroundColorAttributeName: UIColor.whiteColor }];
    pwdText.font = [UIFont systemFontOfSize:12];
    pwdText.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    pwdText.layer.masksToBounds = YES;
    pwdText.layer.cornerRadius = 4;
    [self.view addSubview:pwdText];
    [pwdText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pwdImgLine.mas_right).offset(15);
        make.top.equalTo(pwdView);
        make.height.equalTo(pwdView);
        make.width.mas_equalTo(170);
    }];
    self.pwdText = pwdText;
    
    //忘记密码按钮
    UIButton *forgetBtn = UIButton.new;
    [forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [forgetBtn setTitleColor:HexColor(0x1b6bb6) forState:UIControlStateNormal];
    [self.view addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pwdView);
        make.top.equalTo(pwdView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
    //忘记密码按钮的点击事件
    
    [forgetBtn bk_addEventHandler:^(id sender){
        [SVProgressHUD showInfoWithStatus:@"请输入手机号码"];
    }forControlEvents:UIControlEventTouchUpInside];
    
    //返回主页面按钮
    UIButton *returnBtn = UIButton.new;
    [returnBtn setTitle:@"返回" forState:UIControlStateNormal];
    returnBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [returnBtn setTitleColor:HexColor(0x1b6bb6) forState:UIControlStateNormal];
    [self.view addSubview:returnBtn];
    [returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(forgetBtn.mas_right).offset(120);
        make.centerY.equalTo(forgetBtn);
    }];
    
    
    //注册按钮
    UIButton *registBtn = UIButton.new;
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    registBtn.titleLabel.textColor = [UIColor blackColor];
    registBtn.backgroundColor = HexColor(0x1b6bb6);
    registBtn.layer.cornerRadius = 5.0;
    [self.view addSubview:registBtn];
    [registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(forgetBtn.mas_left);
        make.top.equalTo(forgetBtn.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(97, 30));
    }];
    RAC(registBtn,enabled) = [LBLoginViewModel registerButtonEnabled:[RACTwoTuple pack:self.nameText.rac_textSignal :self.pwdText.rac_textSignal]];
    RAC(registBtn,backgroundColor) = [LBLoginViewModel registerButtonGroundColor:[RACTwoTuple pack:self.nameText.rac_textSignal :self.pwdText.rac_textSignal]];
    
    
    
    //登录按钮
    UIButton *loginBtn = UIButton.new;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.textColor = [UIColor blackColor];
    loginBtn.tag = 7;
    loginBtn.backgroundColor = HexColor(0x1b6bb6);
    loginBtn.layer.cornerRadius = 5.0;
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(registBtn.mas_right).offset(31);
        make.top.equalTo(registBtn);
        make.size.equalTo(registBtn);
    }];
    self.loginBtn = loginBtn;
    RAC(self.loginBtn,enabled) = [LBLoginViewModel logInButtondEnabled:[RACTwoTuple pack:self.nameText.rac_textSignal :self.pwdText.rac_textSignal]];
    RAC(self.loginBtn,backgroundColor) = [LBLoginViewModel logInButtondBackGroundColor:[RACTwoTuple pack:self.nameText.rac_textSignal :self.pwdText.rac_textSignal]];
    
    //登录的按钮事件
    [loginBtn bk_addEventHandler:^(id sender) {
        if (0 == nameText.text.length) {
            [SVProgressHUD showInfoWithStatus:@"请输入您的手机号"];
            return;
        }
        if (0 == pwdText.text.length) {
            [SVProgressHUD showInfoWithStatus:@"请输入您的登录密码"];
            return;
        }
        [SVProgressHUD show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            LBModelLogin *m = LBModelLogin.new;
            m.account = nameText.text;
            m.userToken = @"asdf";
            m.userId = @"number 1";
            self.block(m);
        });
    } forControlEvents:UIControlEventTouchUpInside];
    
}





@end
