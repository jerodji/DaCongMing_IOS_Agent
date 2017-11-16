
//
//  HYUploadIDCardViewController.m
//  Agency
//
//  Created by 胡勇 on 2017/11/8.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYUploadIDCardViewController.h"
#import "HYTextFieldTableViewCell.h"
#import "HYSendAuthView.h"
#import "HYUploadIDCardViewModel.h"

@interface HYUploadIDCardViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
/** titleArray */
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) NSArray *placeholderArray;
/** 提交 */
@property (nonatomic,strong) UIButton *confirmBtn;
@property (nonatomic,strong) HYSendAuthView *authView;
@property (nonatomic,strong) HYUploadIDCardViewModel *viewModel;

@end

@implementation HYUploadIDCardViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
    [self bindViewModel];
}

- (void)setupSubviews{
    
    self.title = @"完善信息";
    self.view.backgroundColor = KAPP_TableView_BgColor;
    _titleArray = @[@"姓名",@"身份证",@"卡号"];
    _placeholderArray = @[@"本人姓名",@"本人证件号码",@"本人银行卡号"];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.authView];
    [self.view addSubview:self.confirmBtn];
}

- (void)bindViewModel{
    
    self.viewModel = [HYUploadIDCardViewModel new];
    [_authView setWithViewModel:_viewModel];
    
    RAC(self.confirmBtn,enabled) = [_viewModel confirmButtonIsValid];
    RAC(self.confirmBtn,backgroundColor) = [[_viewModel confirmButtonIsValid] map:^id(id value) {
        
        return [value boolValue] ? KAPP_THEME_COLOR : KCOLOR(@"EDEDED");
    }];
    
    [[_confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        [_viewModel confirmAction];
    }];
    
    __weak typeof (self)weakSelf = self;
    [self.viewModel.uploadInfoSuccessSubject subscribeNext:^(id x) {
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)viewDidLayoutSubviews{
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(20 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(150 * WIDTH_MULTIPLE);
    }];
    
    [_authView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.top.equalTo(_tableView.mas_bottom);
        make.height.mas_equalTo(90 * WIDTH_MULTIPLE);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(20 * WIDTH_MULTIPLE);
        make.right.equalTo(self.view).offset(-20 * WIDTH_MULTIPLE);
        make.top.equalTo(_authView.mas_bottom).offset(40 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(50 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *textFieldCellID = @"textFieldCellID";
    HYTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:textFieldCellID];
    if (!cell) {
        cell = [[HYTextFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textFieldCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.title = _titleArray[indexPath.row];
    cell.placeholder = _placeholderArray[indexPath.row];
    cell.indexPath = indexPath;
    [cell setWithViewModel:self.viewModel];
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50 * WIDTH_MULTIPLE;
}



#pragma mark - lazyload
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = KAPP_TableView_BgColor;
        _tableView.bounces = NO;
    }
    return _tableView;
}

- (UIButton *)confirmBtn{
    
    if (!_confirmBtn) {
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = KFitFont(16);
        [_confirmBtn setTitleColor:KCOLOR(@"C6C6CC") forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = KCOLOR(@"EDEDED");
    }
    return _confirmBtn;
}

- (HYSendAuthView *)authView{
    
    if (!_authView) {
        
        _authView = [HYSendAuthView new];
    }
    return _authView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
