//
//  LBHomeVC.m
//  LBDemo
//
//  Created by ivan on 2018/8/6.d//  Copyright © 2018年 ivan. All rights reserved.
//

#import "LBHomeVC.h"
#import "LBHomeViewControllerViewModel.h"

@interface LBHomeVC ()

/** list */
@property (nonatomic, strong) UITableView *tbView;

@property (nonatomic , strong) LBHomeViewControllerViewModel *viewModel;

@end

@implementation LBHomeVC

#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    [self configUI];
    
    [self fetchData];
}

#pragma mark public
/** init UI */
- (void)configUI {
    [self.view addSubview:self.tbView];
    [_tbView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    _tbView.backgroundColor = [UIColor redColor];
}

- (void)fetchData {
    self.viewModel = [[LBHomeViewControllerViewModel alloc] init];
    [self.viewModel.signalDataList subscribeNext:^(id  _Nullable x) {
        NSLog(@"dfa");
    }];
    [self.viewModel.fetchCommand execute:nil];
}

#pragma mark private

#pragma mark delegate

#pragma mark getter

- (UITableView *)tbView {
    if (!_tbView) {
        _tbView = [[UITableView alloc] init];
    }
    return _tbView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
