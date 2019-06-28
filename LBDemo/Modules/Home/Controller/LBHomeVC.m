//
//  LBHomeVC.m
//  LBDemo
//
//  Created by ivan on 2018/8/6.d//  Copyright © 2018年 ivan. All rights reserved.
//

#import "LBHomeVC.h"
#import "LBHomeViewControllerViewModel.h"
#import "LBHomeCell.h"
#import "LBLoginCenter.h"
#import "LBModelHomeView.h"

@interface LBHomeVC ()<UITableViewDelegate , UITableViewDataSource>

/** list */
@property (nonatomic, strong) UITableView *tbView;

@property (nonatomic , strong) LBHomeViewControllerViewModel *viewModel;

@property (nonatomic , strong) NSArray<LBModelHomeView *> *outputData;

@end

@implementation LBHomeVC

#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    [self configUI];
    [self fetchData];
}

-(void)viewDidAppear:(BOOL)animated{
    if ([LBLoginCenter instance].loginState == LBLoginCenterStateLogin || [LBLoginCenter instance].loginState == LBLoginCenterStateLogining) {
        return;
    }
//    [[LBLoginCenter instance] loginWithBlock:^(BOOL loginSuccess) {
//        if (loginSuccess) {
//            [self.tbView.mj_header beginRefreshing];
//        }
//    }];
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
        [self.viewModel.fetchCommand execute:@(YES)];
    }];
    
//    if (@available(iOS 11.0, *)) {
//        self.tbView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }
}

- (void)fetchData {
    self.viewModel = [[LBHomeViewControllerViewModel alloc] init];
    @weakify(self);
    [self.viewModel.signalDataList subscribeNext:^(LBModelCommon *  _Nullable x) {
        @strongify(self);
        if (x.hasMore) {
            if (!self.tbView.mj_footer) {
                self.tbView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
                    @strongify(self);
                    [self.viewModel.fetchCommand execute:@(NO)];
                }];
            }
            [self.tbView.mj_footer resetNoMoreData];
        }else {
             [self.tbView.mj_footer endRefreshingWithNoMoreData];
        }
        self.outputData = x.dataSource;
        [self.tbView reloadData];
        [self.tbView.mj_header endRefreshing];
    }];
    
     [self.tbView.mj_header beginRefreshing];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *targetName = [self.outputData objectAtIndex:indexPath.row].targetName;
    if ([targetName isEqualToString:@""] || !targetName) {
        return;
    }
    [self.navigationController pushViewController:[[NSClassFromString(targetName) alloc] init] animated:YES];
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

@end
