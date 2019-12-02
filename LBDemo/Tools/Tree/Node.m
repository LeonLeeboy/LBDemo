//
//  Node.m
//  LBDemo
//
//  Created by 李兵 on 2019/12/2.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "Node.h"

@implementation Node

- (instancetype)initWithValue:(id)value {
    if (self = [super init]) {
        self.value = value;
    }
    return value;
}

@end
