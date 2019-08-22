//
//  EHIHiCarDetectionModel.h
//  1haiiPhone
//
//  Created by LuckyCat on 2018/12/20.
//  Copyright © 2018年 EHi. All rights reserved.
//
//  嗨车检测车辆结果
//

#import <Foundation/Foundation.h>

@class EHIHiCarDetectionDetailModel;

@interface EHIHiCarDetectionModel : NSObject

/** 检测结果 */
@property (nonatomic, assign) BOOL DetectionResult;

/** 错误描述 */
@property (nonatomic, copy) NSString *DetectionErrorMessage;

/** 检测详细列表 */
@property (nonatomic, copy) NSArray<EHIHiCarDetectionDetailModel *> *DetectionList;

@end


#pragma mark - 检测结果数据：每一项详情

@interface EHIHiCarDetectionDetailModel : NSObject

/** Id */
@property (nonatomic, assign) NSInteger Id;

/** 标题 */
@property (nonatomic, copy) NSString *Title;

/** 检测结果 */
@property (nonatomic, assign) BOOL Result;

@end
