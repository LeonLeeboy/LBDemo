//
//  EHINewItineraryCell.m
//  LBDemo
//
//  Created by 李兵 on 2019/9/19.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "EHINewItineraryCell.h"
#import "EHINewItineraryCellContentView.h"

#pragma mark -

@interface EHINewItineraryCell ()

@property (nonatomic, strong) EHINewItineraryCellContentView *cellContentView;



@end

@implementation EHINewItineraryCell

#pragma mark - lifecyle

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    EHINewItineraryCell *cell = [tableView dequeueReusableCellWithIdentifier:[EHINewItineraryCell cellCalss]];
    if (!cell) {
        cell = [[EHINewItineraryCell alloc] cellWithTableView:tableView indexPath:indexPath];
        
    }
    return cell;
}

- (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    
     EHINewItineraryCell *cell = [tableView dequeueReusableCellWithIdentifier:[EHINewItineraryCell cellCalss]];
    if (!cell) {
        cell = [[EHINewItineraryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[EHINewItineraryCell cellCalss]];
        
        [cell setupViews];
        
    }
    return cell;
}

- (void)setupViews {
    [self.contentView addSubview:self.cellContentView];
    
    self.contentView.backgroundColor = kEHIHexColor_F2F2F2;
    
    [self layoutViews];
}

- (void)layoutViews {
    [_cellContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(21);
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-autoWidthOf6(20));
    }];
}

#pragma mark - public
- (void)renderViewWithModel:(EHINewItineraryCellContentModel *)model {
    [self.cellContentView renderViewWithModel:model];
}

#pragma mark - Getter
/** cell reuse */
+ (NSString *)cellCalss {
    return NSStringFromClass([EHINewItineraryCell class]);
}

- (EHINewItineraryCellContentView *)cellContentView {
    if (!_cellContentView) {
        EHINewItineraryCellContentView *cellContentView = [[EHINewItineraryCellContentView alloc] init];
        _cellContentView = cellContentView;
    }
    return _cellContentView;
}

@end
