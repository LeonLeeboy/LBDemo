//
//  LBLoginViewModel.m
//  LBDemo
//
//  Created by 李兵 on 2019/6/25.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBLoginViewModel.h"

static inline UIColor *RGBA(int R, int G, int B, double A) {
    return [UIColor colorWithRed: R/255.0 green: G/255.0 blue: B/255.0 alpha: A];
}

static inline UIColor *HexColor(int v) {
    return RGBA((double)((v&0xff0000)>>16), (double)((v&0xff00)>>8), (double)(v&0xff), 1.0f);
}

#pragma mark -
@implementation LBLoginViewModel

#pragma mark public
/// 登陆按钮 userName.length = 11 && pwd.length > 6
+ (RACSignal *)logInButtondEnabled:(RACTuple *)signals {
    RACSignal *nameSignal = signals.first;
    RACSignal *pwdSignal = signals.second;
    return [RACSignal combineLatest:@[nameSignal , pwdSignal] reduce:^id _Nonnull(NSString *userName,NSString *pwd){
        return @([LBLoginViewModel p_evaluateName:userName pwd:pwd]);
    }];
}

/// 登陆按钮 userName.length = 11 && pwd.length > 6 正常显示，否则灰色
+ (RACSignal *)logInButtondBackGroundColor:(RACTuple *)signals {
    return [[LBLoginViewModel logInButtondEnabled:signals] map:^id _Nullable(NSNumber *  _Nullable value) {
        UIColor *bgColor;
        if ([value boolValue]) {
            bgColor = HexColor(0x1b6bb6);
        }else {
             bgColor = [UIColor lightGrayColor];
        }
        return bgColor;
    }];
}

+ (RACSignal *)registerButtonEnabled:(RACTuple *)signals {
    RACSignal *nameSignal = signals.first;
    RACSignal *pwdSignal = signals.second;
    return [RACSignal combineLatest:@[nameSignal , pwdSignal] reduce:^id _Nonnull(NSString *userName , NSString *pwd) {
        BOOL result = NO;
        result = [LBLoginViewModel p_evaluateName:userName] && [LBLoginViewModel p_evalueatePwdGreaterThan11:pwd];
        return @(result);
    }];
}

+ (RACSignal *)registerButtonGroundColor:(RACTuple *)signals {
    return [[LBLoginViewModel registerButtonEnabled:signals] map:^id _Nullable(id  _Nullable value) {
        if ([value boolValue]) {
            return HexColor(0x1b6bb6);
        }else {
            return UIColor.lightGrayColor;
        }
    }];
}

#pragma mark private
/// 登陆按钮的验证
+ (BOOL)p_evaluateName:(NSString *)name pwd:(NSString *)pwd {
    return [LBLoginViewModel p_evaluateName:name] && [self p_evalueatePwd:pwd];
}

+ (BOOL)p_evaluateName:(NSString *)name {
    return name.length == 11;
}

+ (BOOL)p_evalueatePwd:(NSString *)pwd {
    return pwd.length >= 3;
}

+ (BOOL)p_evalueatePwdGreaterThan11:(NSString *)pwd {
    return pwd.length >= 11;
}

@end
