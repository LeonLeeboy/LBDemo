//
//  EHICalendarViewController.h
//  LBDemo
//
//  Created by 李兵 on 2020/3/6.
//  Copyright © 2020 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EHICalendarViewController : UIViewController

//会把被占用的日期返回给你们，如果该车每天都可租，不曾被占用， items 就是 []
//"type": "2"// 1 全天不可租 2 半天不可租
@property (nonatomic, strong) NSArray *items;

//记录上次选择的数据 时间
@property (nonatomic, strong) NSArray *timeArr;

@property (nonatomic, copy) void(^timeCallBack)(id data);

@end

NS_ASSUME_NONNULL_END
