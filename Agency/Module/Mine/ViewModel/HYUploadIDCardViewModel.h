//
//  HYUploadIDCardViewModel.h
//  Agency
//
//  Created by 胡勇 on 2017/11/8.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYUploadIDCardViewModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *IDCard;
@property (nonatomic,copy) NSString *bankCardNum;
@property (nonatomic,copy) NSString *authNum;
@property (nonatomic,copy) NSString *authBtnTitle;
@property (nonatomic,copy) NSString *tipsLabelText;
@property (nonatomic,assign) BOOL isGetAuth;
@property (nonatomic,strong) RACSubject *uploadInfoSuccessSubject;

- (RACSignal *)getAuthCodeButtonIsValid;
- (RACSignal *)confirmButtonIsValid;
- (void)getAuthCodeAction;
- (void)confirmAction;

@end
