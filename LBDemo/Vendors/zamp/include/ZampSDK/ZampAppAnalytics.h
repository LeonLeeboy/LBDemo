//
//  ZampAppAnalytics.h
//  BusinessTrack_hargen
//
//  Created by hargen on 15/5/14.
//  Copyright (c) 2015年 hargen. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CURRENCY_CNY @"CNY"
#define CURRENCY_HKD @"HKD"
#define CURRENCY_TWD @"TWD"
#define CURRENCY_USD @"USD"
#define CURRENCY_EUR @"EUR"
#define CURRENCY_GBP @"GBP"
#define CURRENCY_JPY @"JPY"
#define PAYTYPE_APPSTORE @"appstore"
#define PAYTYPE_UNIONPAY @"unionpay"
#define PAYTYPE_LAKALA @"lakala"
#define PAYTYPE_ALIPAY @"alipay"
#define PAYTYPE_TENPAY @"tenpay"
#define PAYTYPE_BAIDUBAO @"baifubao"

@interface ZampAppAnalytics : NSObject

+(void) initWithAppKey:(NSString*)appKey channelId:(NSString*)channelId;
+(void) onAppLaunch;
+(void) onPageStart:(NSString*)pageName;
+(void) onPageEnd:(NSString*)pageName;
+(void) onGeoWithLongitude:(double)longitude latitude:(double)latitude coor:(NSString*) coor;
+(void) onAppEvent:(NSString*)eventId label:(NSString*)label parameters:(NSDictionary*)dict;
+(void) setReportUncaughtExceptions:(BOOL)enabled;
+(void) onError:(NSException*)exception;

+(void) onRegister:(NSString*)userId isConversion:(BOOL)bConv;
+(void) onLogin:(NSString*)userId isConversion:(BOOL)bConv;
+(void) onCart:(NSString*)productId amount:(int)amount isConversion:(BOOL)bConv;
+(void) onCartSubmit:(NSString*)userId isConversion:(BOOL)bConv;
+(void) addItem:(NSString*)categoryId productId:(NSString*)productId price:(float) price amount:(int)amount;
+(void) onOrderSumbit:(NSString*)userId orderId:(NSString*)orderId total:(float)total currency:(NSString*)currency isConversion:(BOOL)bConv;
+(void) onPay:(NSString*)userId orderId:(NSString*)orderId total:(float)total currency:(NSString*)currency payType:(NSString*)payType isConversion:(BOOL)bConv;

+(void) onRemarketing:(NSString*)pageName info:(NSDictionary*)params;
+(void) onConversion:(NSString*)conversionType info:(NSDictionary*)params;

+(void) setLogStatus:(BOOL)enabled;
+(BOOL) getLogStatus;
@end
