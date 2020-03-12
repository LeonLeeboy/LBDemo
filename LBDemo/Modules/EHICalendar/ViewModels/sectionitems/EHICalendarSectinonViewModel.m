//
//  EHICalendarSectinonViewModel.m
//  LBDemo
//
//  Created by 李兵 on 2020/3/10.
//  Copyright © 2020 ivan. All rights reserved.
//

#import "EHICalendarSectinonViewModel.h"
#import "EHICalendarDayModel.h"

#import "EHICalendarHeaderCellViewModel.h"
#import "NSDate+EHICalendar.h"

@interface EHICalendarSectinonViewModel ()

@property (nonatomic, strong) NSArray<EHICalendarDayModel *> *models;

@end

@implementation EHICalendarSectinonViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headerHeight = autoHeightOf6(28);
        self.columnCount = 1;
        self.sectionInset  =  UIEdgeInsetsMake(0, 20, 0, 20);
    }
    return self;
}

- (void)updateWithModel:(NSArray<EHICalendarDayModel *> *)models {
    _models = models;
    // 处理title
    if (models.count > 0) {
        for (int i = 0 ; i < models.count ; i++) {
            EHICalendarDayModel *m = models[i];
            if (m.month != 0) {
                EHICalendarHeaderCellViewModel *cellVm = [[EHICalendarHeaderCellViewModel alloc] init];
                [cellVm updateWith:m edgeInset:self.sectionInset];
                [self.cellItems addObject:cellVm];
                break;
            }
        }
    }
  
}

@end
