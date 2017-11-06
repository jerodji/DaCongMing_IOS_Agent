//
//  HYTableViewManager.m
//  Agency
//
//  Created by 胡勇 on 2017/11/6.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYTableViewManager.h"

@interface HYTableViewManager() <UITableViewDelegate,UITableViewDataSource>



@end

@implementation HYTableViewManager


- (instancetype)initWithFrame:(CGRect)frame andViewModel:(HYBaseTableViewModel *)viewModel{
    
    if (self = [super init]) {
        
        self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.backgroundColor = viewModel.backgroundColor;
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}


#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_delegate && [_delegate respondsToSelector:@selector(HYNumberOfSectionsInTableView:)]) {
        
        return [_delegate HYNumberOfSectionsInTableView:tableView];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_delegate && [_delegate respondsToSelector:@selector(HYTableView:numberOfRowsInSection:)]) {
        
        return [_delegate HYTableView:tableView numberOfRowsInSection:section];
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(HYTableView:cellForRowAtIndexPath:)]) {
        
        
        return [_delegate HYTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    static NSString *cellID = @"customCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (_delegate && [_delegate respondsToSelector:@selector(HYTableView:viewForHeaderInSection:)]) {
        
        return [_delegate HYTableView:tableView viewForHeaderInSection:section];
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (_delegate && [_delegate respondsToSelector:@selector(HYTableView:viewForFooterInSection:)]) {
        
        return [_delegate HYTableView:tableView viewForFooterInSection:section];
    }
    
    return nil;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_delegate && [_delegate respondsToSelector:@selector(HYTableView:didSelectRowAtIndexPath:)]) {
        
        [_delegate HYTableView:tableView didSelectRowAtIndexPath:indexPath];
        return;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_delegate && [_delegate respondsToSelector:@selector(HYTableView:heightForRowAtIndexPath:)]) {
        
        return [_delegate HYTableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (_delegate && [_delegate respondsToSelector:@selector(HYTableView:heightForHeaderInSection:)]) {
        
        return [_delegate HYTableView:tableView heightForHeaderInSection:section];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (_delegate && [_delegate respondsToSelector:@selector(HYTtableView:heightForFooterInSection:)]) {
        
        return [_delegate HYTtableView:tableView heightForFooterInSection:section];
    }
    return 0;
}


@end
