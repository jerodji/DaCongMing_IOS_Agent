//
//  HYTextFieldTableViewCell.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/28.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYUploadIDCardViewModel.h"
#import "HYRecommendViewModel.h"

@class HYTextFieldTableViewCell;

@protocol HYTextFieldCellDelegate <NSObject>

//textView刷新tableViewCell
- (void)textFieldCellInput:(HYTextFieldTableViewCell *)cell;

@end

@interface HYTextFieldTableViewCell : UITableViewCell

/** title */
@property (nonatomic,copy) NSString *title;
/** 站位显示 */
@property (nonatomic,copy) NSString *placeholder;

/** delegate */
@property (nonatomic,weak) id<HYTextFieldCellDelegate>delegate;

@property (nonatomic,strong) NSIndexPath *indexPath;

/** 上传身份证信息viewModel */
- (void)setWithViewModel:(HYUploadIDCardViewModel *)viewModel;

/** 推荐用户viewModel */
- (void)setWithRecommendViewModel:(HYRecommendViewModel *)recommendViewModel;

@end
