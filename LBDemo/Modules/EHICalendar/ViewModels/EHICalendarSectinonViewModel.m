//
//  EHICalendarSectinonViewModel.m
//  LBDemo
//
//  Created by 李兵 on 2020/3/10.
//  Copyright © 2020 ivan. All rights reserved.
//

#import "EHICalendarSectinonViewModel.h"
#import "EHICalendarDayModel.h"
#import "EHICalendarDayCellViewModel.h"
#import "NSDate+EHICalendar.h"

@interface EHICalendarSectinonViewModel ()

@property (nonatomic, strong) NSArray<EHICalendarDayModel *> *models;

@end

@implementation EHICalendarSectinonViewModel

- (void)updateWithModel:(NSArray<EHICalendarDayModel *> *)models {
    _models = models;
    
    // 处理title
    if (models.count > 0) {
        for (int i = 0 ; i < models.count ; i++) {
            EHICalendarDayModel *m = models[i];
            if (m.month != 0) {
                NSString *month= [NSString stringWithFormat:@"%ld 月",m.month];
                self.titleAttributed = [self p_getDayAttributedString:month];
                break;
            }
        }
    }
    
    NSMutableArray<EHICalendarDayCellViewModel *> *arrs = [NSMutableArray array];
    for (int i = 0; i < models.count; i++) {
        EHICalendarDayModel *dayModel = models[i];
        EHICalendarDayCellViewModel *cv = [[EHICalendarDayCellViewModel alloc] init];
        
        if (dayModel.month <= [NSDate date].month && dayModel.getDate.isItPassday) { // 过去的时间
            [cv generateViewModelWithModel:dayModel type:EHICalendarDayCellTypeDisabled];
        } else { // 正常显示
            [cv generateViewModelWithModel:dayModel type:EHICalendarDayCellTypeNormal];
        }
        [arrs addObject:cv];
    }
    
    
    self.cellItems = arrs;
    
    
}



#pragma mark - private
- (NSAttributedString *)p_getDayAttributedString:(NSString *)month {
    NSMutableAttributedString *rst = [[NSMutableAttributedString alloc] initWithString:month];
    return rst.copy;
}
@end
