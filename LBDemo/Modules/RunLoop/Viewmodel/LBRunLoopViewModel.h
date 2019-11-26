//
//  LBRunLoopViewModel.h
//  LBDemo
//
//  Created by 李兵 on 2019/11/12.
//  Copyright © 2019 ivan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LBRunLoopViewModel : NSObject

- (void)getData;

- (void)destroyTimer;

- (void)stopTimer;

- (void)fireTimer;

@end

NS_ASSUME_NONNULL_END
