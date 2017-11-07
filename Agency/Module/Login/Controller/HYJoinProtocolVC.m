//
//  HYJoinProtocolVC.m
//  Agency
//
//  Created by 胡勇 on 2017/11/3.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYJoinProtocolVC.h"
#import <WebKit/WebKit.h>
#import "HYSelectIDInfoVC.h"

@interface HYJoinProtocolVC () <WKUIDelegate,WKNavigationDelegate>

@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,strong) UIButton *readProtocolBtn;
@property (nonatomic,strong) UIButton *agreeBtn;

@end

@implementation HYJoinProtocolVC

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setupSubviews];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
}

- (void)setupSubviews{
    
    self.title = @"用户协议";
    [self.view addSubview:self.webView];
    [self.view addSubview:self.readProtocolBtn];
    [self.view addSubview:self.agreeBtn];
    
    __weak typeof (self)weakSelf = self;
    [[self.agreeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        if (!weakSelf.readProtocolBtn.selected) {
            
            [JRToast showWithText:@"请阅读并同意用户协议"];
            return ;
        }
        
        HYSelectIDInfoVC *selectInfoVC = [HYSelectIDInfoVC new];
        [weakSelf presentViewController:selectInfoVC animated:YES completion:nil];
        
    }];
}

- (void)viewDidLayoutSubviews{
    
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(15 * WIDTH_MULTIPLE);
        make.right.equalTo(self.view).offset(-15 * WIDTH_MULTIPLE);
        make.top.equalTo(self.view).offset(20 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self.view).offset(-110 * WIDTH_MULTIPLE);
    }];
    
    [_readProtocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(15 * WIDTH_MULTIPLE);
        make.right.equalTo(self.view).offset(-15 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self.view).offset(-70 * WIDTH_MULTIPLE);
    }];
    
    [_agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(45 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - override
- (void)showNoAccessView{
    
    
}

#pragma mark - action
- (void)readProtocolAction:(UIButton *)button{
    
    button.selected = !button.selected;
    
}

#pragma mark - lazyload
- (WKWebView *)webView{
    
    if (!_webView) {
        
        _webView = [[WKWebView alloc] init];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        //[_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    }
    return _webView;
}

- (UIButton *)agreeBtn{
    
    if (!_agreeBtn) {
        
        _agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _agreeBtn.backgroundColor = KAPP_THEME_COLOR;
        [_agreeBtn setTitle:@"同意" forState:UIControlStateNormal];
        [_agreeBtn setTitleColor:KAPP_WHITE_COLOR forState:UIControlStateNormal];
        _agreeBtn.titleLabel.font = KFitFont(18);
    }
    return _agreeBtn;
}

- (UIButton *)readProtocolBtn{
    
    if (!_readProtocolBtn) {
        
        _readProtocolBtn = [[UIButton alloc] init];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"我已阅读【用户协议】"];
        NSRange strRange = {0,[str length]};
        [str addAttribute:NSForegroundColorAttributeName value:KAPP_272727_COLOR range:strRange];
        [str addAttribute:NSForegroundColorAttributeName value:KAPP_THEME_COLOR range:NSMakeRange(str.length - 6, 6)];
        [_readProtocolBtn setAttributedTitle:str forState:UIControlStateNormal];
        _readProtocolBtn.titleLabel.font = KFitFont(13);
        _readProtocolBtn.backgroundColor = [UIColor clearColor];
        _readProtocolBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_readProtocolBtn setImage:[UIImage imageNamed:@"checkIcon"] forState:UIControlStateNormal];
        [_readProtocolBtn setImage:[UIImage imageNamed:@"checkIcon_select"] forState:UIControlStateSelected];
        _readProtocolBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5 * WIDTH_MULTIPLE , 0, -5 * WIDTH_MULTIPLE);
        [_readProtocolBtn addTarget:self action:@selector(readProtocolAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _readProtocolBtn;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



@end
