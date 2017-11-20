//
//  HYTextFieldTableViewCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/28.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYTextFieldTableViewCell.h"

@interface HYTextFieldTableViewCell() <UITextFieldDelegate>

/** 标题 */
@property (nonatomic,strong) UILabel *titleLabel;
/** textField */
@property (nonatomic,strong) UITextField *textField;
/** bottomLine */
@property (nonatomic,strong) UIView *bottomLine;

/** arrow */
@property (nonatomic,strong) UIImageView *arrowImgView;

@end

@implementation HYTextFieldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.textField];
    [self addSubview:self.bottomLine];
    [self addSubview:self.arrowImgView];
    
}

- (void)layoutSubviews{
        
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(100 * WIDTH_MULTIPLE);
    }];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.height.equalTo(_titleLabel);
        make.right.equalTo(self).offset(50 * WIDTH_MULTIPLE);
        make.left.equalTo(_titleLabel.mas_right);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@1);
    }];
}

#pragma mark - action
- (void)textFieldInputChange:(UITextField *)textField{
    

    if (_delegate && [_delegate respondsToSelector:@selector(textFieldCellInput:)]) {
        
        [_delegate textFieldCellInput:self];
    }
}


#pragma mark - setter
- (void)setTitle:(NSString *)title{
    
    _title = title;
    _titleLabel.text = title;
    
}

- (void)setPlaceholder:(NSString *)placeholder{
    
    _placeholder = placeholder;
    _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:KAPP_b7b7b7_COLOR,NSFontAttributeName : KFitFont(14)}];
}

- (void)setWithViewModel:(HYUploadIDCardViewModel *)viewModel{
    
    if (self.indexPath.row == 0) {
        
        RAC(viewModel,name) = [_textField rac_textSignal];
    }
    
    if (self.indexPath.row == 1) {
        
        [_textField.rac_textSignal subscribeNext:^(NSString *x) {
            
            if (x.length >= 18) {
                
                _textField.text = [x substringToIndex:18];
            }
        }];
        RAC(viewModel,IDCard) = [_textField rac_textSignal];
    }
    
    if (self.indexPath.row == 2) {
        
        //银行卡
        _textField.keyboardType = UIKeyboardTypePhonePad;
        [_textField.rac_textSignal subscribeNext:^(NSString *x) {
            
            if (x.length >= 22) {
                
                _textField.text = [x substringToIndex:22];
            }
        }];
        RAC(viewModel,bankCardNum) = [_textField rac_textSignal];
    }
    
}

#pragma mark - lazyload
- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KFitFont(16);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"用户名";
        _titleLabel.textColor = KAPP_272727_COLOR;
    }
    return _titleLabel;
}

- (UITextField *)textField{
    
    if (!_textField) {
        
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.font = KFitFont(14);
        _textField.textColor = KAPP_7b7b7b_COLOR;
        _textField.keyboardType = UIKeyboardTypeDefault;
    }
    return _textField;
}

- (UIView *)bottomLine{
    
    if (!_bottomLine) {
        
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _bottomLine;
}

- (UIImageView *)arrowImgView{
    
    if (!_arrowImgView) {
        
        _arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_arrow"]];
        _arrowImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImgView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
