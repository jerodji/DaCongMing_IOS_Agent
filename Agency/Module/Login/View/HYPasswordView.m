//
//  HYPasswordView.m
//  FlowerHan
//
//  Created by Jackhu on 2017/5/10.
//  Copyright © 2017年 Jackhu. All rights reserved.
//

#define PasswordNum     6
#define Width           KSCREEN_WIDTH - 80 * WIDTH_MULTIPLE
#define leftMargin      20 * WIDTH_MULTIPLE
#define margin          10 * WIDTH_MULTIPLE

#import "HYPasswordView.h"

@interface HYPasswordView()

/** 密码位数 */
@property (nonatomic,assign) NSInteger passwordNum;

/** 密码框的宽度 */
@property (nonatomic,assign) CGFloat squareWidth;

/** 原点半径 */
@property (nonatomic,assign) CGFloat dotRadius;



@end

@implementation HYPasswordView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self becomeFirstResponder];
        self.backgroundColor = [UIColor whiteColor];
        self.passwordString = [NSMutableString string];
        self.passwordNum = 6;
        self.dotRadius = 6;
        self.squareWidth = (Width - 5 * margin) / 6;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{

    [super drawRect:rect];
    
    [self drawBorder];
    
    if (self.isSetPassword) {
        
        [self drawDot];
    }
    else{
        
        [self drawText];
    }
    
}

#pragma mark - method
- (void)drawBorder{
    
    //画外框
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat borderX = 0;
    for (NSInteger i = 0; i < 6; i++) {
        
        borderX = i * (_squareWidth + margin) + leftMargin;
        CGContextAddRect(context, CGRectMake(borderX, 0, self.squareWidth, self.height));
        CGContextSetLineWidth(context, 1);
        CGContextSetStrokeColorWithColor(context, KAPP_7b7b7b_COLOR.CGColor);
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    }
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)drawDot{
    
    //画小黑点
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (NSInteger i = 0; i < self.passwordString.length; i++) {
        
        CGFloat dotX = i * (_squareWidth + margin) + self.squareWidth / 2 + leftMargin;
        CGFloat dotY = (self.height - self.dotRadius) / 2 + 2;
        CGContextAddArc(context, dotX , dotY , self.dotRadius, 0, M_PI * 2, YES);
        CGContextSetFillColorWithColor(context, KAPP_7b7b7b_COLOR.CGColor);
        CGContextDrawPath(context, kCGPathFill);
    }
}

- (void)drawText{
    
    for (NSInteger i = 0; i < self.passwordString.length; i++) {
        
        CGFloat dotX = i * (_squareWidth + margin) + leftMargin;
        CGFloat dotY = (self.height - self.dotRadius) / 2;
        
        NSString *str = [self.passwordString substringWithRange:NSMakeRange(i, 1)];
        CGFloat strWidth = [str widthForFont:KFitFont(24)];
        CGFloat strHeight = [str heightForFont:KFitFont(24) width:strWidth];
        CGFloat strY = dotY - strHeight / 2 + 2;
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = NSTextAlignmentCenter;
        [str drawInRect:CGRectMake(dotX, strY, self.squareWidth, self.height) withAttributes:@{NSFontAttributeName : KFitFont(24),NSParagraphStyleAttributeName : style}];
    }
}

#pragma mark - UIKeyInputDelegate
- (UIKeyboardType)keyboardType{
    
    return UIKeyboardTypeNumberPad;
}

- (BOOL)canBecomeFirstResponder{
    
    return YES;
}

- (BOOL)becomeFirstResponder{
    
    if (_delegate && [_delegate respondsToSelector:@selector(passwordBeginInput:)]) {
        
        [_delegate passwordBeginInput:self];
    }
    return [super becomeFirstResponder];
}


//用于显示文本对象是否有文本
- (BOOL)hasText{
    
    return self.passwordString.length > 0;
}

//插入文本
- (void)insertText:(NSString *)text{

    if (self.passwordString.length < self.passwordNum) {
        //判断是否为数字
        NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        NSString *filterStr = [[text componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""];
        if ([text isEqualToString:filterStr]) {
            
            [self.passwordString appendString:text];
            
            if (_delegate && [_delegate respondsToSelector:@selector(passwordDidChange:)]) {
                
                [_delegate passwordDidChange:self];
            }
            
            [self setNeedsDisplay];
        }
        
    }
    
    if (self.passwordString.length == self.passwordNum) {
        //输入完成
        if (_delegate && [_delegate respondsToSelector:@selector(passwordCompleteInput:)]) {
            
            [_delegate passwordCompleteInput:self];
        }
        [self resignFirstResponder];
    }
}

//删除文本
- (void)deleteBackward{

    if (self.passwordString.length > 0) {
        
        [self.passwordString deleteCharactersInRange:NSMakeRange(self.passwordString.length - 1, 1)];
        if (_delegate && [_delegate respondsToSelector:@selector(passwordDidChange:)]) {
            
            [_delegate passwordDidChange:self];
        }
        
    }
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (![self isFirstResponder]) {
        
        [self becomeFirstResponder];
    }
    
}

@end
