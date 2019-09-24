//
//  EHINewItineraryMessagesItemModel.m
//  LBDemo
//
//  Created by 李兵 on 2019/9/20.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "EHINewItineraryMessagesItemModel.h"

@implementation EHINewItineraryMessagesItemModel

- (BOOL)hiddenNormalValue {
    return (self.des && ![self.des isEqualToString:@""])?YES:NO;
}


@end
