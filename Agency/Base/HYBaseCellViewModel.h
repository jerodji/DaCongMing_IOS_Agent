//
//  HYBaseCellViewModel.h
//  Agency
//
//  Created by 胡勇 on 2017/11/6.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYBaseCellViewModel : NSObject

/** cell背景颜色 */
@property (nonatomic, strong) UIColor *cellBackgroundColor;
/** cell identifier */
@property (nonatomic, copy) NSString *cellIdentifier;
/** cell height */
@property (nonatomic,assign) CGFloat cellHeight;

@property (nonatomic, strong) NSIndexPath *cellIndexPath;
@property (nonatomic, strong) UITableViewCell *cell;

@end
