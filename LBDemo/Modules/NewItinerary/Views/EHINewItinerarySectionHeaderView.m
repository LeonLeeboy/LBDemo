//
//  EHINewItinerarySectionHeaderView.m
//  LBDemo
//
//  Created by 李兵 on 2019/9/20.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "EHINewItinerarySectionHeaderView.h"
#import "EHINewItineraryAddressListView.h"
#import "EHINewItineraryRender.h"


@interface EHINewItinerarySectionHeaderView ()

@property (nonatomic, strong) EHINewItineraryAddressListItemView *itemView;

@end

@implementation EHINewItinerarySectionHeaderView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
    [self addSubview:self.itemView];
    
    [self layoutViews];
}

- (void)layoutViews {
    [_itemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 21, 0, 0));
    }];
}

#pragma mark - public
- (void)renderViewWitTime:(NSString *)timeStr {
    [self.itemView renderViewWithIconImage:[self p_createLightGrayCycleImage]
                            attributedText:[self p_getTimeAttributedWithString:timeStr]
                                 lineStyle:EHIAddressListVerticalLineStyleFull
                         verticalLineWidth:2];
}

#pragma mark - private
- (UIImage *)p_createLightGrayCycleImage {
    UIImage *img = [EHINewItineraryRender getImageWithColor:kEHIHexColor_CCCCCC
                                               contentColor:nil imageSize:CGSizeMake(8, 8)
                                                contentSize:CGSizeZero];
    return img;
}

- (NSAttributedString *)p_getTimeAttributedWithString:(NSString *)text {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    attributedString.font = autoFONT(14);
    attributedString.color = kEHIHexColor_333333;
    return attributedString;
}

#pragma mark - Getter && Setter

- (EHINewItineraryAddressListItemView *)itemView {
    if (!_itemView) {
        EHINewItineraryAddressListItemView *itemView = [[EHINewItineraryAddressListItemView alloc] init];
        _itemView = itemView;
    }
    
    return _itemView;
}

@end
