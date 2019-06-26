//
//  LBLoginViewModel.h
//  LBDemo
//
//  Created by 李兵 on 2019/6/25.
//  Copyright © 2019 ivan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LBLoginViewModel : NSObject

///login Button Enabled ?
+ (RACSignal *)logInButtondEnabled:(RACTuple *)signals;

/// login Button backgroundColor?
+ (RACSignal *)logInButtondBackGroundColor:(RACTuple *)signals;

///register Button Enabled ?
+ (RACSignal *)registerButtonEnabled:(RACTuple *)signals;

///register Button backgroundColor?
+ (RACSignal *)registerButtonGroundColor:(RACTuple *)signals;

@end

NS_ASSUME_NONNULL_END
