//
//  Utils.m
//  LBDemo
//
//  Created by 李兵 on 2019/12/6.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (NSString *)getRandomUUid {
    CFUUIDRef uuidRef = CFUUIDCreate(nil);
    
    NSString *uuidStr = (NSString *)CFBridgingRelease(CFUUIDCreateString(nil, uuidRef));
    
    return uuidStr;
}

@end
