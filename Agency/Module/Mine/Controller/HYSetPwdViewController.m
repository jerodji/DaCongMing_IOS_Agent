//
//  HYSetPwdViewController.m
//  Agency
//
//  Created by Jack on 2017/12/29.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYSetPwdViewController.h"

@interface HYSetPwdViewController ()

/** 设置用户名 */
@property (nonatomic,strong) UITextField *userNameTF;
/** 确定 */
@property (nonatomic,strong) UIButton *confirmBtn;

@end

@implementation HYSetPwdViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
}


- (void)setupSubviews{
    
    self.title = @"设置登录密码";
    self.view.backgroundColor = KAPP_TableView_BgColor;
    [self.view addSubview:self.userNameTF];
    [self.view addSubview:self.confirmBtn];
}

- (void)viewDidLayoutSubviews{
    
    [_userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(10 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(50 * WIDTH_MULTIPLE);
    }];
    
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_userNameTF.mas_bottom).offset(10 * WIDTH_MULTIPLE);
        make.left.equalTo(self.view).offset(15 * WIDTH_MULTIPLE);
        make.right.equalTo(self.view).offset(-15 * WIDTH_MULTIPLE);
        make.height.equalTo(@(40 * WIDTH_MULTIPLE));
    }];
}

#pragma mark - action
- (void)textChanged:(UITextField *)textField{
    
    if (textField.text.length >= 6 ) {
        
        self.confirmBtn.userInteractionEnabled = YES;
        self.confirmBtn.backgroundColor = KAPP_THEME_COLOR;
        [self.confirmBtn setTitleColor:KAPP_WHITE_COLOR forState:UIControlStateNormal];
    }
    else{
        
        self.confirmBtn.userInteractionEnabled = NO;
        self.confirmBtn.backgroundColor = KCOLOR(@"c2c2c2");
        [self.confirmBtn setTitleColor:KAPP_WHITE_COLOR forState:UIControlStateNormal];
    }
}

- (void)comfirmBtnAction{
    
    [HYUserRequestHandle setPasswordWithPhone:self.phone password:_userNameTF.text authCode:self.authCode ComplectionBlock:^(BOOL isSuccess) {
        
        if (isSuccess) {
            
            NSArray *array = self.navigationController.viewControllers;
            [self.navigationController popToViewController:array[array.count - 3] animated:YES];
        }
    }];
}


#pragma mark - lazyload
- (UITextField *)userNameTF{
    
    if (!_userNameTF) {
        
        _userNameTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _userNameTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"   密码" attributes:@{NSForegroundColorAttributeName:KAPP_7b7b7b_COLOR,NSFontAttributeName : KFitFont(14)}];
        _userNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userNameTF.font = KFitFont(14);
        _userNameTF.textAlignment = NSTextAlignmentLeft;
        _userNameTF.keyboardType = UIKeyboardTypeDefault;
        _userNameTF.secureTextEntry = YES;
        [_userNameTF setValue:[NSNumber numberWithInt:10] forKey:@"paddingLeft"];
        _userNameTF.backgroundColor = KAPP_WHITE_COLOR;
        _userNameTF.textColor = KAPP_272727_COLOR;
        [_userNameTF addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _userNameTF;
}


- (UIButton *)confirmBtn{
    
    if (!_confirmBtn) {
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = KCOLOR(@"c2c2c2");
        [_confirmBtn setTitleColor:KAPP_WHITE_COLOR forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = KFitFont(16);
        _confirmBtn.layer.cornerRadius = 2;
        _confirmBtn.clipsToBounds = YES;
        [_confirmBtn addTarget:self action:@selector(comfirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
