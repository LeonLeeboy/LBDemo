//
//  EHIHiCarDetectionModel.m
//  1haiiPhone
//
//  Created by LuckyCat on 2018/12/20.
//  Copyright © 2018年 EHi. All rights reserved.
//

#import "EHIHiCarDetectionModel.h"

@implementation EHIHiCarDetectionModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"DetectionList" : [EHIHiCarDetectionDetailModel class]
             };
}

@end


@implementation EHIHiCarDetectionDetailModel

@end
