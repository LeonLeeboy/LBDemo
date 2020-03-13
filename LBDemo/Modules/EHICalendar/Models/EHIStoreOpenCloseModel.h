//
//  EHIStoreOpenCloseModel.h
//  LBDemo
//
//  Created by 李兵 on 2020/3/13.
//  Copyright © 2020 ivan. All rights reserved.
//
//  小时分钟选择模型
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EHIStoreOpenCloseModel : NSObject

/** 类型： HH:mm */
/** 取车开门时间 */
@property (nonatomic, copy) NSString *pickCarOpenTimeStr;

/** 取车关门时间 */
@property (nonatomic, copy) NSString *pickCarCloseTimeStr;

/** 还车关门时间 */
@property (nonatomic, copy) NSString *returnCarCloseTimeStr;

/** 还车开门时间 */
@property (nonatomic, copy) NSString *returnCarOpenTimeStr;


- (instancetype)initWithPickCarOpenTimeStr:(NSString *)pickCarOpenTimeStr
                       pickCarCloseTimeStr:(NSString *)pickCarCloseTimeStr
                         returnCarOpenTime:(NSString *)returnCarOpenTimeStr
                     returnCarCloseTimeStr:(NSString *)returnCarCloseTimeStr;




@end

NS_ASSUME_NONNULL_END
