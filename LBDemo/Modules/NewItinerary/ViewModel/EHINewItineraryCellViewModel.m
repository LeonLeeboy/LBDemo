//
//  EHINewItineraryCellViewModel.m
//  LBDemo
//
//  Created by 李兵 on 2019/9/20.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "EHINewItineraryCellViewModel.h"

#import "EHINewItineraryCellContentModel.h"
#import "EHINewItineraryMessagesItemModel.h"

@implementation EHINewItineraryCellViewModel

#pragma mark - public 
+ (NSArray<NSString *> *)getDockSitesWithModel:(EHINewItineraryCellContentModel *)model {
    NSMutableArray *rst = [NSMutableArray array];
    for (EHINewItineraryDockSiteModel *obj in model.Docks) {
        if (obj.address && ![obj.address isEqualToString:@""]) {
            [rst addObject:obj.address];
        }
    }
    return rst.copy;
}

+ (NSArray<EHINewItineraryMessagesItemModel *> *)getMessagesWithModel:(EHINewItineraryCellContentModel *)model {
    NSMutableArray<EHINewItineraryMessagesItemModel *> *rst = [NSMutableArray array];
    
    // 添加 取车 还车时间
    if (model.type == EHINewItineraryTypeSelfDriving) {
        EHINewItineraryMessagesItemModel *pickModel = [[EHINewItineraryMessagesItemModel alloc] init];
        pickModel.iconImageName = @"newItinerary_pickAndReturnTime";
        pickModel.normalValue = [NSString stringWithFormat:@"%@至%@",model.pickUpCarDate,model.returnCarDate];
        pickModel.hiddenBottomLine = NO;
        
        [rst addObject:pickModel];
    }
    
    
    // 乘客信息
    if (model.passengerModels.count > 0 && model.type == EHINewItineraryTypeChauffeur) {
       
        EHINewItineraryMessagesItemModel *passenger = [[EHINewItineraryMessagesItemModel alloc] init];
        passenger.iconImageName = @"NewItitnerary_passengerInfo";
        passenger.des = @"乘客信息";
        passenger.desAttributedValue = [EHINewItineraryCellViewModel p_getPassengerAttributedStringWithModel:model];
        passenger.hiddenBottomLine = YES;
        
        [rst addObject:passenger];
    }
    // 司机信息
    if (model.type == EHINewItineraryTypeChauffeur) {
        
        EHINewItineraryMessagesItemModel *driver = [[EHINewItineraryMessagesItemModel alloc] init];
        driver.iconImageName = @"newItitnerary_driverInfo";
        driver.des = @"司机信息";
        driver.desAttributedValue = [EHINewItineraryCellViewModel p_getDrivergerAttributedStringWithModel:model];
        driver.hiddenBottomLine = YES;
        
        [rst addObject:driver];
    }
    // 车辆信息
    EHINewItineraryMessagesItemModel *carInfo = [[EHINewItineraryMessagesItemModel alloc] init];
    carInfo.iconImageName = @"newItinerary_carInfo";
    carInfo.des = @"车辆信息";
    carInfo.desAttributedValue = [[NSAttributedString alloc] initWithString:model.carBaseInfo?:@""];
    carInfo.hiddenBottomLine = YES;
    
    [rst addObject:carInfo];
    
    
    
    return rst;
}

#pragma mark - private
/** 专车类型·乘客信息 */
+ (NSAttributedString *)p_getPassengerAttributedStringWithModel:(EHINewItineraryCellContentModel *)model {
    NSMutableAttributedString *rst = [[NSMutableAttributedString alloc] init];

    for (EHINewItineraryPassengerModel *obj in model.passengerModels) {
        NSMutableAttributedString *attri = [EHINewItineraryCellViewModel p_getOnePassenGerAttributedWithName:obj.name phoneNum:obj.phoneNum];
        [rst appendAttributedString:attri];
        [rst appendString:@"\n"];
    }
    
    rst.lineSpacing = 12;
    return rst;
}

/** 专车类型·司机信息 */
+ (NSAttributedString *)p_getDrivergerAttributedStringWithModel:(EHINewItineraryCellContentModel *)model {
    NSMutableAttributedString *rst = [[NSMutableAttributedString alloc] init];
    
    NSMutableAttributedString *nameAttri = [[NSMutableAttributedString alloc] initWithString:model.chauffeurDriverInfo.name];
    NSMutableAttributedString *lineAttri = [[NSMutableAttributedString alloc] initWithString:@" - "];
    NSMutableAttributedString *phoneNumAttri = [[NSMutableAttributedString alloc] initWithString:model.chauffeurDriverInfo.phoneNum];
    
    
    [rst appendAttributedString:nameAttri];
    [rst appendAttributedString:lineAttri];
    [rst appendAttributedString:phoneNumAttri];
    
    nameAttri.color = kEHIHexColor_333333;
    lineAttri.color = kEHIHexColor_EEEEEE;
    phoneNumAttri.color = kEHIHexColor_333333;
    
    return rst;
}

/** 自驾类型（取车时间·还车时间） */
+ (NSMutableAttributedString *)p_getOnePassenGerAttributedWithName:(NSString *)name
                                                          phoneNum:(NSString *)phoneNum {
    
    NSMutableAttributedString *rst = [[NSMutableAttributedString alloc] init];
    
    NSMutableAttributedString *nameAttri = [[NSMutableAttributedString alloc] initWithString:name];
    
     NSMutableAttributedString *lineAttri = [[NSMutableAttributedString alloc] initWithString:@" - "];
    
    NSMutableAttributedString *phoneNumAttri = [[NSMutableAttributedString alloc] initWithString:phoneNum];
    
    [rst appendAttributedString:nameAttri];
    [rst appendAttributedString:lineAttri];
    [rst appendAttributedString:phoneNumAttri];
    
    nameAttri.color = kEHIHexColor_333333;
    lineAttri.color = kEHIHexColor_EEEEEE;
    phoneNumAttri.color = kEHIHexColor_333333;
    
    return rst;
}

@end
