//
//  LoginViewController.h
//  LBDemo
//
//  Created by 李兵 on 2019/6/25.
//  Copyright © 2019 ivan. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "LBModelLogin.h"

typedef void(^LoginBlock)(LBModelLogin* dataModel);
@interface LoginViewController : UIViewController

- (id)initWithBlock:(LoginBlock)block;

@end
