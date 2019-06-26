//
//  LBLoginCenter.m
//  LBDemo
//
//  Created by 李兵 on 2019/6/25.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LoginViewController.h"

#import "LBLoginCenter.h"

@interface LBLoginCenter ()

@property (nonatomic, assign, readwrite) LBLoginCenterState loginState;
@property (nonatomic, strong, readwrite) LBModelLogin* sessionInfo;

@end


@implementation LBLoginCenter

#pragma mark - life cycle
+ (instancetype)instance {
    static dispatch_once_t onceToken;
    static id _shareinstaben = nil;
    dispatch_once(&onceToken, ^{
        _shareinstaben = [[self alloc] init];
    });
    return _shareinstaben;
}

- (instancetype)init {
    if (self = [super init]) {
        [self dataLoad];
        self.loginState = LBLoginCenterStateNotLogin;
    }
    return self;
}

- (void)loginWithBlock:(LBLoginCenterResult)block {
    if ( self.loginState == LBLoginCenterStateLogin
        && self.sessionInfo.account.length
        && self.sessionInfo.userToken.length ) {
        if (block) {
            block(YES);
        }
    } else if (self.loginState != LBLoginCenterStateLogining) {
        UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
        if (keyWindow.rootViewController) {
            self.loginState = LBLoginCenterStateLogining;
            @weakify(self);
            __block LoginViewController* loginVC = [[LoginViewController alloc] initWithBlock:^(LBModelLogin *dataModel) {
                @strongify(self);
                self.sessionInfo = dataModel;
                self.loginState = LBLoginCenterStateLogin;
                [loginVC dismissViewControllerAnimated:YES completion:nil];
                block(YES);
            }];
            UIViewController *c = keyWindow.rootViewController;
            [c presentViewController:loginVC animated:YES completion:nil];
        }
    }
}

- (void)logout {
    self.sessionInfo = nil;
    self.loginState = LBLoginCenterStateNotLogin;
}

#pragma mark public
- (void)dataLoad
{
#define dataLoadProperty(key) \
    { \
        NSData* data = [NSUserDefaults.standardUserDefaults dataForKey:NSStringFromSelector(@selector(key))]; \
        self.key = (id)[LBModelBase unarchiveFromData:data]; \
    }

    
    dataLoadProperty(sessionInfo);
    self.loginState = [NSUserDefaults.standardUserDefaults integerForKey:NSStringFromSelector(@selector(loginState))];
}

- (void)dataSave
{
#define dataSaveProperty(key) \
    if (self.key) { \
        [NSUserDefaults.standardUserDefaults setObject:self.key.archiveToData forKey:NSStringFromSelector(@selector(key))]; \
    } else { \
        [NSUserDefaults.standardUserDefaults removeObjectForKey:NSStringFromSelector(@selector(key))]; \
}
    
    dataSaveProperty(sessionInfo);
    [NSUserDefaults.standardUserDefaults setInteger:self.loginState forKey:NSStringFromSelector(@selector(loginState))];
    
    [NSUserDefaults.standardUserDefaults synchronize];
}


@end
