//
//  Macro.h
//  xtd
//
//  Created by leimo on 2017/8/10.
//  Copyright © 2017年 sj. All rights reserved.
//

#pragma mark - 常用宏定义

#ifndef Macro_h
#define Macro_h


#define  KAdjustsScrollViewInsets_NO(scrollView,vc)\
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"") \
if (@available(iOS 11.0,*))  {\
scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;\
} else {\
self.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \

/** ----------------------------设备信息---------------------------------
 --------------------------------------------------------------------*/
#pragma mark - 设备信息
/** 是否大于iOS7 */
#define iOS7                    ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
/** 是否为iphone4 */
#define IS_IPHONE_4             ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )
/** 是否为iphone5 */
#define IS_IPHONE_5             ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
/** 是否为iphone6 */
#define IS_IPHONE_6             ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
/** 是否为iphone6Plus */
#define IS_IPHONE_6PLUS         ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )
/** 设备的主window */
#define KEYWINDOW               [[[UIApplication sharedApplication] delegate] window]
#define KRootViewController     [UIApplication sharedApplication].keyWindow.rootViewController

/** ----------------------------尺寸信息---------------------------------
--------------------------------------------------------------------*/
#pragma mark - 尺寸信息
/** 屏幕宽度> */
#define KSCREEN_WIDTH       [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define KSCREEN_HEIGHT      [UIScreen mainScreen].bounds.size.height
/** 屏幕宽度比 */
#define WIDTH_MULTIPLE      KSCREEN_WIDTH / 375
/** 导航栏 + 状态栏 高度 */
#define KNAV_HEIGHT         ([[UIApplication sharedApplication] statusBarFrame].size.height + 44)
/** 状态栏高度 */
#define KSTATUSBAR_HEIGHT   [[UIApplication sharedApplication] statusBarFrame].size.height
/** tabBar高度 */
#define KTABBAR_HEIGHT      ([[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 83 : 49)





/** ----------------------------颜色信息---------------------------------
 --------------------------------------------------------------------*/
#pragma mark - APP颜色
/** APP主题色 */
#define KAPP_THEME_COLOR                   [UIColor colorWithHexString:@"4bc7b1"]
/** APP导航栏颜色 */
#define KAPP_NAV_COLOR                   [UIColor colorWithHexString:@"3f4950"]
/** 白色 */
#define KAPP_WHITE_COLOR                   [UIColor whiteColor]
/** 黑色 */
#define KAPP_BLACK_COLOR                   [UIColor blackColor]

#define KAPP_PRICE_COLOR                   [UIColor colorWithHexString:@"d0021b"]
/** APPb7b7b7文字颜色(颜色较浅) */
#define KAPP_b7b7b7_COLOR                   [UIColor colorWithHexString:@"b7b7b7"]
/** APP272727文字颜色 */
#define KAPP_272727_COLOR                   [UIColor colorWithHexString:@"272727"]
/** APP484848文字颜色 */
#define KAPP_484848_COLOR                   [UIColor colorWithHexString:@"484848"]
/** APP7b7b7b文字颜色(颜色较深) */
#define KAPP_7b7b7b_COLOR                   [UIColor colorWithHexString:@"7b7b7b"]
/** APPC2C2C2文字颜色(颜色较深) */
#define KAPP_c2c2c2_COLOR                   [UIColor colorWithHexString:@"c2c2c2"]
/** APPTableView背景色 */
#define KAPP_TableView_BgColor              [UIColor colorWithHexString:@"f4f4f4"]
/** APP文字特殊颜色 */
#define KAPP_TextSpecial_COLOR              [UIColor colorWithHexString:@"5fc6ef"]
/** APP分割线颜色 */
#define KAPP_SEPERATOR_COLOR               [UIColor colorWithHexString:@"ebe9e9"]
/** 颜色宏 */
#define KCOLOR(hexStr)                     [UIColor colorWithHexString:hexStr]
/** RGB颜色 */
#define RGBColor(r, g, b)                  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
/** RGB颜色(带透明度) */
#define RGBAColor(r, g, b ,a)              [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
/** 随机颜色 */
#define KAPP_RANDOM_COLOR                  RGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))



/** ----------------------------字体设置---------------------------------
 --------------------------------------------------------------------*/
#pragma mark - 字体设置
/** 常用字体 */
#define KFONT10                 [UIFont systemFontOfSize:10.0f]
#define KFONT11                 [UIFont systemFontOfSize:11.0f]
#define KFONT12                 [UIFont systemFontOfSize:12.0f]
#define KFONT14                 [UIFont systemFontOfSize:14.0f]
#define KFONT16                 [UIFont systemFontOfSize:16.0f]
#define KFONT18                 [UIFont systemFontOfSize:18.0f]
#define KFONT20                 [UIFont systemFontOfSize:20.0f]
/** 设置字体 */
#define KFont(font)             [UIFont systemFontOfSize:font]
/** 字体适配，如果是plus+2 iphone5-2 */
#define KFitFont(font)          [UIFont systemFontOfSize:((IS_IPHONE_6PLUS) ? (font + 2) : IS_IPHONE_5 ? (font - 2) : font)]

/** ----------------------------沙盒路径---------------------------------
 --------------------------------------------------------------------*/
#pragma mark - 沙盒路径
/** 沙盒document目录 */
#define KDOCUMENT_PATH          [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
/** 沙盒cache目录 */
#define KCACHE_PATH             [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#define KUSERDEFAULTS           [NSUserDefaults  standardUserDefaults]
#define KAccountPhone           [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"]
#define KAccountPassword        [[NSUserDefaults standardUserDefaults] objectForKey:@"password"]
#define KLoginType              [[NSUserDefaults standardUserDefaults] objectForKey:@"loginType"]
#define KUserDefaultsForKey(key)                 [[NSUserDefaults standardUserDefaults] objectForKey:key]



#endif /* Macro_h */
