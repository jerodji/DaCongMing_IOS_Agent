//
//  HYReportSelectCell.m
//  Agency
//
//  Created by 胡勇 on 2017/11/6.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYReportSelectCell.h"
#import "HYReportSelectCellModel.h"

@interface HYReportSelectCell()

/** 开始时间 */
@property (nonatomic,strong) UILabel *startTimeLabel;
/** 结束事件 */
@property (nonatomic,strong) UILabel *endTimeLabel;
@property (nonatomic,strong) UILabel *startTimeValueLabel;
@property (nonatomic,strong) UILabel *endTimeValueLabel;
@property (nonatomic,strong) UIView *topLine;
/** 订单号输入框 */
@property (nonatomic,strong) UITextField *orderNumTF;
@property (nonatomic,strong) UIView *middleLine;
/** 已入账 */
@property (nonatomic,strong) UIButton *beEntry;
/** 未入账 */
@property (nonatomic,strong) UIButton *notEntry;
/** 查询 */
@property (nonatomic,strong) UIButton *selectBtn;
/** cellModel */
@property (nonatomic,strong) HYReportSelectCellModel *cellModel;
/** 记录入账选择btn */
@property (nonatomic,strong) UIButton *tempButton;

@end

@implementation HYReportSelectCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.startTimeLabel];
    [self addSubview:self.endTimeLabel];
    [self addSubview:self.startTimeValueLabel];
    [self addSubview:self.endTimeValueLabel];
    [self addSubview:self.topLine];
    [self addSubview:self.orderNumTF];
    [self addSubview:self.middleLine];
    [self addSubview:self.beEntry];
    [self addSubview:self.notEntry];
    [self addSubview:self.selectBtn];
}

- (void)layoutSubviews{
    
    [_startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(80 * WIDTH_MULTIPLE, 40 * WIDTH_MULTIPLE));
    }];
    
    [_endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.width.height.equalTo(_startTimeLabel);
        make.top.equalTo(_startTimeLabel.mas_bottom);
    }];
    
    [_startTimeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_startTimeLabel.mas_right);
        make.top.bottom.equalTo(_startTimeLabel);
        make.right.equalTo(self);
    }];
    
    [_endTimeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_endTimeLabel.mas_right);
        make.top.bottom.equalTo(_endTimeLabel);
        make.right.equalTo(self);
    }];

    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(1);
        make.top.equalTo(_endTimeLabel.mas_bottom);
    }];

    [_orderNumTF mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.right.equalTo(_topLine);
        make.height.mas_equalTo(48 * WIDTH_MULTIPLE);
        make.top.equalTo(_topLine.mas_bottom);
    }];
    
    [_middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.height.equalTo(_topLine);
        make.top.equalTo(_orderNumTF.mas_bottom);
    }];
    
    [_beEntry mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.height.equalTo(_startTimeLabel);
        make.top.equalTo(_middleLine.mas_bottom);
        make.width.mas_equalTo(80 * WIDTH_MULTIPLE);
    }];
    
    [_notEntry mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.top.width.equalTo(_beEntry);
        make.left.equalTo(_beEntry.mas_right).offset(20 * WIDTH_MULTIPLE);
    }];

    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-15 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(50 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self).offset(-15 * WIDTH_MULTIPLE);
    }];
}


#pragma mark - setter
- (void)setCellWithViewModel:(HYReportSelectCellModel *)viewModel{
    
    self.cellModel = viewModel;
    [self addGesture];

    RAC(viewModel,orderNo) = [_orderNumTF rac_textSignal];
    RAC(self.startTimeValueLabel,text) = RACObserve(viewModel, startTimeStr);
    RAC(self.endTimeValueLabel,text) = RACObserve(viewModel, endTimeStr);
    
    [[_selectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        [viewModel selectReports];
    }];
}

- (void)addGesture{
    
    UITapGestureRecognizer *startValueTap = [[UITapGestureRecognizer alloc] init];
    [_startTimeValueLabel addGestureRecognizer:startValueTap];
    [startValueTap.rac_gestureSignal subscribeNext:^(id x) {
        
        [self.cellModel showStartValueSelectView];
    }];
    
    UITapGestureRecognizer *endValueTap = [[UITapGestureRecognizer alloc] init];
    [_endTimeValueLabel addGestureRecognizer:endValueTap];
    [endValueTap.rac_gestureSignal subscribeNext:^(id x) {
        
        [self.cellModel showEndValueSelectView];
    }];
}

- (void)entryBtnAction:(UIButton *)button{
    
    _tempButton.selected = NO;
    button.selected = !button.selected;
    _tempButton = button;
    
    self.cellModel.isEntry = _beEntry.selected;
}

