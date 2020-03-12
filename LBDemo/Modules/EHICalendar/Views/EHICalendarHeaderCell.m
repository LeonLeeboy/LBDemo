//
//  EHICalendarHeaderCell.m
//  LBDemo
//
//  Created by 李兵 on 2020/3/10.
//  Copyright © 2020 ivan. All rights reserved.
//

#import "EHICalendarHeaderCell.h"
#import "EHICalendarHeaderCellViewModel.h"

@interface EHICalendarHeaderCell ()
@property (weak, nonatomic) IBOutlet UILabel *month;

@end

@implementation EHICalendarHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)seed_cellWithData:(EHICalendarHeaderCellViewModel *)itemModel {
    self.month.attributedText = itemModel.titleAttributed;
}

@end
