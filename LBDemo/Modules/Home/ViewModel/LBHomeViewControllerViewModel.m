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
    m.targetName = @"EHIUpdateAPPViewController";
 
    LBModelHomeView *m1 = LBModelHomeView.new;
    m1.displayName = @"blcok 中是stack ，还是malloc";
    m1.targetName = NSStringFromClass([LBBlockVC class]);

    LBModelHomeView *m2 = LBModelHomeView.new;
    m2.displayName = @"RACSignal 的基本操作";
    m2.targetName = @"EHIInputLicensePlateViewController";

    LBModelHomeView *m3 = LBModelHomeView.new;
    m3.displayName = @"深拷贝，浅拷贝的实现，以及YYKit中帮我们实现的玩意";
    m3.targetName = @"LBEHIDemoViewController";
    
    LBModelHomeView *m4 = LBModelHomeView.new;
    m4.displayName = @"Light weight GenericTypes || __kindof";
    m4.targetName = @"LBGenericTypeViewController";

    LBModelHomeView *m5 = LBModelHomeView.new;
    m5.displayName = @"protocolAndSynthesize";
    m5.targetName = @"LBProtocolDemoVC";
    
    LBModelHomeView *m6 = LBModelHomeView.new;
    m6.displayName = @"LBBlock 引用计数加一，以及可能导致的崩溃";
    m6.targetName = @"LBBlock5ViewController";
    
    LBModelHomeView *m7 = LBModelHomeView.new;
    m7.displayName = @"iOS 各种锁";
    m7.targetName = @"LBLockViewController";
    
    LBModelHomeView *m8 = LBModelHomeView.new;
    m8.displayName = @"iOS frame 和 masonry 混用姿势";
    m8.targetName = @"LBNewItineraryViewController";
    
    LBModelHomeView *m9 = LBModelHomeView.new;
    m8.displayName = @"消息发送探究";
    m8.targetName = @"LBObjcMsgSendViewController";
    
    LBModelHomeView *m10 = LBModelHomeView.new;
    m10.displayName = @"RACSignal 冷热信号";
    m10.targetName = @"LBRACHotClodViewController";
    
    LBModelHomeView *m11 = LBModelHomeView.new;
    m11.displayName = @"MD5 HashString";
    m11.targetName = @"LBHashStudyViewController";
    
    

    [homeModels addObject:m];
    [homeModels addObject:m1];
    [homeModels addObject:m2];
    [homeModels addObject:m3];
    [homeModels addObject:m4];
    [homeModels addObject:m5];
    [homeModels addObject:m6];
    [homeModels addObject:m7];
    [homeModels addObject:m8];
    [homeModels addObject:m9];
    [homeModels addObject:m10];
    [homeModels addObject:m11];
    
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
                             @strongify(self);
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
