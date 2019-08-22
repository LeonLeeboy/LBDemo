//
//  EHIOnlinePreAuthModel.h
//  LBDemo
//
//  Created by 李兵 on 2019/8/22.
//  Copyright © 2019 ivan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EHIOnlinePreAuthItemModel : NSObject

@property (nonatomic, copy) NSString *text;
/**  */
@property (nonatomic, copy) NSString *havePreAuthedText;

@property (nonatomic, copy) NSString *noPreAuthedText;

@property (nonatomic, copy) UIColor *havePreAuthedTextColor;

@property (nonatomic, assign) BOOL havePreAuthed;

@property (nonatomic, assign) NSInteger index;

@end

@interface EHIOnlinePreAuthModel : NSObject

@property (nonatomic, assign) CGFloat lineSpace;

/** text */
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSMutableArray<EHIOnlinePreAuthItemModel *> *itemModels;

@end

NS_ASSUME_NONNULL_END
