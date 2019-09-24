//
//  EHINewItineraryCell.h
//  LBDemo
//
//  Created by 李兵 on 2019/9/19.
//  Copyright © 2019 ivan. All rights reserved.
//
// 我的行程列表cell
//

#import <UIKit/UIKit.h>
@class EHINewItineraryCellContentModel;

NS_ASSUME_NONNULL_BEGIN

@interface EHINewItineraryCell : UITableViewCell

- (void)renderViewWithModel:(EHINewItineraryCellContentModel *)model;

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;


+ (NSString *)cellCalss;

@end

NS_ASSUME_NONNULL_END
