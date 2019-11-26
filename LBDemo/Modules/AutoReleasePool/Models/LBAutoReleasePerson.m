//
//  LBAutoReleasePerson.m
//  LBDemo
//
//  Created by 李兵 on 2019/11/13.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBAutoReleasePerson.h"

@implementation LBAutoReleasePerson

+ (instancetype)object {
    return [[self alloc] init];
}

- (void)dealloc {
    NSLog(@"LBAutoReleasePerson Release");
}

@end
