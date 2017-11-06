//
//  HYTableViewManager.h
//  Agency
//
//  Created by 胡勇 on 2017/11/6.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYBaseTableViewModel.h"

@protocol HYTableViewManagerDelegate <NSObject>

@required

/** tableView cell count */
- (NSInteger)HYTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

/** cell height */
- (CGFloat)HYTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

/** cell */
- (UITableViewCell *)HYTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

/** section count */
- (NSInteger)HYNumberOfSectionsInTableView:(UITableView *)tableView;

/** footer view */
- (UIView *)HYTableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;

/** header view */
- (UIView *)HYTableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;

/** footer height */
- (CGFloat)HYTtableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;

/** header height */
- (CGFloat)HYTableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;

/** didSelect */
- (void)HYTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


@end

@interface HYTableViewManager : NSObject

/** tableView */
@property (nonatomic,strong) UITableView *tableView;

/** delegate */
@property (nonatomic,weak) id<HYTableViewManagerDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame andViewModel:(HYBaseTableViewModel *)viewModel;

@end
