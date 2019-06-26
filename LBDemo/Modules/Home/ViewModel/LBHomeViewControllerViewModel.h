//
//  LBHomeViewControllerViewModel.h
//  LBDemo
//
//  Created by 李兵 on 2019/6/18.
//  Copyright © 2019 ivan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LBModelCommon : NSObject

@property (assign , nonatomic , readonly) BOOL hasMore;

@property (strong , nonatomic , readonly) NSArray *dataSource;

@end

@interface LBHomeViewControllerViewModel : NSObject

@property (strong , nonatomic, readonly) RACCommand *fetchCommand;

@property (strong , nonatomic, readonly) RACSignal *signalDataList;

- (void)cancleFetch;



@end


NS_ASSUME_NONNULL_END
