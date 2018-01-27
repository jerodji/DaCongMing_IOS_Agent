//
//  HYBaseViewController.m
//  Agency
//
//  Created by 胡勇 on 2017/11/1.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseViewController.h"
#import "HYBaseNavController.h"
#import "HYNoAccessView.h"
#import "HYJoinProtocolVC.h"

@interface HYBaseViewController ()
/** 无权限 */
@property (nonatomic,strong) HYNoAccessView *noAccessView;
@end

@implementation HYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    self.view.backgroundColor = KAPP_TableView_BgColor;
    [self setStatusBarBackgroundColor:[UIColor clearColor]];
    //[self showNoAccessView];

}

- (void)viewWillDisappear:(BOOL)animated{
    
    [self.view endEditing:YES];
}

- (void)setupNav{
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //设置导航栏的颜色
    self.navigationController.navigationBar.barTintColor = KAPP_NAV_COLOR;
    //设置导航栏的字体颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:KAPP_WHITE_COLOR}];
    self.navigationController.navigationBar.translucent = NO;
    
    //设置返回按钮的颜色为白色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnAction)];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)backBtnAction{
    
    if (self.navigationController.viewControllers.count > 1) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

//展示无权限View
- (void)showNoAccessView{
    
    [self.view addSubview:self.noAccessView];
    [_noAccessView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [_noAccessView showNoAccessView];
    });
    
    [[_noAccessView.joinBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        HYJoinProtocolVC *joinProtocolVC = [HYJoinProtocolVC new];
        HYBaseNavController *nav = [[HYBaseNavController alloc] initWithRootViewController:joinProtocolVC];
        [self presentViewController:nav animated:YES completion:nil];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

#pragma mark - setStatusBar
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        
        statusBar.backgroundColor = color;
    }
}

#pragma mark - lazyload
- (HYNoAccessView *)noAccessView{
    
    if (!_noAccessView) {
        
        _noAccessView = [HYNoAccessView new];
    }
    return _noAccessView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
