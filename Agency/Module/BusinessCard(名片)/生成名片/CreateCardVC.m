//
//  CreateCardVC.m
//  Agency
//
//  Created by hailin on 2018/1/30.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import "CreateCardVC.h"
#import "UploadQrcodeVC.h"

@interface CreateCardVC ()

@property (nonatomic,strong) UILabel * labA;
@property (nonatomic,strong) UITextField * fieldAA;

@property (nonatomic,strong) UIView * viewB;
@property (nonatomic,strong) UILabel * labB;
@property (nonatomic,strong) UIImageView * imgview;
@property (nonatomic,strong) UIImageView * rigview;

@property (nonatomic,strong) UIButton * nextStepBtn;

@end

@implementation CreateCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"生成名片";
    [self configTextFieldA];
    [self configTextfieldB];
    [self configNextstepButton];
}

- (void)configTextFieldA {
    _labA = [[UILabel alloc] init];
    _labA.backgroundColor = [UIColor whiteColor];
    _labA.text = @"  微信号:";
    _labA.font = [UIFont systemFontOfSize:13];
    _labA.textColor = UIColorRGB(56,56,56);
    _labA.textAlignment = NSTextAlignmentLeft;
    _labA.layer.cornerRadius = 10;
    _labA.layer.masksToBounds = YES;
    [self.view addSubview:_labA];
    
    _fieldAA = [[UITextField alloc] init];
    _fieldAA.borderStyle = UITextBorderStyleNone;
    _fieldAA.textAlignment = NSTextAlignmentRight;
    _fieldAA.placeholder = @"请输入您的微信号";
    [_fieldAA setValue:UIColorRGB(204,203,203) forKeyPath:@"_placeholderLabel.textColor"];
    [_fieldAA setValue:[UIFont boldSystemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:_fieldAA];
}

- (void)configTextfieldB {
    _viewB = [[UIView alloc] init];
    _viewB.backgroundColor = [UIColor whiteColor];
    _viewB.layer.cornerRadius = 10;
    _viewB.layer.masksToBounds = YES;
    [self.view addSubview:_viewB];
    
    UITapGestureRecognizer* tapgesture = [[UITapGestureRecognizer alloc] init];
    [tapgesture addTarget:self action:@selector(clickViewBAction)];
    [_viewB addGestureRecognizer:tapgesture];
    
    _labB = [[UILabel alloc] init];
    _labB.backgroundColor = [UIColor whiteColor];
    _labB.text = @"  上传二维码:";
    _labB.font = [UIFont systemFontOfSize:13];
    _labB.textColor = UIColorRGB(56,56,56);
    _labB.textAlignment = NSTextAlignmentLeft;
    _labB.layer.cornerRadius = 10;
    [_viewB addSubview:_labB];
    
    _imgview = [[UIImageView alloc] init];
    _imgview.image = [UIImage imageNamed:@"xiaoerweima"];
    [_viewB addSubview:_imgview];
    
    _rigview = [[UIImageView alloc] init];
    _rigview.image = [UIImage imageNamed:@"jinru"];
    [_viewB addSubview:_rigview];
}

- (void)configNextstepButton {
    _nextStepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextStepBtn.backgroundColor = UIColorRGB(56,56,56);
    _nextStepBtn.layer.cornerRadius = 10;
    [_nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextStepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_nextStepBtn addTarget:self action:@selector(nextSetpAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextStepBtn];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _labA.frame = CGRectMake(20, 20, ScreenWidth-40, 40);
    
    [_fieldAA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_labA).offset(80);
        make.top.equalTo(_labA);
        make.right.equalTo(_labA).offset(-10);
        make.height.equalTo(_labA);
    }];
    
    [_viewB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_labA);
        make.top.equalTo(_labA.mas_bottom).offset(10);
        make.right.equalTo(_labA);
        make.height.equalTo(_labA);
    }];
    
    [_labB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_viewB).offset(0);
        make.top.bottom.equalTo(_viewB);
        make.width.equalTo(_labA);
    }];
    
    [_rigview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(13);
        make.centerY.equalTo(_viewB);
        make.right.equalTo(_viewB).offset(-10);
    }];
    
    [_imgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(19);
        make.centerY.equalTo(_viewB);
        make.right.equalTo(_rigview.mas_left).offset(-10);
    }];
    
    [_nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_viewB);
        make.top.equalTo(_viewB.mas_bottom).offset(24);
        make.width.equalTo(_viewB);
        make.height.mas_equalTo(46);
    }];
}

- (void)clickViewBAction {
    UploadQrcodeVC * qrvc = [UploadQrcodeVC new];
    [self.navigationController pushViewController:qrvc animated:YES];
//    [self presentViewController:qrvc animated:YES completion:nil];
}

- (void)nextSetpAction {
    NSLog(@"34");
}

@end
