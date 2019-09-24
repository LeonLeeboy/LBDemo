//
//  EHINewItineraryViewModel.h
//  LBDemo
//
//  Created by 李兵 on 2019/9/20.
//  Copyright © 2019 ivan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EHINewItinerayItemModel;

@interface EHINewItineraryViewModel : NSObject

/** 数据源 */
@property (nonatomic, strong, readonly) NSArray<EHINewItinerayItemModel *> *dataSource;

/** 刷新UI回调 */
@property (nonatomic, strong) void (^refreshUI)(NSArray<EHINewItinerayItemModel *> *dataSource);

- (void)getMyNewItineraryDataWith:(id)parames;

@end

