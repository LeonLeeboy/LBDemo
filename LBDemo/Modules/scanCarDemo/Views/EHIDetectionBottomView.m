//
//  EHIDetectionBottomView.m
//  LBDemo
//
//  Created by 李兵 on 2019/8/23.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "EHIDetectionBottomView.h"
#import "EHIDetecctionItemView.h"



@interface EHIDetectionBottomView ()

//@property (nonatomic, assign, readwrite) NSNumber *haveError;

@property (nonatomic, strong, readwrite) NSArray<EHIDetecctionItemView *> *itemViews;

@property (nonatomic, strong, readwrite) NSArray<EHIDetecctionItemModel *> *itemModels;

@end

@implementation EHIDetectionBottomView

#pragma mark life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self prearaData];
        
        [self setupSubViews];
        
        [self renderViewWithModels:self.itemModels];
    }
    
    return self;
}

- (void)prearaData {
    NSArray<NSString *> *strings = [self p_checkStrings];
    NSMutableArray *content = [NSMutableArray array];
    for (int i = 0; i < strings.count; i++) {
        EHIDetecctionItemModel *model = [[EHIDetecctionItemModel alloc] init];
        model.itemName = strings[i];
        model.itemID = i;
        model.success = YES;
        [content addObject:model];
    }
    
    self.itemModels = [NSArray arrayWithArray:content];
    
    
    NSMutableArray *contentArr = [NSMutableArray array];
    for (int i = 0; i < self.itemModels.count; i++) {
        EHIDetecctionItemView *itemView = [[EHIDetecctionItemView alloc] init];
        [contentArr addObject:itemView];
    }
    self.itemViews = [NSArray arrayWithArray:contentArr];
}

- (void)setupSubViews {
    [self.itemViews enumerateObjectsUsingBlock:^(EHIDetecctionItemView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addSubview:obj];
    }];
    
     [self laytoutViews];
}

- (void)laytoutViews {
    UIView *preObj;
    for (int i = 0; i < self.itemViews.count; i++) {
        UIView *obj = self.itemViews[i];
        if (i == 0) {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.top.mas_equalTo(0);
                make.width.mas_greaterThanOrEqualTo(autoWidthOf6(24));
                make.height.mas_greaterThanOrEqualTo(autoHeightOf6(49));
            }];
        } else {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                make.width.equalTo(preObj);
                make.height.equalTo(preObj);
                make.left.equalTo(preObj.mas_right).with.offset(autoWidthOf6(44));
            }];
        }
        
        if (i == self.itemViews.count - 1) {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(0);
            }];
        }
        preObj = obj;
    }
    
}

#pragma mark public
- (void)renderViewWithModels:(NSArray *)itemModels {
    
    self.itemModels = itemModels;

    [self.itemViews enumerateObjectsUsingBlock:^(EHIDetecctionItemView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < self.itemModels.count) {
            [obj renderViewWithModel:self.itemModels[idx]];
        }
    }];

}

- (void)startCheck {
    //从第一个开始检测
     [self p_begeinCheckWithIndex:0 initialStatus:NO];
}


#pragma mark private
- (NSArray<NSString *> *)p_checkStrings {
    return @[@"车灯",@"车窗",@"车门",@"后备箱",@"熄火"];
}


- (void)p_begeinCheckWithIndex:(NSInteger)idx initialStatus:(BOOL)status {
    
    __block BOOL statusTemp = status;
    __block NSInteger index = idx;
    if (idx == self.itemViews.count) {
        if (!statusTemp) {

            self.haveError = @(YES);
        }
        return;
    } else {
        if (idx >= self.itemViews.count) {
              return;
        }
        EHIDetecctionItemView *itemView = self.itemViews[idx];
        [itemView startAnimation];
        EHiWeakSelf(self)
        itemView.didFinishedAnimationBlcok = ^(BOOL success) {
            EHiStrongSelf(self)
            if (index == 0 && success) {
                statusTemp = YES;
            }
            
            if (success && statusTemp) {
                statusTemp = YES;
            } else {
                statusTemp = NO;
            }
            [self p_begeinCheckWithIndex:++index initialStatus:statusTemp];
        };
        
    }
}
@end
