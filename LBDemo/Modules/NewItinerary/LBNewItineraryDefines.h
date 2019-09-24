//
//  LBNewItineraryDefines.h
//  LBDemo
//
//  Created by 李兵 on 2019/9/20.
//  Copyright © 2019 ivan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LBNewItineraryDefines : NSObject

typedef NS_ENUM(NSInteger,EHINewItineraryType) {
    EHINewItineraryTypeChauffeur,       //!> 专车
    EHINewItineraryTypeSelfDriving      //!> 自驾
};

@end

NS_ASSUME_NONNULL_END
