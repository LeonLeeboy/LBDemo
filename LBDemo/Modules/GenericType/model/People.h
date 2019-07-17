//
//  People.h
//  LBDemo
//
//  Created by 李兵 on 2019/7/17.
//  Copyright © 2019 ivan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface People<__covariant T> : NSObject

@property (nonatomic, strong) T language;

@end

NS_ASSUME_NONNULL_END
