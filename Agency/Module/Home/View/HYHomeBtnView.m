//
//  HYHomeBtnView.m
//  Agency
//
//  Created by 胡勇 on 2017/11/2.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomeBtnView.h"

@interface HYHomeBtnView()

@end

@implementation HYHomeBtnView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews{
    
    for (UIButton *button in self.subviews) {
        
        [button removeFromSuperview];
    }
    
    [self createButtonsWithCount:4];
}

- (void)createButtonsWithCount:(NSInteger)count{
    
    CGFloat itemMargin = 20 * WIDTH_MULTIPLE;
    CGFloat itemVerMargin = 50 * WIDTH_MULTIPLE;
    CGFloat itemWidth = (self.width - itemVerMargin * 3) / 2;
    CGFloat itemHeight = (self.height - itemMargin) / 2;
    
    NSArray *imageArray = @[@"wallet",@"mine",@"about",@"quit"];
    for (NSInteger i = 0; i < count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        button.tag = 100 + i;
        [self addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
           
            CGFloat buttonTop = i / 2 * (itemHeight + itemMargin);
            CGFloat buttonLeft = i % 2 * (itemWidth + itemVerMargin) + itemVerMargin;
            
            make.top.equalTo(self).offset(buttonTop);
            make.left.equalTo(self).offset(buttonLeft);
            make.size.mas_equalTo(CGSizeMake(itemWidth, itemHeight));
        }];
    }
}

@end
