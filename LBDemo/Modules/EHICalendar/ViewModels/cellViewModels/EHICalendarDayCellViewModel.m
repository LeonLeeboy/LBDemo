//
//  EHICalendarDayCellViewModel.m
//  LBDemo
//
//  Created by 李兵 on 2020/3/6.
//  Copyright © 2020 ivan. All rights reserved.
//

#import "EHICalendarDayCellViewModel.h"
#import "EHICalendarDayModel.h"

static CGFloat itemHeight() {
    return disPlayTextHeight() + desTextHeight() + disPlayTextTop() * 2;
}

@interface EHICalendarDayCellViewModel ()

@property (nonatomic, assign, readwrite) EHICalendarDayCellType identityType;

@property (nonatomic, strong, readwrite) EHICalendarDayModel *model;

/** 背景颜色 */
@property (nonatomic, strong, readwrite) UIColor *bgColor;

/** 圆的颜色 */
@property (nonatomic, strong, readwrite) UIColor *cycleColor;

/** 左边切圆背景色 */
@property (nonatomic, strong, readwrite) UIColor *layerColor;

@property (nonatomic, assign, readwrite) UIEdgeInsets sectionInset;

@property (nonatomic, copy, readwrite) NSString *desText;

@end

@implementation EHICalendarDayCellViewModel

- (void)generateViewModelWithModel:(EHICalendarDayModel *)model type:(EHICalendarDayCellType)type contentInset:(UIEdgeInsets)contentInset desText:(NSString *)desText {
    self.sectionInset = contentInset;
    self.identityType = type;
    self.model = model;
    self.desText = desText;
    
    [self p_dealUI:model];
    
    [self p_calculateWithcontentInset:contentInset];
}

/** 获得日历文字 */
- (NSAttributedString *)p_getDayAttributed:(EHICalendarDayModel *)day color:(UIColor *)textColor {
    
    NSString *dayStr = (day.day == 0) ? @"" : [NSString stringWithFormat:@"%lu",(unsigned long)self.model.day];
  
    
    if (day.getDate.isToday) {
        dayStr = @"今";
    }
    
    NSAttributedString *attri = [EHICalendarDayCellViewModel p_getAttributedStr:dayStr color:textColor font:autoFONT(16)];
    
    return attri;
}


/** 获得描述文字 */
- (NSAttributedString *)p_getDesAttributed:(UIColor *)color {
    NSString *rst = @"";
    if (self.desText && ![self.desText isEqualToString:@""]) {
        rst = self.desText;
    }
    NSAttributedString *attri = [EHICalendarDayCellViewModel p_getAttributedStr:rst color:color font:autoFONT(10)];
    return attri;
}




