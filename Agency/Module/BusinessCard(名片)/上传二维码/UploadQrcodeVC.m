//
//  UploadQrcodeVC.m
//  Agency
//
//  Created by hailin on 2018/2/6.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import "UploadQrcodeVC.h"
#import "JJAlbumVC.h"
#import "JJTailorImgVC.h"

@interface UploadQrcodeVC ()
@property (nonatomic,strong) UIImage * finishImg;
@end

@implementation UploadQrcodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上传二维码";
    self.view.backgroundColor = UIColorRGB(90, 90, 90);
    
    _backView.layer.cornerRadius = 10;
    
    _headIconImgView.layer.cornerRadius = 50;
    _headIconImgView.layer.borderWidth = 2;
    _headIconImgView.layer.borderColor = [UIColor blackColor].CGColor;
    _headIconImgView.backgroundColor = [UIColor whiteColor];
    
    _sexImgView.layer.cornerRadius = 12.5;
    
    [_qrbtn setImage:[UIImage imageNamed:@"erweima"] forState:UIControlStateNormal];
    [_qrbtn setTitle:@"点击上传二维码" forState:UIControlStateNormal];
    [_qrbtn addTarget:self action:@selector(selectQrcodePhoto) forControlEvents:UIControlEventTouchUpInside];
    
    _sureBtn.layer.cornerRadius = 10;
    [_sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectQrcodePhoto {
    JJAlbumVC* album = [[JJAlbumVC alloc] init];
    [self.navigationController pushViewController:album animated:YES];
    
    __weak typeof(JJAlbumVC*) wkAlbum = album;
    __weak typeof(self) wkself = self;
    
    album.qrSelectedCB = ^(PHAsset *phAsset) {
        // PHAsset 转换 image
        PHImageRequestOptions * options = [[PHImageRequestOptions alloc]init];
        options.deliveryMode  =PHImageRequestOptionsDeliveryModeHighQualityFormat;
        
        CGSize size = [UIScreen mainScreen].bounds.size;
        
        [[PHImageManager defaultManager] requestImageForAsset:phAsset targetSize:size contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info)
         {
             JJTailorImgVC * tailorVC = [[JJTailorImgVC alloc] init];
             [wkself.navigationController pushViewController:tailorVC animated:YES];
             [tailorVC tailorImage:result form:JITailorFormSquare finishCB:^(UIImage *finishImage) {
                 wkself.finishImg = finishImage;
                 [wkself.qrbtn setImage:finishImage forState:UIControlStateNormal];
                 [wkAlbum.navigationController popViewControllerAnimated:YES];
             }];
         }];
    };
}

- (void)sureAction {
    if (!_finishImg) {
        [JJAlert showMessageWithVC:self message:@"请先选择二维码图片" cancleAction:nil sureAction:nil];
        return;
    }

    NSLog(@"等上传二维码接口");
    
}

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
