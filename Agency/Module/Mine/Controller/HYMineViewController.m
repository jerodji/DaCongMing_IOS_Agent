//
//  HYMineViewController.m
//  Agency
//
//  Created by 胡勇 on 2017/11/3.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYMineViewController.h"
#import "HYMyAccountTableViewCell.h"
#import "HYSetUserNameVC.h"
#import "HYBandPhoneVC.h"
#import "HYUploadIDCardViewController.h"
#import "UILabel+HYCopy.h"

@interface HYMineViewController () <UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** datalist */
@property (nonatomic,strong) NSMutableArray *datalist;
/** dataSourceArray */
@property (nonatomic,strong) NSMutableArray *dataSourceArray;

@end

@implementation HYMineViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews{
    
    self.title = @"我的账户";
    [self setupData];
    [self.view addSubview:self.tableView];

}

- (void)setupData{
    
    self.datalist = [NSMutableArray arrayWithObjects:@"头像",@"用户名",@"我的ID",@"实名认证",@"绑定手机",@"退出登录", nil];
    NSString *phone = [HYUserModel sharedInstance].userInfo.phone;
    
    if ([phone isNotBlank]) {
        
        phone = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        phone = [phone isNotBlank] ? phone : @"";
        self.dataSourceArray = [NSMutableArray arrayWithObjects:[HYUserModel sharedInstance].userInfo.head_image_url,[HYUserModel sharedInstance].userInfo.name,[HYUserModel sharedInstance].userInfo.id,@"",phone,@"",nil];
    }
    else{
        self.dataSourceArray = [NSMutableArray arrayWithObjects:[HYUserModel sharedInstance].userInfo.head_image_url,[HYUserModel sharedInstance].userInfo.name,[HYUserModel sharedInstance].userInfo.id,@"",@"",@"",nil];
    }
    
    
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.datalist.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"myAccountCell";
    HYMyAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[HYMyAccountTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.titleLabel.text = _datalist[indexPath.section];
    cell.nickNameLabel.text = _dataSourceArray[indexPath.section];
    [cell.headerImgView sd_setImageWithURL:[NSURL URLWithString:_dataSourceArray[indexPath.section]] placeholderImage:[UIImage imageNamed:@"user_placeholder"]];
    
    if (indexPath.section != 0) {
        
        cell.headerImgView.hidden = YES;
    }
    cell.nickNameLabel.hidden = YES;
    
    if (indexPath.section == 1 || indexPath.section == 4 || indexPath.section == 2) {
        
        cell.nickNameLabel.hidden = NO;
    }
    cell.nickNameLabel.isCopyable = YES;
    
    
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 1:
        {
            HYSetUserNameVC *setNameVC = [HYSetUserNameVC new];
            [self.navigationController pushViewController:setNameVC animated:YES];
        }
            break;
        case 3:
        {
            if (![[HYUserModel sharedInstance].userInfo.phone isNotBlank]) {
                
                HYBandPhoneVC *bindVC = [HYBandPhoneVC new];
                [self.navigationController pushViewController:bindVC animated:YES];
                [JRToast showWithText:@"请先绑定手机"];
                return;
            }
            if ([[HYUserModel sharedInstance].userInfo.isauth boolValue]) {
                
                [JRToast showWithText:@"你已经实名认证过了"];
                return;
            }
            HYUploadIDCardViewController *uploadIDCardVC = [HYUploadIDCardViewController new];
            uploadIDCardVC.title = @"实名认证";
            uploadIDCardVC.isBindBankCard = NO;
            [self.navigationController pushViewController:uploadIDCardVC animated:YES];
        }
            break;
        case 4:
        {
            if ([[HYUserModel sharedInstance].userInfo.phone isNotBlank]) {
                
                [JRToast showWithText:@"你已经绑定过手机了" duration:2];
                return;
            }
            HYBandPhoneVC *bindVC = [HYBandPhoneVC new];
            [self.navigationController pushViewController:bindVC animated:YES];
        }
            break;
        case 5:
        {
            HYCustomAlert *alert = [[HYCustomAlert alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT) WithTitle:@"温馨提示" content:@"是否确认退出登录?" confirmBlock:^{
                
                [[HYUserModel sharedInstance] clearData];
                KRootViewController = [HYLoginViewController new];
            }];
            [KEYWINDOW addSubview:alert];
        }
            break;
        default:
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 10 * WIDTH_MULTIPLE)];
    view.backgroundColor = KCOLOR(@"f4f4f4");
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10 * WIDTH_MULTIPLE;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return 60 * WIDTH_MULTIPLE;
    }
    return 45 * WIDTH_MULTIPLE;
}


#pragma mark - lazyload
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = KCOLOR(@"f4f4f4");
    }
    return _tableView;
}

- (NSMutableArray *)datalist{
    
    if (!_datalist) {
        _datalist = [NSMutableArray array];
    }
    return _datalist;
}

- (NSMutableArray *)dataSourceArray{
    
    if (!_dataSourceArray) {
        
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
