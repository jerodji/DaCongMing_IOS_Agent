//
//  HYMyTeamViewController.m
//  Agency
//
//  Created by Jack on 2017/11/16.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYMyTeamViewController.h"
#import "HYChatViewController.h"
#import "HYMyTeamHeaderView.h"
#import "HYTeamMemberModel.h"
#import "HYTeamMemberCell.h"
#import "HYTeamDetailViewController.h"
#import "HYRecemondViewController.h"

@interface HYMyTeamViewController () <UITableViewDelegate,UITableViewDataSource,HYTeamHeaderViewBtnClickDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *datalist;
@property (nonatomic,strong) HYMyTeamHeaderView *headerView;
@property (nonatomic,strong) NSDictionary *requestData;

@end

@implementation HYMyTeamViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubViews];
    [self requestNetwork];
}

- (void)setupSubViews{
    
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self setupNav];
    [self setStatusBarBackgroundColor:[UIColor clearColor]];
}

#pragma mark - networkRequest
- (void)requestNetwork{
    
    [self.datalist removeAllObjects];
    [HYUserRequestHandle getTeamMemberWithGroupID:[HYUserModel sharedInstance].userInfo.group_id ComplectionBlock:^(NSDictionary *dict) {
       
        if (dict) {
            
            self.requestData = dict;
            NSArray *datalist = dict[@"memberList"];
            for (NSDictionary *dict in datalist) {
                
                HYTeamMemberModel *model = [HYTeamMemberModel modelWithDictionary:dict];
                [self.datalist addObject:model];
            }
            [self.tableView reloadData];
            _headerView.number = [NSString stringWithFormat:@"%lu",(unsigned long)self.datalist.count];
            _headerView.titleLabel.text = dict[@"groupInfo"][@"group_name"];
            [_headerView.headerImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"groupInfo"][@"group_portraitUri"]] placeholderImage:[UIImage imageNamed:@"user_placeholder"]];
        }
    }];
}


#pragma mark - nav
- (void)setupNav{
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    //设置返回按钮的颜色为白色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnAction)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    //[self setNeedsNavigationBackground:0];
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



- (void)backBtnAction{
    
    if (self.navigationController.viewControllers.count > 1) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}




#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *teamMemberCellID = @"teamMemberCellID";
    HYTeamMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:teamMemberCellID];
    if (!cell) {
        cell = [[HYTeamMemberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:teamMemberCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.model = self.datalist[indexPath.row];
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < -64) {
        
        scrollView.scrollEnabled = NO;
    }
    else{
        
        scrollView.scrollEnabled = YES;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60 * WIDTH_MULTIPLE;
}

#pragma mark - buttonClickDelegate
- (void)headerViewBtnClickIndex:(NSInteger)index{
    
    switch (index) {
        case 0:
        {
            NSDictionary *dict = @{@"teamName" : self.requestData[@"groupInfo"][@"group_name"],@"num" : [NSString stringWithFormat:@"%lu",(unsigned long)self.datalist.count],@"headImgUrl" : self.requestData[@"groupInfo"][@"group_portraitUri"]};
            HYTeamDetailViewController *teamDetailVC = [HYTeamDetailViewController new];
            [self.navigationController pushViewController:teamDetailVC animated:YES];
            teamDetailVC.info = dict;
        }
            break;
        case 1:
        {
            HYChatViewController *chatVC = [[HYChatViewController alloc] initWithConversationType:ConversationType_GROUP targetId:[HYUserModel sharedInstance].userInfo.group_id];
            [self.navigationController pushViewController:chatVC animated:YES];
        }
            break;
        case 2:
        {
            HYRecemondViewController *recommendVC = [HYRecemondViewController new];
            [self.navigationController pushViewController:recommendVC animated:YES];
        }
            break;
        default:
            break;
    }
}


#pragma mark - lazyload
- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -64, KSCREEN_WIDTH, KSCREEN_HEIGHT + 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = KAPP_TableView_BgColor;
        _tableView.tableHeaderView = self.headerView;

    }
    return _tableView;
}

- (HYMyTeamHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[HYMyTeamHeaderView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 330 * WIDTH_MULTIPLE)];
        _headerView.backgroundColor = KAPP_TableView_BgColor;
        _headerView.delegate = self;
        _headerView.isShowBtn = YES;
    }
    return _headerView;
}

- (NSMutableArray *)datalist{
    
    if (!_datalist) {
        _datalist = [NSMutableArray array];
    }
    return _datalist;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
