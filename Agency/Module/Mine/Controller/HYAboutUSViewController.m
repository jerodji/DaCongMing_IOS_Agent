//
//  HYAboutUSViewController.m
//  Agency
//
//  Created by Jack on 2017/11/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYAboutUSViewController.h"
#import "HYPhoneInfo.h"

@interface HYAboutUSViewController ()

@property (nonatomic,strong) UIImageView *iconImgView;
@property (nonatomic,strong) UITextView *introLabel;
@property (nonatomic,strong) UILabel *versionLabel;


@end

@implementation HYAboutUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"关于我们";
    [self setupSubviews];
}

- (void)setupSubviews{
    
    [self.view addSubview:self.iconImgView];
    [self.view addSubview:self.introLabel];
    [self.view addSubview:self.versionLabel];
}

- (void)viewDidLayoutSubviews{
    
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.view).offset(36 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(180 * WIDTH_MULTIPLE, 180 * WIDTH_MULTIPLE));
        make.centerX.equalTo(self.view);
    }];
    
    [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_iconImgView.mas_bottom).offset(40 * WIDTH_MULTIPLE);
        make.left.equalTo(self.view).offset(35 * WIDTH_MULTIPLE);
        make.right.equalTo(self.view).offset(-35 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(250 * WIDTH_MULTIPLE);
    }];
    
    [_versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view).offset(-36 * WIDTH_MULTIPLE);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - lazyload
- (UIImageView *)iconImgView{
    
    if (!_iconImgView) {
        
        _iconImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo1"]];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconImgView;
}

- (UITextView *)introLabel{
    
    if (!_introLabel) {
        
        _introLabel = [[UITextView alloc] init];
        _introLabel.font = KFitFont(16);
        _introLabel.textColor = KAPP_272727_COLOR;
        _introLabel.backgroundColor = [UIColor clearColor];
        _introLabel.text = @"    聪明管理APP 隶属于上海萨拜电子商务有限公司。上海萨拜电子商务有限公司成立于2017年3月，是一家从事互联网平台开发的公司。公司主要致力于大健康产业的平台、员工管理软件、经销商管理软件的开发与运营。致力于将各种健康品牌以更多样化的形式进行推广，将产品以更方便快捷的渠道送达到消费者手中。";
        _introLabel.textAlignment = NSTextAlignmentLeft;
        _introLabel.editable = NO;
    }
    return _introLabel;
}

- (UILabel *)versionLabel{
    
    if (!_versionLabel) {
        
        _versionLabel = [[UILabel alloc] init];
        _versionLabel.font = KFitFont(14);
        _versionLabel.textColor = KAPP_272727_COLOR;
        _versionLabel.text = [NSString stringWithFormat:@"版本号:V%@",[HYPhoneInfo appVersion]];
        _versionLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _versionLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
