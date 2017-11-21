//
//  HYTeamDetailViewController.m
//  Agency
//
//  Created by Jack on 2017/11/20.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYTeamDetailViewController.h"
#import "HYMyTeamHeaderView.h"

@interface HYTeamDetailViewController ()

@property (nonatomic,strong) HYMyTeamHeaderView *headerView;
@property (nonatomic,strong) UILabel *teamDetailLabel;
@property (nonatomic,strong) UIView *bottomLine;
@property (nonatomic,strong) UITextView *introTextView;

@end

@implementation HYTeamDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupNav];
    [self setupSubviews];
}

- (void)setupSubviews{
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.teamDetailLabel];
    [self.view addSubview:self.bottomLine];
    [self.view addSubview:self.introTextView];
}

- (void)viewDidLayoutSubviews{
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(200 * WIDTH_MULTIPLE);
    }];
    
    [_teamDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(20 * WIDTH_MULTIPLE);
        make.right.equalTo(self.view);
        make.top.equalTo(_headerView.mas_bottom);
        make.height.mas_equalTo(45 * WIDTH_MULTIPLE);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(1);
        make.top.equalTo(_teamDetailLabel.mas_bottom);
    }];
    
    [_introTextView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(20 * WIDTH_MULTIPLE);
        make.right.equalTo(self.view).offset(-20 * WIDTH_MULTIPLE);
        make.top.equalTo(_bottomLine.mas_bottom).offset(10 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark - setter
- (void)setInfo:(NSDictionary *)info{
    
    _info = info;
    self.headerView.number = info[@"num"];
    self.headerView.titleLabel.text = info[@"teamName"];
    [self.headerView.headerImageView sd_setImageWithURL:[NSURL URLWithString:info[@"headImgUrl"]] placeholderImage:[UIImage imageNamed:@"user_placeholder"]];
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
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - lazyload
- (HYMyTeamHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[HYMyTeamHeaderView alloc] init];
        _headerView.backgroundColor = KAPP_TableView_BgColor;
        _headerView.isShowBtn = NO;
    }
    return _headerView;
}

- (UILabel *)teamDetailLabel{
    
    if (!_teamDetailLabel) {
        
        _teamDetailLabel = [[UILabel alloc] init];
        _teamDetailLabel.font = KFitFont(16);
        _teamDetailLabel.textColor = KAPP_272727_COLOR;
        _teamDetailLabel.text = @"团队详情";
        _teamDetailLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _teamDetailLabel;
}

- (UIView *)bottomLine{
    
    if (!_bottomLine) {
        
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _bottomLine;
}

- (UITextView *)introTextView{
    
    if (!_introTextView) {
        
        _introTextView = [UITextView new];
        _introTextView.text = @"消息的远程推送您在开发者后台配置好远程推送的证书，且在代码中申请好权限，并将 deviceToken 传给融云服务器，当接收者不在线的时候，融云服务器会自动通过远程推送将消息发过去。注： 推送的内容由发送消息接口的 pushContent 字段决定，内置消息发送的时候如果该字段没有值，将使用默认内容推送；自定义消息必须设置该字段，否则将不会推送。";
        _introTextView.editable = NO;
        _introTextView.textColor = KAPP_272727_COLOR;
        _introTextView.font = KFitFont(15);
        _introTextView.backgroundColor = [UIColor clearColor];
    }
    return _introTextView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
