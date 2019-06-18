//
//  LBHomeViewControllerViewModel.m
//  LBDemo
//
//  Created by 李兵 on 2019/6/18.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBHomeViewControllerViewModel.h"
#import "LBModelHomeView.h"

@interface LBHomeViewControllerViewModel ()

@property (strong , nonatomic, readwrite) RACCommand *fetchCommand;

@property (strong , nonatomic, readwrite) RACSubject *subjectDataList;

@property (strong , nonatomic, readwrite) RACSignal *signalDataList;

@end

@implementation LBHomeViewControllerViewModel

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
    m.displayName = @"RACCommand 改动";
    
    [homeModels addObject:m];
    return homeModels.copy;
}

- (void)p_dealData:(NSArray<LBModelHomeView *> *)models {
    [self.subjectDataList sendNext:models];
}

#pragma mark getter
- (RACCommand *)fetchCommand {
    if (!_fetchCommand) {
        @weakify(self);
        _fetchCommand =
        [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal defer:^RACSignal * _Nonnull{
                return [[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                            @strongify(self);
                            [subscriber sendNext:[self p_tableViewDataSource]];
                            [subscriber sendCompleted];
                            return nil;
                        }]
                         doNext:^(id  _Nullable x) {
                             [self p_dealData:x];
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


@end
