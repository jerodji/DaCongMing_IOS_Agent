//
//  QrButton.m
//  Agency
//
//  Created by hailin on 2018/2/6.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import "QrButton.h"

@implementation QrButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.titleLabel.font = [UIFont systemFontOfSize:11];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat wid = self.bounds.size.width;
    CGFloat hei = self.bounds.size.height;
    CGFloat w = 188 * WidthScale;
    CGFloat h = 188 * WidthScale;
    return CGRectMake(wid/2-w/2, hei/2-w/2, w, w);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, self.bounds.size.height - 18*WidthScale - 20*WidthScale, self.bounds.size.width, 20*WidthScale);
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
