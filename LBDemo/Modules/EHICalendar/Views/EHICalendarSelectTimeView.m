//
//  EHICalendarSelectTimeView.m
//  LBDemo
//
//  Created by 李兵 on 2020/3/13.
//  Copyright © 2020 ivan. All rights reserved.
//

#import "EHICalendarSelectTimeView.h"
#import "EHIStoreOpenCloseModel.h"

typedef NS_ENUM(NSInteger,EHIPickTimeComponentType) {
    EHIPickTimeComponentTypePickCar,    //!> 取车
    EHIPickTimeComponentTypeReturnCar   //!> 还车
};

@interface EHICalendarSelectTimeView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (weak, nonatomic) IBOutlet UIButton *comfirmBth;

/** 09:00 格式 */
@property (nonatomic, strong) NSMutableArray<NSString *> *pickDatesDataSource;

@property (nonatomic, strong) NSMutableArray<NSString *> *returnDataSource;

@end

@implementation EHICalendarSelectTimeView

#pragma mark - life cycle

#pragma mark - public

#pragma - Action
/** 确定 */
- (IBAction)doConfirmAction:(id)sender {
    
}

#pragma mark - delegate
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == EHIPickTimeComponentTypeReturnCar) {
        return self.returnDataSource.count;
    } else if (component == EHIPickTimeComponentTypePickCar) {
        return self.pickDatesDataSource.count;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    switch (component) {
        case EHIPickTimeComponentTypePickCar: {
            return self.pickDatesDataSource[row];
        }
            break;
        case EHIPickTimeComponentTypeReturnCar: {
            return self.returnDataSource[row];
        }
        default:{
            return @"";
        }
            break;
    }
}


/** pickerView 显示宽度 */
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat addValue = (Main_Screen_Width < 375) ? 10 : 0;
      switch (component) {
         case EHIPickTimeComponentTypePickCar: {
             return self.width / 2.0;
         }
             break;
         case EHIPickTimeComponentTypeReturnCar: {
             return self.width / 2.0;
         }
         default:{
             return 0;
         }
             break;
     }
}
#pragma mark - private
- (NSArray<NSString *> *)p_getDataSource:(EHIStoreOpenCloseModel *)model {
    
    
    NSMutableArray *allTimeArray = [self p_getAllHours];
    
    NSString *defaultOpenTime = @"10:00";
    NSString *defaultClosingTime = @"21:00";
    //取车门店可选时间
    NSInteger getTimeOpeningIndex = [allTimeArray indexOfObject:defaultOpenTime];
    NSInteger getTimeClosingIndex = [allTimeArray indexOfObject:defaultClosingTime];
    
    if (getTimeOpeningIndex == NSNotFound) {
        getTimeOpeningIndex = 0;
    }
    if (getTimeClosingIndex == NSNotFound) {
        getTimeClosingIndex = allTimeArray.count - 1;
    }
    
    NSArray* getTimeArray = [allTimeArray subarrayWithRange:NSMakeRange(getTimeOpeningIndex, getTimeClosingIndex - getTimeOpeningIndex + 1)];

    return getTimeArray;
}

- (void)setOpenModel:(EHIStoreOpenCloseModel *)openModel {
     _openModel = openModel;
     self.pickDatesDataSource = [self p_getDataSource:self.openModel].copy;
    [self.pickerView reloadComponent:0];
}

- (void)setCloseModel:(EHIStoreOpenCloseModel *)closeModel {
    _closeModel = closeModel;
    self.returnDataSource = [self p_getDataSource:self.closeModel].copy;
    [self.pickerView reloadComponent:1];
}


- (NSMutableArray<NSString *> *)p_getAllHours {
    NSMutableArray *allTimeArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 24; i++) {
        NSString* timeString = [NSString stringWithFormat:@"%ld:00", (long)i];
        //增加半个小时
        NSString* halfHourString = [NSString stringWithFormat:@"%ld:30", (long)i];
        if (timeString.length < 5) {
            timeString = [NSString stringWithFormat:@"0%@", timeString];
            halfHourString = [NSString stringWithFormat:@"0%@", halfHourString];
        }
        [allTimeArray addObject:timeString];
        [allTimeArray addObject:halfHourString];
    }
    return allTimeArray;
}

- (NSMutableArray<NSString *> *)pickDatesDataSource {
    if (!_pickDatesDataSource) {
        _pickDatesDataSource = [self p_getDataSource:self.openModel].copy;
    }
    return _pickDatesDataSource;
}

- (NSMutableArray<NSString *> *)returnDataSource {
    if (!_returnDataSource) {
        _returnDataSource = [self p_getDataSource:self.closeModel].copy;
    }
    return _returnDataSource;
}



@end
