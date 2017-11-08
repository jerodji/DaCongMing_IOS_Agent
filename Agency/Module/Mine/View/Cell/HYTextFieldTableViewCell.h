//
//  HYTextFieldTableViewCell.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/28.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYUploadIDCardViewModel.h"

@class HYTextFieldTableViewCell;

@protocol HYTextFieldCellDelegate <NSObject>

//textView刷新tableViewCell
- (void)textFieldCellInput:(HYTextFieldTableViewCell *)cell;

@end

@interface HYTextFieldTableViewCell : UITableViewCell

/** title */
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *placeholder;


/** delegate */
@property (nonatomic,weak) id<HYTextFieldCellDelegate>delegate;

@property (nonatomic,strong) NSIndexPath *indexPath;


- (void)setWithViewModel:(HYUploadIDCardViewModel *)viewModel;

@end
