//
//  EHINewItineraryCellContentModel.h
//  LBDemo
//
//  Created by 李兵 on 2019/9/20.
//  Copyright © 2019 ivan. All rights reserved.
//
// 渲染cell 的model
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 地址模型
#pragma mark -

@interface EHINewItineraryAddressModel : NSObject

/** 城市ID */
@property (nonatomic, copy) NSString *cityID;

/** 门店ID */
@property (nonatomic, copy) NSString *shopID;

/** 城市名称 */
@property (nonatomic, copy) NSString *cityName;

/** 开始地址  门店 */
@property (nonatomic, copy) NSString *shopName;

/** 地址 */
@property (nonatomic, copy) NSString *address;

/** 精度 */
@property (nonatomic, copy) NSString *latitude;

/** 纬度 */
@property (nonatomic, copy) NSString *longitude;

@end

#pragma mark - 专车司机信息
#pragma mark -

@interface EHINewItineraryPassengerModel  : NSObject

/** 姓名 */
@property (nonatomic, copy) NSString *name;

/** 手机号 */
@property (nonatomic, copy) NSString *phoneNum;

@end

#pragma mark - 停靠点Model
#pragma mark -

@interface EHINewItineraryDockSiteModel  : NSObject

/** 城市名称 */
@property (nonatomic, copy) NSString *cityName;

/** 地址 */
@property (nonatomic, copy) NSString *address;

/** 精度 */
@property (nonatomic, copy) NSString *latitude;

/** 纬度 */
@property (nonatomic, copy) NSString *longitude;

@end

@interface EHINewItineraryCellContentModel : NSObject

#pragma mark 顶部显示
/** 订单ID */
@property (nonatomic, copy) NSString *orderID;

/** 订单类型*/
@property (nonatomic, assign) EHINewItineraryType type;

/** 订单状态 */
@property (nonatomic, copy) NSString *orderStatus;

/** 订单日期（2019年10月2日） */
@property (nonatomic, copy) NSString *orderDate;

/** 订单标题（例如：专车-送机、专车-接机，自驾）*/
@property (nonatomic, copy) NSString *orderTitle;

/** 专车上车时间 */
@property (nonatomic, copy) NSString *getOnTimeDate;

/** 开始地址model */
@property (nonatomic, strong) EHINewItineraryAddressModel *beginAddresModel;

/** 结束地址model */
@property (nonatomic, strong) EHINewItineraryAddressModel *endAddresModel;

/** 自驾取车时间（yyyy-MM-dd HH:mm） */
@property (nonatomic, copy) NSString *pickUpCarDate;

/** 自驾还车时间（yyyy-MM-dd HH:mm） */
@property (nonatomic, copy) NSString *returnCarDate;

/** 自驾租期（2天5小时）*/
@property (nonatomic, copy) NSString *orderDuration;

/** 车辆基本信息（宝马S30LE 5座、荣威E50或同组车型车） */
@property (nonatomic, copy) NSString *carBaseInfo;

/** 专车乘客信息List< PassengerModel > */
@property (nonatomic, strong) NSArray<EHINewItineraryPassengerModel *> *passengerModels;

/** 专车司机信息 */
@property (nonatomic, strong) EHINewItineraryPassengerModel *chauffeurDriverInfo;

/** 停靠点 */
@property (nonatomic, strong) NSArray<EHINewItineraryDockSiteModel *> *Docks;


@end

NS_ASSUME_NONNULL_END
