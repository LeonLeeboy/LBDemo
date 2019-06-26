//
//  LBLoginCenter.h
//  LBDemo
//
//  Created by 李兵 on 2019/6/25.
//  Copyright © 2019 ivan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBModelLogin.h"


typedef enum : NSUInteger {
    LBLoginCenterStateNotLogin = 0,
    LBLoginCenterStateLogining,
    LBLoginCenterStateLogin
}LBLoginCenterState;

typedef void(^LBLoginCenterResult)(BOOL loginSuccess);
typedef void(^LBLoginCenterSignUpResult)(NSError* error);

@interface LBLoginCenter : NSObject

+ (instancetype)instance;

@property (nonatomic, assign, readonly) LBLoginCenterState loginState;
@property (nonatomic, strong, readonly) LBModelLogin * sessionInfo;


- (void)loginWithBlock:(LBLoginCenterResult)block;

@end