- (void)p_dealUI:(EHICalendarDayModel *)model {

    switch (self.identityType) {
        case EHICalendarDayCellTypeEmpty: {//空
            self.bgColor = kEHIHexColor_FFFFFF;
            self.cycleColor = UIColor.clearColor;
            self.layerColor = UIColor.clearColor;
        }
        case EHICalendarDayCellTypeNormal: { // 正常显示
            self.bgColor = kEHIHexColor_FFFFFF;
            if (model.getDate.isToday) {
                
                self.displayAttributed = [self p_getDayAttributed:model color:kEHIHexColor_29B7B7];
            } else {
                self.displayAttributed = [self p_getDayAttributed:model color:kEHIHexColor_333333];
            }
           
            self.desDisplayAttributed = [self p_getDesAttributed:kEHIHexColor_7B7B7B];
            self.cycleColor = UIColor.clearColor;
            self.layerColor = UIColor.clearColor;
        }
            break;
            
        case EHICalendarDayCellTypeLeftRightConcidence: { // 左右重叠
            self.bgColor = kEHIHexColor_FFFFFF;
            self.displayAttributed = [self p_getDayAttributed:model color:kEHIHexColor_FFFFFF];
            self.desDisplayAttributed = [self p_getDesAttributed:kEHIHexColor_7B7B7B];
            self.cycleColor = kEHIHexColor_29B7B7;
            self.layerColor = kEHIHexColor(0xCCEEEE);
        }
            break;
            
        case EHICalendarDayCellTypeDisabled: { // 显示不可用
            self.bgColor = kEHIHexColor_FFFFFF;
            self.displayAttributed = [self p_getDayAttributed:model color:kEHIHexColor_7B7B7B];
             self.desDisplayAttributed = [self p_getDesAttributed:kEHIHexColor_7B7B7B];
            self.cycleColor = UIColor.clearColor;
            self.layerColor = UIColor.clearColor;
        }
            break;
        case EHICalendarDayCellTypeLeftCorner: { // 左半边被切圆角
            self.bgColor = kEHIHexColor_FFFFFF;
            self.displayAttributed = [self p_getDayAttributed:model color:kEHIHexColor_FFFFFF];
             self.desDisplayAttributed = [self p_getDesAttributed:kEHIHexColor_7B7B7B];
            self.cycleColor = kEHIHexColor_29B7B7;
            self.layerColor = kEHIHexColor(0xCCEEEE);
        }
            break;
        case EHICalendarDayCellTypeRightCoorner: {//右半边被切圆角
            self.bgColor = kEHIHexColor_FFFFFF;
            self.displayAttributed = [self p_getDayAttributed:model color:kEHIHexColor_FFFFFF];
             self.desDisplayAttributed = [self p_getDesAttributed:kEHIHexColor_7B7B7B];
            self.cycleColor = kEHIHexColor_29B7B7;
            self.layerColor = kEHIHexColor(0xCCEEEE);
        }
            break;
        case EHICalendarDayCellTypeIntecellNomal: { // 右半边 和 左半边被切圆角cell 中间的 正常cell
            self.bgColor = kEHIHexColor_FFFFFF;
            self.displayAttributed = [self p_getDayAttributed:model color:kEHIHexColor_333333];
            self.desDisplayAttributed = [self p_getDesAttributed:kEHIHexColor_7B7B7B];
            self.cycleColor = UIColor.clearColor;
            self.layerColor = kEHIHexColor(0xCCEEEE);
        }
            break;
            
        case EHICalendarDayCellTypeIntecellLeft: { // 右半边 和 左半边被切圆角cell 中间的 右边切圆cell
            self.bgColor = kEHIHexColor_FFFFFF;
            self.displayAttributed = [self p_getDayAttributed:model color:kEHIHexColor_333333];
            self.desDisplayAttributed = [self p_getDesAttributed:kEHIHexColor_7B7B7B];
            self.cycleColor = UIColor.clearColor;
            self.layerColor = kEHIHexColor(0xCCEEEE);
        }
            break;
            
        case EHICalendarDayCellTypeIntecellRight: { // 右半边 和 左半边被切圆角cell 中间的 左边切圆cell
            self.bgColor = kEHIHexColor_FFFFFF;
            self.displayAttributed = [self p_getDayAttributed:model color:kEHIHexColor_333333];
            self.desDisplayAttributed = [self p_getDesAttributed:kEHIHexColor_7B7B7B];
            self.cycleColor = UIColor.clearColor;
            self.layerColor = kEHIHexColor(0xCCEEEE);
        }
            break;
            
        default:
            break;
    }
}

- (void)p_calculateWithcontentInset:(UIEdgeInsets)contentInset {
    static const NSInteger daysPerWeek = 7;
    self.seed_cellSize = CGSizeMake((DeviceSize.width - contentInset.left - contentInset.right) / daysPerWeek, itemHeight());
}


#pragma mark -
- (nonnull Class)seed_CellClass {
    return NSClassFromString(@"EHICalendarCollecitionCell");
}

#pragma mark - static class
+ (NSAttributedString *)p_getAttributedStr:(NSString *)str color:(UIColor *)textColor font:(UIFont *)font {
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
    attri.font = font;
    attri.color = textColor;
    
    return attri;
}

@synthesize seed_cellSize;
@synthesize seed_indexPath;
@synthesize seed_refreshBlock;
@synthesize seed_didSelectActionBlock;


@end
