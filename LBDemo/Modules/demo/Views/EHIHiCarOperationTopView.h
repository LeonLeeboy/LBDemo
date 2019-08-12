//
//  EHIHiCarOperationTopView.h
//  LBDemo
//
//  Created by 李兵 on 2019/8/12.
//  Copyright © 2019 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHIHiCarOperationTopModel : NSObject

/** carName : 标致301 */
@property (nonatomic , copy) NSString *carName;

/** siteInfo : 5座/自动 */
@property (nonatomic , copy) NSString *carSiteInfo;

/** 取车时间 2019.07.22 09:30 */
@property (nonatomic , copy) NSString *getCarTime;

/** 上海 长宁店 */
@property (nonatomic , copy) NSString *location;

/** 古北路21号一层靠近古北路长宁路口… */
@property (nonatomic , copy) NSString *locationDetail;

/** 古北路21号一层靠近古北路长宁路口… */
@property (nonatomic , copy) NSString *carImageURLStr;

@end

typedef void(^hicarOperationEventdidClick)(void);

NS_ASSUME_NONNULL_BEGIN

@interface EHIHiCarOperationTopView : UIView

@property (nonatomic, copy) hicarOperationEventdidClick didClickPhone;

@property (nonatomic, copy) hicarOperationEventdidClick didClickCarDetail;

- (void)renderViewWithModel:(EHIHiCarOperationTopModel *)model;

@end

NS_ASSUME_NONNULL_END
