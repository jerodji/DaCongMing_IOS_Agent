//
//  HYUploadIDCardViewController.h
//  Agency
//
//  Created by 胡勇 on 2017/11/8.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseViewController.h"


@interface HYUploadIDCardViewController : HYBaseViewController

/** YES 绑定银行卡 ,  NO 实名认证 */
@property (nonatomic,assign) BOOL isBindBankCard;

//绑定是否成功
@property (nonatomic,assign) BOOL UploadSucc;

@end
