//
//  HYTableViewModel.h
//  Agency
//
//  Created by 胡勇 on 2017/11/6.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYTableViewModel : NSObject

/** tableView背景颜色 */
@property (nonatomic, strong) UIColor *backgroundColor;
/** cell背景颜色 */
@property (nonatomic, strong) UIColor *cellBackgroundColor;
/** 头视图 */
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIView *footerView;

@property (nonatomic,assign) CGFloat headerHeight;
@property (nonatomic,assign) CGFloat footerHeight;

@end