#pragma mark - lazyload
- (UILabel *)startTimeLabel{
    
    if (!_startTimeLabel) {
        
        _startTimeLabel = [[UILabel alloc] init];
        _startTimeLabel.font = KFitFont(14);
        _startTimeLabel.textColor = KAPP_7b7b7b_COLOR;
        _startTimeLabel.text = @"开始时间";
        _startTimeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _startTimeLabel;
}

- (UILabel *)endTimeLabel{
    
    if (!_endTimeLabel) {
        
        _endTimeLabel = [[UILabel alloc] init];
        _endTimeLabel.font = KFitFont(14);
        _endTimeLabel.textColor = KAPP_7b7b7b_COLOR;
        _endTimeLabel.text = @"结束时间";
        _endTimeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _endTimeLabel;
}

- (UILabel *)startTimeValueLabel{
    
    if (!_startTimeValueLabel) {
        
        _startTimeValueLabel = [[UILabel alloc] init];
        _startTimeValueLabel.font = KFitFont(14);
        _startTimeValueLabel.textColor = KAPP_272727_COLOR;
        _startTimeValueLabel.text = @"点我选择开始时间";
        _startTimeValueLabel.textAlignment = NSTextAlignmentLeft;
        _startTimeValueLabel.userInteractionEnabled = YES;
        
    }
    return _startTimeValueLabel;
}

- (UILabel *)endTimeValueLabel{
    
    if (!_endTimeValueLabel) {
        
        _endTimeValueLabel = [[UILabel alloc] init];
        _endTimeValueLabel.font = KFitFont(14);
        _endTimeValueLabel.textColor = KAPP_272727_COLOR;
        _endTimeValueLabel.text = @"点我选择结束时间";
        _endTimeValueLabel.textAlignment = NSTextAlignmentLeft;
        _endTimeValueLabel.userInteractionEnabled = YES;

    }
    return _endTimeValueLabel;
}

- (UIView *)topLine{
    
    if (!_topLine) {
        
        _topLine = [UIView new];
        _topLine.backgroundColor = KAPP_SEPERATOR_COLOR;
        
        _middleLine = [UIView new];
        _middleLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _topLine;
}

- (UITextField *)orderNumTF{
    
    if (!_orderNumTF) {
        
        _orderNumTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _orderNumTF.backgroundColor = [UIColor whiteColor];
        _orderNumTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入订单号查询订单" attributes:@{NSForegroundColorAttributeName:KAPP_7b7b7b_COLOR,NSFontAttributeName : KFitFont(14)}];
        _orderNumTF.clearButtonMode = UITextFieldViewModeAlways;
        _orderNumTF.font = KFitFont(14);
        _orderNumTF.textColor = KAPP_272727_COLOR;
        _orderNumTF.keyboardType = UIKeyboardTypePhonePad;
        [_orderNumTF rac_signalForControlEvents:UIControlEventEditingChanged];
    }
    return _orderNumTF;
}

- (UIButton *)beEntry{
    
    if (!_beEntry) {
        
        _beEntry = [[UIButton alloc] init];
        [_beEntry setTitle:@"已入账" forState:UIControlStateNormal];
        _beEntry.titleLabel.font = KFitFont(13);
        _beEntry.backgroundColor = KAPP_WHITE_COLOR;
        [_beEntry setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        [_beEntry setImage:[UIImage imageNamed:@"checkBox"] forState:UIControlStateNormal];
        [_beEntry setImage:[UIImage imageNamed:@"checkBox_select"] forState:UIControlStateSelected];
        _beEntry.imageEdgeInsets = UIEdgeInsetsMake(0, -10 * WIDTH_MULTIPLE , 0, 10 * WIDTH_MULTIPLE);
        [_beEntry addTarget:self action:@selector(entryBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _beEntry.selected = YES;
        _tempButton = _beEntry;
    }
    return _beEntry;
}

- (UIButton *)notEntry{
    
    if (!_notEntry) {
        
        _notEntry = [[UIButton alloc] init];
        [_notEntry setTitle:@"未入账" forState:UIControlStateNormal];
        _notEntry.titleLabel.font = KFitFont(13);
        _notEntry.backgroundColor = KAPP_WHITE_COLOR;
        [_notEntry setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        [_notEntry setImage:[UIImage imageNamed:@"checkBox"] forState:UIControlStateNormal];
        _notEntry.imageEdgeInsets = UIEdgeInsetsMake(0, -10 * WIDTH_MULTIPLE , 0, 10 * WIDTH_MULTIPLE);
        [_notEntry setImage:[UIImage imageNamed:@"checkBox_select"] forState:UIControlStateSelected];
        [_notEntry addTarget:self action:@selector(entryBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _notEntry;
}

- (UIButton *)selectBtn{
    
    if (!_selectBtn) {
        
        _selectBtn = [[UIButton alloc] init];
        [_selectBtn setTitle:@"查询" forState:UIControlStateNormal];
        _selectBtn.titleLabel.font = KFitFont(18);
        _selectBtn.backgroundColor = KAPP_THEME_COLOR;
        _selectBtn.layer.cornerRadius = 25 * WIDTH_MULTIPLE;
        _selectBtn.layer.masksToBounds = YES;
        [_selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _selectBtn;
}









- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
