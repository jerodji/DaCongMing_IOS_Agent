//
//  HYBaseTableViewModel.h
//  Agency
//
//  Created by 胡勇 on 2017/11/6.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYBaseTableViewModel : NSObject

/** tableView背景颜色 */
@property (nonatomic, strong) UIColor *backgroundColor;
/** tableView分割线颜色 */
@property (nonatomic, strong) UIColor *separatorColor;

/** 头视图 */
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIView *footerView;
@property (nonatomic,strong) NSMutableArray *datalist;
@property (nonatomic,assign) CGFloat headerHeight;
@property (nonatomic,assign) CGFloat footerHeight;

@end
