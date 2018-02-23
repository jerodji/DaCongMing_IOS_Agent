//
//  JJPublicDefine.h
//  Agency
//
//  Created by hailin on 2018/1/30.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/******************* DEBUG *******************/
#ifdef DEBUG
#define delog(format, ...) NSLog((@"%s " "%s(%d)\n" format "\n-----------------------------------------------------"), __PRETTY_FUNCTION__, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, ##__VA_ARGS__);
#else
#define delog(format, ...)
#endif

/******************* screen size info *******************/

/* Main Screen Width */
#define ScreenWidth      [UIScreen mainScreen].bounds.size.width
/* Main Screen Height */
#define ScreenHeight      [UIScreen mainScreen].bounds.size.height
/* Statusbar Height , X 44, others 20 */
#define StatusHeight     [[UIApplication sharedApplication] statusBarFrame].size.height
/* Navigationbar Height */
#define NavHeight        44.f
/* Tabbar Height */
#define TabbarHeight     (49.f + HomebarH )  //83
/* 底部home margin, X 34pt */
#define HomebarHeight    ((StatusHeight==44.f) ? 34.f : 0)
//#define SafeAboveHeight 44
//#define SafeBelowHeight HomebarH


/* Width Scale,宽度放大或缩小的倍数--以375屏幕为基准的比例 */
#define WidthScale  (ScreenWidth/375.f)

/**                                          尺寸point    分辨率
 *  1 判断是否为3.5-inch - (@2x) 3GS(@1x) 4S   320*480    640*960
 *  2 判断是否为4.0-inch - (@2x) 5 5C 5S SE    320*568    640*1136
 *  3 判断是否为4.7-inch - (@2x) 6 6S 7 8      375*667    750*1334
 *  4 判断是否为5.5-inch - (@3x) 6P 7P 8P      414*736    1242*2208
 *  5                    (@3x)  X            375*812    1125 * 2436
 */
/* 4S */
#define SCREENINCH_3_5_4S  ((MSH > 470) && (MSH < 490))
/* 5 5C 5S SE */
#define SCREENINCH_4_0  ((MSH > 558) && (MSH < 578))
/* 6 6S 7 8 */
#define SCREENINCH_4_7  ((MSH > 657) && (MSH < 687))
/* 6P 7P 8P */
#define SCREENINCH_5_5_P  ((MSH > 726) && (MSH < 746))
/* X */
//#define SCREENINCH_5_8_X (MSH==812.f)
#define SCREENINCH_5_8_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


/******************* color *******************/

#define UIColorRGB(r,g,b)     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define UIColorRGBA(r,g,b,a)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define UIColorRandom         UIColorRGBA(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 1)

@interface JJPublicDefine : NSObject



@end
