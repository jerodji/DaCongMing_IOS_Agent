//
//  HYMyTeamViewController.m
//  Agency
//
//  Created by Jack on 2017/11/16.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYMyTeamViewController.h"
#import "HYChatViewController.h"

@interface HYMyTeamViewController ()

@end

@implementation HYMyTeamViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubViews];
}

- (void)setupSubViews{
    
    self.title = @"我的团队";
    
    UIButton *rongCloudBtn = [[UIButton alloc] init];
    [rongCloudBtn setTitle:@"立即加入" forState:UIControlStateNormal];
    rongCloudBtn.titleLabel.font = KFitFont(18);
    rongCloudBtn.backgroundColor = KAPP_THEME_COLOR;
    [rongCloudBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:rongCloudBtn];
    rongCloudBtn.frame = CGRectMake(0, 150, KSCREEN_WIDTH, 40);
    [[rongCloudBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        HYChatViewController *chatVC = [[HYChatViewController alloc] initWithConversationType:ConversationType_GROUP targetId:@"lsVuoM7Jx"];
        [self.navigationController pushViewController:chatVC animated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
