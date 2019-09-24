//
//  EHINewItineraryListViewController.m
//  LBDemo
//
//  Created by 李兵 on 2019/9/19.
//  Copyright © 2019 ivan. All rights reserved.
//

#import "EHINewItineraryListViewController.h"

#import "EHINewItineraryViewModel.h"

#import "EHINewItinerarySectionHeaderView.h"
#import "EHINewItineraryCell.h"

@interface EHINewItineraryListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) EHINewItineraryViewModel *viewModel;

#pragma mark 暂存

@property (strong, nonatomic) EHINewItineraryCell *preCell;

@end

@implementation EHINewItineraryListViewController

#pragma mark - lifecyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
    EHiWeakSelf(self)
    [self.viewModel getMyNewItineraryDataWith:nil];
    
    self.viewModel.refreshUI = ^(NSArray<EHINewItinerayItemModel *> *dataSource) {
        EHiStrongSelf(self)
        [self.tableView reloadData];
    };
}

- (void)setupSubViews {
    [self.view addSubview:self.tableView];
    
    [self layoutViews];
}

- (void)layoutViews {
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

#pragma mark - delegate && dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    EHINewItinerarySectionHeaderView *sectionHeaderView = [[EHINewItinerarySectionHeaderView alloc] init];
    [sectionHeaderView renderViewWitTime:@"2019年10月3日"];
    return sectionHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EHINewItineraryCell *cell = [EHINewItineraryCell cellWithTableView:tableView indexPath:indexPath];
    self.preCell = cell;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
        return autoHeightOf6(34);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.preCell) {
        return  [self.preCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    } else {
        return autoHeightOf6(186);
    }
}


#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        view.backgroundColor = kEHIHexColor_F2F2F2;
        view.delegate = self;
        view.dataSource = self;
        view.separatorColor = kEHIHexColor_EEEEEE;
        view.allowsSelection = NO;
        view.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        view.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView = view;
    }
    return _tableView;
}

- (EHINewItineraryViewModel *)viewModel {
    if (!_viewModel) {
        EHINewItineraryViewModel *viewModel = [[EHINewItineraryViewModel alloc] init];
        _viewModel = viewModel;
    }
    return _viewModel;
}

@end
