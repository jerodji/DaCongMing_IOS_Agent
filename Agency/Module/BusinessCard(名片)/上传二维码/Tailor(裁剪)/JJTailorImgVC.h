//
//  JJTailorImgVC.h
//  TailorDemo
//
//  Created by JerodJi on 2017/9/10.
//  Copyright © 2017年 Jerod. All rights reserved.
//

#import <UIKit/UIKit.h>

#define max_multiple  2  //裁剪图片的放大倍数
//#define one_multiple  1  //1倍大小
//#define min_multiple  0.6  //裁剪图片的缩小倍数


#define SquareDistance  10.0f
#define SquareWidth  (ScreenWidth-2*SquareDistance)
#define SquareHeight SquareWidth

typedef NS_ENUM(NSInteger, JITailorForm)
{
    JITailorFormCoterie = 0,
    JITailorFormSquare  ,
    JITailorFormRectangle
};

typedef void (^FINISH_BLK)(UIImage *finishImage);

@interface JJTailorImgVC : UIViewController

@property (nonatomic,assign) NSInteger liveStyle;

//- (instancetype)initWithImage:(UIImage*)image form:(JITailorForm)form finishCB:(FINISH_BLK)finishBlk;

/**
 裁剪图片
 @param image 要裁剪的图片
 @param form  裁剪形式
 @param finishBlk 裁剪完成后的回调->裁剪完成后的图片
 */
- (void)tailorImage:(UIImage*)image form:(JITailorForm)form finishCB:(FINISH_BLK)finishBlk;

@end
