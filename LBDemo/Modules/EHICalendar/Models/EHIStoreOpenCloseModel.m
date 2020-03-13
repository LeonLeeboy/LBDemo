//
//  EHIStoreOpenCloseModel.m
//  LBDemo
//
//  Created by 李兵 on 2020/3/13.
//  Copyright © 2020 ivan. All rights reserved.
//

#import "EHIStoreOpenCloseModel.h"

@implementation EHIStoreOpenCloseModel

- (instancetype)initWithPickCarOpenTimeStr:(NSString *)pickCarOpenTimeStr
                       pickCarCloseTimeStr:(NSString *)pickCarCloseTimeStr
                         returnCarOpenTime:(NSString *)returnCarOpenTimeStr
                     returnCarCloseTimeStr:(NSString *)returnCarCloseTimeStr {
    if (self = [super init]) {
        self.pickCarOpenTimeStr = pickCarOpenTimeStr;
        self.pickCarCloseTimeStr = pickCarCloseTimeStr;
        self.returnCarOpenTimeStr = returnCarOpenTimeStr;
        self.returnCarCloseTimeStr = returnCarCloseTimeStr;
    }
    return self;
}

@end
