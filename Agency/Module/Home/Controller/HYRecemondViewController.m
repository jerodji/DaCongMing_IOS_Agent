//
//  HYRecemondViewController.m
//  Agency
//
//  Created by Jack on 2017/11/20.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYRecemondViewController.h"
#import "HYRecommendBottomView.h"
#import "HYRecommendLevelCell.h"
#import "HYTextFieldTableViewCell.h"
#import "HYRecommendTipsCell.h"
#import "HYRecommendViewModel.h"
#import "HYRecommendSuccessVC.h"

@interface HYRecemondViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) HYRecommendBottomView *bottomView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,copy) NSArray *titleArray;
@property (nonatomic,copy) NSArray *placeholderArray;
@property (nonatomic,strong) HYRecommendViewModel *viewModel;

@end

@implementation HYRecemondViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
    [self bindViewModel];
}

- (void)setupSubviews{
    
    self.title = @"推荐";
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.tableView];
}


- (void)bindViewModel{
    
    _viewModel = [HYRecommendViewModel new];
    
    [RACObserve(_viewModel, RecommendSelectLevel) subscribeNext:^(id x) {
       
        if (_viewModel.RecommendSelectLevel == RecommendLevelPracticeAgent || _viewModel.RecommendSelectLevel == RecommendLevelPractice) {
            
            _titleArray = @[@"被推荐人ID"];
            _placeholderArray = @[@"请输入被推荐人ID"];
        }
        else{
            
            _titleArray = @[@"被推荐人ID",@"付款人姓名",@"付款账户",@"手机号码"];
            _placeholderArray = @[@"请输入被推荐人ID",@"请输入付款人姓名",@"请输入付款账户",@"请输入手机号码"];
        }
        
        [_tableView reloadData];
    }];
    
    RAC(_bottomView.confirmBtn,enabled) = [_viewModel confirmButtonIsValid];
    
    RAC(_bottomView.confirmBtn, backgroundColor) = [[_viewModel confirmButtonIsValid] map:^id(id value) {
       
        return [value boolValue] ? KAPP_THEME_COLOR : KAPP_c2c2c2_COLOR;
    }];
    
    [[_bottomView.confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [_viewModel confirmAction];
    }];
    
    [self.viewModel.confirmSuccessSubject subscribeNext:^(id x) {
       
        HYRecommendSuccessVC *recommendSuccessVC = [HYRecommendSuccessVC new];
        [self.navigationController pushViewController:recommendSuccessVC animated:YES];
    }];
}

- (void)viewDidLayoutSubviews{
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(170 * WIDTH_MULTIPLE);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(_bottomView.mas_top).offset(-20 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - setupNav
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = KAPP_NAV_COLOR;
    self.navigationController.navigationBar.translucent = NO;
    [self setStatusBarBackgroundColor:KAPP_NAV_COLOR];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
    [self setStatusBarBackgroundColor:KAPP_WHITE_COLOR];
    //[self setNeedsNavigationBackground:0];
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        
        statusBar.backgroundColor = color;
    }
}

- (void)setNeedsNavigationBackground:(CGFloat)alpha {
    
    
    // 导航栏背景透明度设置
    UIView *barBackgroundView = [[self.navigationController.navigationBar subviews] objectAtIndex:0];// _UIBarBackground
    UIImageView *backgroundImageView = [[barBackgroundView subviews] objectAtIndex:0];// UIImageView
    if (self.navigationController.navigationBar.isTranslucent) {
        if (backgroundImageView != nil && backgroundImageView.image != nil) {
            barBackgroundView.alpha = alpha;
        }
        else {
            UIView *backgroundEffectView = [[barBackgroundView subviews] objectAtIndex:1];// UIVisualEffectView
            if (backgroundEffectView != nil) {
                backgroundEffectView.alpha = alpha;
            }
        }
    }
    else {
        barBackgroundView.alpha = alpha;
    }
    self.navigationController.navigationBar.clipsToBounds = YES;
    
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _titleArray.count + 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            static NSString *recommendLevelCellID = @"recommendLevelCellID";
            HYRecommendLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendLevelCellID];
            if (!cell) {
                cell = [[HYRecommendLevelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recommendLevelCellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            [cell setWithRecommendViewModel:self.viewModel];
            return cell;
            
        }
            break;
        case 1:
        {
            static NSString *recommendTipsCellID = @"recommendTipsCellID";
            HYRecommendTipsCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendTipsCellID];
            if (!cell) {
                cell = [[HYRecommendTipsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recommendTipsCellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            [cell setWithRecommendViewModel:self.viewModel];
            return cell;
            
        }
            break;

        default:
        {
            
            static NSString *textFieldCellID = @"textFieldCellID";
            HYTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:textFieldCellID];
            if (!cell) {
                cell = [[HYTextFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textFieldCellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            cell.title = _titleArray[indexPath.section - 2];
            cell.placeholder = _placeholderArray[indexPath.section - 2];
            cell.indexPath = indexPath;
            [cell setWithRecommendViewModel:self.viewModel];
            return cell;
        }
            break;
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 10 * WIDTH_MULTIPLE)];
    headerView.backgroundColor = KAPP_TableView_BgColor;
    
    if (section == 0 || section == 1) {
        
        headerView.hidden = YES;
    }
    else{
        
    }
    return headerView;

}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0 || section == 1) {
        
        return 0;

    }
    else{
        
        return 10 * WIDTH_MULTIPLE;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            
            return 120 * WIDTH_MULTIPLE;
            break;
        case 1:
            
            return 90 * WIDTH_MULTIPLE;
            break;
            
        default:
            return 45 * WIDTH_MULTIPLE;
            break;
    }
}


#pragma mark - lazyload
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = KAPP_TableView_BgColor;
    }
    return _tableView;
}

- (HYRecommendBottomView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [HYRecommendBottomView new];
    }
    return _bottomView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
