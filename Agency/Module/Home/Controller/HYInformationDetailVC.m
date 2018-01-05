//
//  HYInformationDetailVC.m
//  Agency
//
//  Created by Jack on 2017/11/21.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYInformationDetailVC.h"
#import <WebKit/WebKit.h>
#import "HYShareView.h"
#import "HYShareModel.h"

@interface HYInformationDetailVC ()<WKUIDelegate,WKNavigationDelegate>

//   WKUIDelegate                   JS代码里有弹框等事件的时候相关的
//   WKScriptMessageHandler         JS代码需要调用原生的方法的时候相关

/**WKWebView*/
@property (nonatomic,strong) WKWebView *webView;
/**progress*/
@property (nonatomic,strong) UIProgressView *progressView;
/** backItem */
@property (nonatomic,strong) UIBarButtonItem *backItem;
/** 关闭 */
@property (nonatomic,strong) UIBarButtonItem *closeItem;

@end

@implementation HYInformationDetailVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews{
    
    self.navigationItem.leftBarButtonItem = self.backItem;
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [MBProgressHUD showPregressHUDWithLoadingText:@"正在加载中！"];
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    self.navigationItem.rightBarButtonItem = shareItem;
}

- (void)backBtnAction{
    
    if ([self.webView canGoBack]) {
        
        [self.webView goBack];
    }
    else{
        
        [self closeAction];
    }
}

- (void)shareAction{
    
    HYShareView *shareView = [[HYShareView alloc] initWithFrame:KEYWINDOW.frame];
    [KEYWINDOW addSubview:shareView];
    
    HYShareModel *shareModel = [[HYShareModel alloc] init];
    shareModel.shareType = HYShareTypeWebUrl;
    shareModel.shareTitle = self.model.title;
    shareModel.shareDescription = self.model.descriptions;
    shareModel.shareWebUrl = self.model.shareUrl;
    shareModel.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.img]]];
    [shareView showShareView];
    shareView.shareModel = shareModel;
}

- (void)closeAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc{
    
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark ********监听加载进度********
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if (object == self.webView &&  [keyPath isEqualToString:@"estimatedProgress"]) {
        
        CGFloat newProgress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newProgress == 1) {
            self.progressView.hidden = YES;
        }
        else{
            self.progressView.hidden = NO;
            self.progressView.progress = newProgress;
            
            [MBProgressHUD hidePregressHUD:KEYWINDOW];
        }
    }
}

#pragma mark ********webView代理********
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    [self.webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
        self.title = result;
    }];
    
    
    if ([self.webView canGoBack]) {

       
        self.navigationItem.leftBarButtonItems = @[self.backItem,self.closeItem];
    }
    else{
        
        self.navigationItem.leftBarButtonItem = self.backItem;
    }
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
    NSLog(@"%@",error);
}


#pragma mark - lazyload
- (WKWebView *)webView{
    if (!_webView) {
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - 64)];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
        
        //        //创建WKWebView的配置对象
        //        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        //        //设置configuration对象的preferences属性的信息
        //        WKPreferences *preference = [[WKPreferences alloc] init];
        //        configuration.preferences = preference;
        //        //是否允许与JS交互，默认YES
        //        preference.javaScriptEnabled = YES;
        //        //通过JS与WebView内容交互
        //        configuration.userContentController = [[WKUserContentController alloc] init];
        //        [configuration.userContentController addScriptMessageHandler:self name:@"callback"];
        
    }
    return _webView;
}



- (UIProgressView *)progressView{
    
    if (!_progressView) {
        
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 20 * WIDTH_MULTIPLE)];
        _progressView.backgroundColor = KAPP_b7b7b7_COLOR;
        _progressView.progress = 0;
        _progressView.progressTintColor = KAPP_THEME_COLOR;
    }
    return _progressView;
}

- (UIBarButtonItem *)backItem{
    
    if (!_backItem) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"back"];
        [btn setImage:image forState:UIControlStateNormal];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [btn setTitleColor:KAPP_WHITE_COLOR forState:UIControlStateNormal];
        //字体的多少为btn的大小
        [btn sizeToFit];
        //左对齐
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //让返回按钮内容继续向左边偏移15，如果不设置的话，就会发现返回按钮离屏幕的左边的距离有点儿大，不美观
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -4, 0, 0);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -4, 0, 4);
        btn.frame = CGRectMake(0, 0, 50, 50);
        _backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    return _backItem;
}

- (UIBarButtonItem *)closeItem{
    
    if (!_closeItem) {
        
         _closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeAction)];
    }
    return _closeItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
