//
//  UploadQrcodeVC.h
//  Agency
//
//  Created by hailin on 2018/2/6.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import "HYBaseViewController.h"
#import "QrButton.h"

@interface UploadQrcodeVC : HYBaseViewController

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *headIconImgView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImgView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet QrButton *qrbtn;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end
