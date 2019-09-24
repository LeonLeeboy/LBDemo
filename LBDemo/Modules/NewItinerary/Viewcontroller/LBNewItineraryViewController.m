//
//  LBNewItineraryViewController.m
//  LBDemo
//
//  Created by 李兵 on 2019/9/18.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "LBNewItineraryViewController.h"
#import "EHIHomeItineraryView.h"
#import "LBItineraryModel.h"
#import "EHINewItineraryCellContentView.h"

#import "EHINewItineraryListViewController.h"

@interface LBNewItineraryViewController ()

@property (nonatomic, strong) EHIHomeItineraryView *newItinerary;

@end

@implementation LBNewItineraryViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kEHIHexColor_CCCCCC;
    
    [self setupSubviews];
}

- (void)setupSubviews {
    
    EHINewItineraryCellContentView *v = [[EHINewItineraryCellContentView alloc] init];
    CGFloat height = [v systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    [self.view addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(150);
        make.height.mas_equalTo(height);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(v.mas_bottom).with.offset(30);
        make.centerX.equalTo(v);
    }];
    EHiWeakSelf(self)
    [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        EHiStrongSelf(self)
        [self.navigationController pushViewController:EHINewItineraryListViewController.new animated:YES];
    }];
}

#pragma mark - Action
- (void)doMoreItineraryAction {
    NSLog(@"点击更多行程");
}

- (void)doCurrentItineraryAction {
    NSLog(@"点击当前行程");
}


#pragma mark - getter
- (EHIHomeItineraryView *)newItinerary {
    if (!_newItinerary) {
       EHIHomeItineraryView *newItinerary = [[EHIHomeItineraryView alloc] init];
        // 更多行程
        EHiWeakSelf(self)
        newItinerary.moreItineraryClickAction = ^{
           EHiStrongSelf(self)
            [self doMoreItineraryAction];
        };
        // 点击当前行程
        newItinerary.clickCurrentItineraryAction = ^{
            EHiStrongSelf(self)
            [self doCurrentItineraryAction];
        };
        [newItinerary renderViewWithContent:nil];
        CGFloat height = [newItinerary systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        
         newItinerary.frame = CGRectMake(20, 150, DeviceSize.width - 2 * 20, height);
        _newItinerary = newItinerary;
    }
    
    return _newItinerary;
}


@end
