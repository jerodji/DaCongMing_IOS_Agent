//
//  HYReportListCell.h
//  Agency
//
//  Created by 胡勇 on 2017/11/13.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYReportCellViewModel.h"

@interface HYReportListCell : UITableViewCell


@property (nonatomic,strong) NSIndexPath *indexPath;

- (void)setWithViewModel:(HYReportCellViewModel *)viewModel;

@end
