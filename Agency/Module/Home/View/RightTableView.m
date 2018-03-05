//
//  RightTableView.m
//  Agency
//
//  Created by hailin on 2018/3/3.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import "RightTableView.h"
#import "HYTeamMemberCell.h"

static NSString* const RightCellid = @"righttablecellid";

@implementation RightTableView

- (void)setupDelegate {
    self.delegate = self;
    self.dataSource = self;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *teamMemberCellID = @"rightCustomerCellid";
    HYTeamMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:teamMemberCellID];
    if (!cell) {
        cell = [[HYTeamMemberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:teamMemberCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.agencyLabel.hidden = YES;
    }
    cell.model = _dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60 * WIDTH_MULTIPLE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    delog("%ld",(long)indexPath.row);
}

@end
