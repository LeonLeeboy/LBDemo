//
//  LBHomeCell.m
//  LBDemo
//
//  Created by 李兵 on 2019/6/24.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBHomeCell.h"
#import "LBModelHomeView.h"



@interface LBHomeCell ()

/** the label of content */
@property (nonatomic, strong) UILabel *contentLab;

@end


@implementation LBHomeCell

#pragma mark life cycle

+ (LBHomeCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    return  [[self alloc] initWithTableView:tableView indexPath:indexPath];
}

- (LBHomeCell *)initWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    NSString *resue = NSStringFromClass([self class]);
    LBHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:resue];
    if (!cell) {
        cell = [[LBHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resue];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    [self.contentView addSubview:self.contentLab];
    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
    }];
}

#pragma mark public
- (void)renderViewWithModel:(LBModelHomeView *)model {
    if (![model isKindOfClass:[LBModelHomeView class]]) {
        return;
    }
    self.contentLab.text = model.displayName;
}

#pragma mark getter
- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab  = [[UILabel alloc] init];
        _contentLab.numberOfLines = 0;
        _contentLab.backgroundColor = [UIColor clearColor];
        _contentLab.textColor = [UIColor lightGrayColor];
        _contentLab.font = [UIFont systemFontOfSize:14];
        _contentLab.textAlignment = NSTextAlignmentCenter;
        
    }
    return _contentLab;
}

@end
