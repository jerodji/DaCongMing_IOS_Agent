//
//  JJAlbumVC.h
//  Agency
//
//  Created by hailin on 2018/2/6.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJAlbumManager.h"

typedef void (^QRFINISHBLK)(PHAsset* phAsset);

@interface JJAlbumVC : UIViewController
@property (nonatomic,copy) QRFINISHBLK qrSelectedCB;
@end


@interface PhotoCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView * photo;
@end
