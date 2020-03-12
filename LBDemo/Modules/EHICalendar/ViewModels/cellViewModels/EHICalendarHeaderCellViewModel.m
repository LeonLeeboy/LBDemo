//
//  EHICalendarHeaderCellViewModel.m
//  LBDemo
//
//  Created by 李兵 on 2020/3/10.
//  Copyright © 2020 ivan. All rights reserved.
//

#import "EHICalendarHeaderCellViewModel.h"
#import "EHICalendarDayModel.h"

@implementation EHICalendarHeaderCellViewModel

- (void)updateWith:(EHICalendarDayModel *)model edgeInset:(UIEdgeInsets)edges {
     NSString *month= [self p_getMonth:model.month];
    self.titleAttributed = [self p_getDayAttributedString:month];
    
    self.seed_cellSize = CGSizeMake(Main_Screen_Width-edges.left-edges.right, 40);
}


#pragma mark - private
- (NSAttributedString *)p_getDayAttributedString:(NSString *)month {
    NSMutableAttributedString *rst = [[NSMutableAttributedString alloc] initWithString:month];
    rst.font = autoFONT(20);
    rst.color = kEHIHexColor_333333;
    return rst.copy;
}

/// 对应cell的类
- (Class )seed_CellClass {
    return NSClassFromString(@"EHICalendarHeaderCell");
}

- (NSString *)p_getMonth:(NSInteger)month {
    
    NSArray *months = @[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"];
   
    if (months.count >= month) {
        return months[month-1];
    }
    return @"未知月份";
}


@synthesize seed_cellSize;

@synthesize seed_didSelectActionBlock;

@synthesize seed_indexPath;

@synthesize seed_refreshBlock;

@end
