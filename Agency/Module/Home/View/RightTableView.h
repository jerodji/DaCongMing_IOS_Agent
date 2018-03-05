//
//  RightTableView.h
//  Agency
//
//  Created by hailin on 2018/3/3.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray * dataArray;

- (void)setupDelegate;


@end
