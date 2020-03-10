//
//  EHICalendarDayCellViewModel.m
//  LBDemo
//
//  Created by 李兵 on 2020/3/6.
//  Copyright © 2020 ivan. All rights reserved.
//

#import "EHICalendarDayCellViewModel.h"
#import "EHICalendarDayModel.h"

static CGFloat disPlayTextHeight() {
    return autoHeightOf6(32);
}

static CGFloat desTextHeight() {
    return autoHeightOf6(14);
}

static CGFloat itemHeight() {
    return disPlayTextHeight() + desTextHeight() + 4;
}

@interface EHICalendarDayCellViewModel ()

@property (nonatomic, assign, readwrite) EHICalendarDayCellType identityType;

@property (nonatomic, strong, readwrite) EHICalendarDayModel *model;

/** 文字颜色 */
@property (nonatomic, strong, readwrite) UIColor *textColor;

/** 背景颜色 */
@property (nonatomic, strong, readwrite) UIColor *bgColor;

/** 圆的颜色 */
@property (nonatomic, strong, readwrite) UIColor *cycleColor;

/** 左边切圆背景色 */
@property (nonatomic, strong, readwrite) UIColor *layerColor;

/** item 大小 */
@property (nonatomic, assign, readwrite) CGSize itemSize;

@end



@implementation EHICalendarDayCellViewModel

- (void)generateViewModelWithModel:(EHICalendarDayModel *)model type:(EHICalendarDayCellType)type {
    self.identityType = type;
    self.model = model;
    
    [self p_dealData:model];
    
    [self p_dealUI:model];
    
    [self p_calculate];
}

- (void)p_dealData:(EHICalendarDayModel *)model {
    if (model.day == 0) {
        self.display = @"";
    } else {
        self.display = [NSString stringWithFormat:@"%lu",(unsigned long)self.model.day];
    }
}

- (void)p_dealUI:(EHICalendarDayModel *)model {

    switch (self.identityType) {
        case EHICalendarDayCellTypeNormal: { // 正常显示
            self.bgColor = kEHIHexColor_FFFFFF;
            self.textColor = kEHIHexColor_333333;
            self.cycleColor = UIColor.clearColor;
            self.layerColor = UIColor.clearColor;
        }
            break;
        case EHICalendarDayCellTypeDisabled: { // 显示不可用
            self.bgColor = kEHIHexColor_FFFFFF;
            self.textColor = kEHIHexColor_7B7B7B;
            self.cycleColor = UIColor.clearColor;
            self.layerColor = UIColor.clearColor;
        }
            break;
        case EHICalendarDayCellTypeLeftCorner: { // 左半边被切圆角
            self.bgColor = kEHIHexColor_FFFFFF;
            self.textColor = kEHIHexColor_FFFFFF;
            self.cycleColor = kEHIHexColor_29B7B7;
            self.layerColor = kEHIHexColor(0xCCEEEE);
            
        }
            break;
        case EHICalendarDayCellTypeRightCoorner: {//右半边被切圆角
            self.bgColor = kEHIHexColor_FFFFFF;
            self.textColor = kEHIHexColor_FFFFFF;
            self.cycleColor = kEHIHexColor_29B7B7;
            self.layerColor = kEHIHexColor(0xCCEEEE);
        }
            break;
        case EHICalendarDayCellTypeIntecell: { // 右半边 和 左半边被切圆角的cell 的中间的 cell
            self.bgColor = kEHIHexColor_FFFFFF;
            self.textColor = kEHIHexColor_333333;
            self.cycleColor = UIColor.clearColor;
            self.layerColor = kEHIHexColor(0xCCEEEE);
        }
            break;
            
        default:
            break;
    }
}

- (void)p_calculate {
    static const NSInteger daysPerWeek = 7;
    self.seed_cellSize = CGSizeMake(DeviceSize.width / daysPerWeek, itemHeight());
}


#pragma mark -
- (nonnull Class)seed_CellClass {
    return NSClassFromString(@"EHICalendarCollecitionCell");
}

@synthesize seed_cellSize;
@synthesize seed_indexPath;
@synthesize seed_refreshBlock;
@synthesize seed_didSelectActionBlock;


@end
