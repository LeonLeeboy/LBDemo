//
//  LBHomeCell.h
//  LBDemo
//
//  Created by 李兵 on 2019/6/24.
//  Copyright © 2019 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LBHomeCell : UITableViewCell

+ (LBHomeCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

- (LBHomeCell *)initWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

- (void)renderViewWithModel:(id)model;

@end

NS_ASSUME_NONNULL_END
