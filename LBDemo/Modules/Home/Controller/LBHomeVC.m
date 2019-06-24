//
//  LBHomeVC.m
//  LBDemo
//
//  Created by ivan on 2018/8/6.d//  Copyright © 2018年 ivan. All rights reserved.
//

#import "LBHomeVC.h"
#import "LBHomeViewControllerViewModel.h"
#import "LBHomeCell.h"
#import "CBLoginCenter.h"

@interface LBHomeVC ()<UITableViewDelegate , UITableViewDataSource>

/** list */
@property (nonatomic, strong) UITableView *tbView;

@property (nonatomic , strong) LBHomeViewControllerViewModel *viewModel;

@property (nonatomic , strong) NSArray *outputData;

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
    CGFloat top = [UIApplication sharedApplication].statusBarFrame.size.height;
    [_tbView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(top, 0, 0, 0));
    }];
    @weakify(self);
    self.tbView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel.fetchCommand execute:nil];
    }];
    
    if (@available(iOS 11.0, *)) {
        self.tbView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (void)fetchData {
    self.viewModel = [[LBHomeViewControllerViewModel alloc] init];
    @weakify(self);
    [self.viewModel.signalDataList subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.outputData = x;
        [self.tbView reloadData];
        [self.tbView.mj_header endRefreshing];
    }];
}

-(void)viewDidAppear:(BOOL)animated{
    if ([CBLoginCenter instance].loginState == CBLoginCenterStateLogin || [CBLoginCenter instance].loginState == CBLoginCenterStateLogining) {
        return;
    }
    [[CBLoginCenter instance] loginWithBlock:^(BOOL loginSuccess) {
        if (loginSuccess) {
            [self.tbView.mj_header beginRefreshing];
        }
    }];
}


#pragma mark private

#pragma mark delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.outputData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LBHomeCell *cell = [LBHomeCell cellWithTableView:tableView indexPath:indexPath];
    if (self.outputData.count > indexPath.row) {
        [cell renderViewWithModel:self.outputData[indexPath.row]];
    }
    return cell;
}


#pragma mark getter

- (UITableView *)tbView {
    if (!_tbView) {
        _tbView = [[UITableView alloc] init];
        _tbView.dataSource = self;
        _tbView.delegate = self;
    }
    return _tbView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
