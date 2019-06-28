//
//  LBHomeViewControllerViewModel.m
//  LBDemo
//
//  Created by 李兵 on 2019/6/18.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBHomeViewControllerViewModel.h"
#import "LBModelHomeView.h"
#import "LBBlockVC.h"

@interface LBModelCommon ()

@property (assign , nonatomic , readwrite) BOOL hasMore;

@property (strong , nonatomic , readwrite) NSArray *dataSource;
@end

@implementation LBModelCommon
- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}
@end

@interface LBHomeViewControllerViewModel ()

@property (strong , nonatomic, readwrite) RACCommand *fetchCommand;

@property (strong , nonatomic, readwrite) RACSubject *subjectDataList;

@property (strong , nonatomic, readwrite) RACSignal *signalDataList;

@property (strong , nonatomic, readwrite) LBModelCommon *commonModel;

@end

@implementation LBHomeViewControllerViewModel

static int count = 0;

#pragma mark life cycle
- (void)dealloc{
    [self cancleFetch];
}

#pragma mark public
- (void)cancleFetch{};

#pragma mark private
- (NSArray *)p_tableViewDataSource {
    NSMutableArray<LBModelHomeView *> *homeModels = [NSMutableArray array];

    LBModelHomeView *m = LBModelHomeView.new;
    m.displayName = @"控制器的中间vc剔除跳转";
    
    LBModelHomeView *m1 = LBModelHomeView.new;
    m1.displayName = @"blcok 中是stack ，还是malloc";
    m1.targetName = NSStringFromClass([LBBlockVC class]);

    LBModelHomeView *m2 = LBModelHomeView.new;
    m2.displayName = @"RACSignal 的基本操作";

    LBModelHomeView *m3 = LBModelHomeView.new;
    m3.displayName = @"深拷贝，浅拷贝的实现，以及YYKit中帮我们实现的玩意";

    [homeModels addObject:m];
    [homeModels addObject:m1];
    [homeModels addObject:m2];
    [homeModels addObject:m3];
    return homeModels.copy;
}

- (void)p_dealData:(NSArray<LBModelHomeView *> *)models {
    self.commonModel.dataSource = [self.commonModel.dataSource arrayByAddingObjectsFromArray:models];
    self.commonModel.hasMore = (models.count == 30) && (count < 3);
    [self.subjectDataList sendNext:self.commonModel];
}

#pragma mark getter
- (RACCommand *)fetchCommand {
    if (!_fetchCommand) {
        @weakify(self);
        __block int pageIndex = 0;
        _fetchCommand =
        [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal defer:^RACSignal * _Nonnull{
                return [[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                            @strongify(self);
                            if ([input boolValue]) {
                                pageIndex = 1;
                            }
                            [subscriber sendNext:[self p_tableViewDataSource]];
                            [subscriber sendCompleted];
                            return nil;
                         }]
                         doNext:^(id  _Nullable x) {
                             if ([input boolValue]) { //第一次置空
                                 self.commonModel = nil;
                                 count = 0;
                             }
                             [self p_dealData:x];
                             pageIndex++;
                             count++;
                         }] takeUntil:[self rac_signalForSelector:@selector(cancleFetch)]];
            }];
        }];
    }
    return _fetchCommand;
}

- (RACSubject *)subjectDataList{
    if (!_subjectDataList) {
        _subjectDataList = RACSubject.subject;
    }
    return _subjectDataList;
}

- (RACSignal *)signalDataList{
    if (!_signalDataList) {
        _signalDataList = self.subjectDataList.replayLast;
    }
    return _signalDataList;
}

- (LBModelCommon *)commonModel{
    if (!_commonModel) {
        _commonModel = LBModelCommon.new;
    }
    return _commonModel;
}

- (void)setObject:(id)otherTerminal forKeyedSubscript:(NSString *)key {
    [self setValue:otherTerminal forKeyPath:key];
}


@end
