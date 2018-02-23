//
//  BusinessCardVC.m
//  Agency
//
//  Created by hailin on 2018/1/29.
//  Copyright © 2018年 胡勇. All rights reserved.
//

#import "BusinessCardVC.h"
#import "CreateCardVC.h"

@interface BusinessCardVC ()
// 展示名片
@property (nonatomic,strong) UITableView * tableView;
// 没有名片
@property (nonatomic,strong) UIImageView * noCardImageView;
@property (nonatomic,strong) UILabel * describeLabel;
@property (nonatomic,strong) UIButton * addCardBtn;
@end

@implementation BusinessCardVC

- (instancetype)init {
    self = [super init];
    if (self) {
        _cardModels = [[NSArray alloc] init];
    }
    return self;
}

- (void)loadView {
    [super loadView];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"名片";
    
    if (_cardModels.count==0) {
        [self configNoCardImage];
    } else {
        [self configTableView];
    }
}

#pragma mark- -------------- table view ---------------

- (void)configTableView {
    
}


#pragma mark- -------------- no card image --------------

- (void)configNoCardImage {
    CGFloat cW = 225.f/2.f * WidthScale;
    CGFloat cH = 165.f/2.f * WidthScale;
    _noCardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-cW/2, 100, cW,cH)];
    _noCardImageView.image = [UIImage imageNamed:@"mingpiantu"];
    [self.view addSubview:_noCardImageView];
    
    _describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _noCardImageView.bottom+20, ScreenWidth, 40)];
    _describeLabel.text = @"您还未有个人专属名片\n赶快添加吧！";
    _describeLabel.numberOfLines = 0;
    _describeLabel.textColor = UIColorRGB(56, 57, 56);
    _describeLabel.textAlignment = NSTextAlignmentCenter;
    _describeLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_describeLabel];
    
    _addCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addCardBtn.frame = CGRectMake((ScreenWidth-100)/2, _describeLabel.bottom+20, 100, 30);
    _addCardBtn.backgroundColor = UIColorRGB(56, 57, 56);
    [_addCardBtn setTitle:@"添加名片" forState:UIControlStateNormal];
    _addCardBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _addCardBtn.layer.cornerRadius = 5;
    [_addCardBtn addTarget:self action:@selector(addNoCardImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addCardBtn];
}
- (void)addNoCardImage {
    [self.navigationController pushViewController:[CreateCardVC new] animated:YES];
}

- (void)removeNoCardImage {
    if (_noCardImageView) {
        [_noCardImageView removeFromSuperview];
        _noCardImageView = nil;
    }
    if (_describeLabel) {
        [_describeLabel removeFromSuperview];
        _describeLabel = nil;
    }
    if (_addCardBtn) {
        [_addCardBtn removeFromSuperview];
        _addCardBtn = nil;
    }
}

#pragma mark- -----------------------

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
