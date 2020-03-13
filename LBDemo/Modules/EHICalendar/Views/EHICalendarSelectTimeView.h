//
//  EHICalendarSelectTimeView.h
//  LBDemo
//
//  Created by 李兵 on 2020/3/13.
//  Copyright © 2020 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EHIStoreOpenCloseModel;

@interface EHICalendarSelectTimeView : UIView

/** 取车时间源 */
@property (nonatomic, strong) EHIStoreOpenCloseModel *openModel;

/** 还车时间源 */
@property (nonatomic, strong) EHIStoreOpenCloseModel *closeModel;


@end

