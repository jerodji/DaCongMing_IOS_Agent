//
//  HYGuideViewController.m
//  Agency
//
//  Created by Jack on 2017/11/22.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYGuideViewController.h"

@interface HYGuideViewController ()

/** 轮播图 */
@property (nonatomic,strong) UIScrollView  *scrollView;
/** 启动页 */
@property (nonatomic,strong) NSArray *guideArray;

@end

@implementation HYGuideViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews{
    
    self.guideArray = @[@"guide1",@"guide2",@"guide3"];
    [self.view addSubview:self.scrollView];

    for (NSInteger i = 0; i < self.guideArray.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed: self.guideArray[i]];
        imageView.frame = CGRectMake(i * KSCREEN_WIDTH, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT);
        [self.scrollView addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        if (i == 2) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor clearColor];
            [imageView addSubview:btn];
            [btn addTarget:self action:@selector(jumpToLoginVC) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view layoutIfNeeded];
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.bottom.equalTo(self.view).offset(-22 * WIDTH_MULTIPLE);
                make.centerX.equalTo(imageView);
                make.size.mas_equalTo(CGSizeMake(180 * WIDTH_MULTIPLE, 60 * WIDTH_MULTIPLE));
            }];
            
            UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
            leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
            [imageView addGestureRecognizer:leftSwipe];
            
        }
    }
}

- (void)jumpToLoginVC{
    
    KEYWINDOW.rootViewController = [HYLoginViewController new];
}

- (void)swipeAction:(UISwipeGestureRecognizer *)sender{
    
    [self jumpToLoginVC];
}

- (void)viewWillLayoutSubviews{
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.bottom.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazyload
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(KSCREEN_WIDTH * 3, KSCREEN_HEIGHT);
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

@end
