//
//  EHiMemberShipRightsModel.h
//  LBDemo
//
//  Created by 李兵 on 2019/8/22.
//  Copyright © 2019 ivan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EHiMemberShipRightsItemModel : NSObject

/** text */
@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, assign) NSInteger index;

@end

#pragma mark -

@interface EHiMemberShipRightsModel : NSObject

@property (nonatomic, assign) CGFloat lineSpace;

/** text */
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSMutableArray<EHiMemberShipRightsItemModel *> *itemModels;

@end


NS_ASSUME_NONNULL_END
