//
//  EHINewItineraryCellContentView.m
//  LBDemo
//
//  Created by 李兵 on 2019/9/19.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "EHINewItineraryCellContentView.h"

#import "EHINewItineraryTopView.h"
#import "EHINewItineraryAddressListView.h"
#import "EHINewItineraryMessagesView.h"

#import "EHINewItineraryMessagesItemModel.h"
#import "EHINewItineraryCellContentModel.h"

#import "EHINewItineraryCellViewModel.h"


#pragma mark - UItableViewCell 内容View
#pragma mark -

@interface EHINewItineraryCellContentView ()

@property (nonatomic, strong) EHINewItineraryTopView *topView;

/** address list View */
@property (nonatomic, strong) EHINewItineraryAddressListView *addressListView;

@property (nonatomic, strong) EHINewItineraryMessagesView *bottomMessageView;

@property (nonatomic, strong) UIView *verticalLineView;

/** 所有的内容View */
@property (nonatomic, strong) UIView *contentView;

@end

@implementation EHINewItineraryCellContentView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self setupSubViews];
        
    }
    return self;
}

- (void)setupSubViews {
    
    [self addSubview:self.verticalLineView];
    
    [self addSubview:self.contentView];
    
    [self.contentView addSubview:self.topView];
    
    [self.contentView addSubview:self.addressListView];
    
    [self.contentView addSubview:self.bottomMessageView];
    
    [self layoutViews];
}

- (void)layoutViews {
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-autoHeightOf6(12));
        make.left.mas_equalTo(kInterItemSpace());
        make.right.mas_equalTo(0);
    }];
    
    [_verticalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.centerX.equalTo(self.contentView.mas_left).with.offset(-kInterItemSpaceBetweenDotAndLabel());
        make.width.mas_equalTo(2);
    }];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.left.mas_equalTo(0);
    }];
    
    [_addressListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).with.offset(autoHeightOf6(13));
        make.left.mas_equalTo(autoWidthOf6(16));
        make.right.mas_equalTo(0);
    }];
    [_bottomMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(autoWidthOf6(12));
        make.top.equalTo(self.addressListView.mas_bottom);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

#pragma - public

- (void)renderViewWithModel:(EHINewItineraryCellContentModel *)contentModel {
    
    EHINewItineraryType type = contentModel.type;
    
    [self.topView renderViewWithOrderTitle:contentModel.orderTitle
                                 getOnTime:contentModel.getOnTimeDate
                        getOnTimeLabHidden:(type == EHINewItineraryTypeSelfDriving)];
    
    NSArray *docks = [EHINewItineraryCellViewModel getDockSitesWithModel:contentModel];
    [self.addressListView renderViewWithBeginAddressModel:contentModel.beginAddresModel
                                          endAddressModel:contentModel.endAddresModel
                                                    stops:docks];
    
    NSArray *itineraryItemModels = [EHINewItineraryCellViewModel getMessagesWithModel:contentModel];
    [self.bottomMessageView renderViewWithModels:itineraryItemModels];
}


#pragma mark - Getter && Setter
/** 顶部 （专车-送机，租车 && 上车时间） view */
- (EHINewItineraryTopView *)topView {
    if (!_topView) {
        EHINewItineraryTopView *content = [[EHINewItineraryTopView alloc] init];
        _topView = content;
    }
    return _topView;
}

/** 地址列表 */
- (EHINewItineraryAddressListView *)addressListView {
    if (!_addressListView) {
        EHINewItineraryAddressListView *v = [[EHINewItineraryAddressListView alloc] init];
        
        _addressListView = v;
        
    }
    return _addressListView;
}

- (EHINewItineraryMessagesView *)bottomMessageView {
    if (!_bottomMessageView) {
        EHINewItineraryMessagesView *messageView = [[EHINewItineraryMessagesView alloc] init];
        
        _bottomMessageView = messageView;
    }
    return _bottomMessageView;
}

- (UIView *)verticalLineView {
    if (!_verticalLineView) {
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = kEHIHexColor_EEEEEE;
        
        _verticalLineView = line;
    }
    return _verticalLineView;
}

- (UIView *)contentView {
    if (!_contentView) {
        UIView *contentV = [[UIView alloc] init];
        
        contentV.layer.cornerRadius = 8;
        
        contentV.layer.masksToBounds = YES;
        
        contentV.backgroundColor = kEHIHexColor_FFFFFF;
        
        _contentView = contentV;
    }
    return _contentView;
}


@end
