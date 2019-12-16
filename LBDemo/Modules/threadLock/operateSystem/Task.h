//
//  Task.h
//  LBDemo
//
//  Created by 李兵 on 2019/12/6.
//  Copyright © 2019 ivan. All rights reserved.
//
//  基本任务对象
//

#import <UIKit/UIKit.h>
#include <uuid/uuid.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : UIView

@property (nonatomic, strong, readonly) NSString *ID;

- (instancetype)initWithTarget:(id)target methond:(SEL)sel arguments:(NSArray *)arguments;

@end
NS_ASSUME_NONNULL_END
