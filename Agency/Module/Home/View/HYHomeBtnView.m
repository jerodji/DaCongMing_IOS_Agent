//
//  HYHomeBtnView.m
//  Agency
//
//  Created by 胡勇 on 2017/11/2.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomeBtnView.h"


@interface HYHomeBtnView()

/** viewModel */
@property (nonatomic,strong) HYHomeViewModel *viewModel;

@end

@implementation HYHomeBtnView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        [self createButtonsWithCount];
    }
    return self;
}

- (void)layoutSubviews{
    
    for (UIButton *button in self.subviews) {
        
        [button removeFromSuperview];
    }
    
    [self createButtonsWithCount];
}

- (void)createButtonsWithCount{
//    self.backgroundColor = [UIColor redColor];
    CGFloat itemMargin = 20 * WIDTH_MULTIPLE;
    CGFloat itemVerMargin = 50 * WIDTH_MULTIPLE;
    CGFloat itemWidth = (self.width - itemVerMargin * 3) / 2;
    CGFloat itemHeight = (self.height - itemMargin) / 2;
    
    NSArray *imageArray = @[@"wallet",@"mine",@"about",@"news_button"];
    for (NSInteger i = 0; i < imageArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        button.tag = 100 + i;
        [self addSubview:button];
        
        if(itemWidth < 0) return;
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
           
            CGFloat buttonTop = i / 2 * (itemHeight + itemMargin);
            CGFloat buttonLeft = i % 2 * (itemWidth + itemVerMargin) + itemVerMargin;
            
            make.top.equalTo(self).offset(buttonTop);
            make.left.equalTo(self).offset(buttonLeft);
            make.size.mas_equalTo(CGSizeMake(itemWidth, itemHeight));
        }];

//        if (i == 4) {
//            NSLog(@"aaaaaaaa");
//            [button mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.size.mas_equalTo(CGSizeMake(itemWidth, itemHeight));
//                make.top.equalTo(self).offset((self.height/2.f - itemHeight/2.f));
//                make.right.equalTo(self).offset(-itemWidth/2.f);
//            }];
//        }
        
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)buttonClick:(UIButton *)button{
    
    [self.viewModel.buttonSubject sendNext:@(button.tag - 100)];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribe:self.viewModel.buttonSubject];
}

- (void)setWithViewModel:(id)viewModel{
    
    self.viewModel = viewModel;
    

}

@end
