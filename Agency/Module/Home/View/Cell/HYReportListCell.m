//
//  HYReportListCell.m
//  Agency
//
//  Created by 胡勇 on 2017/11/13.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYReportListCell.h"

@interface HYReportListCell ()

@property (nonatomic,strong) UIImageView *headerImgView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UIButton *drawDownBtn;
@property (nonatomic,strong) UIView *bottomLine;

@property (nonatomic,strong) HYReportCellViewModel *viewModel;

@end

@implementation HYReportListCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.headerImgView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.drawDownBtn];
    [self addSubview:self.bottomLine];
}

- (void)layoutSubviews{
    
    [_headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(40 * WIDTH_MULTIPLE, 40 * WIDTH_MULTIPLE));
    }];
    
    [_drawDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(70 * WIDTH_MULTIPLE, 25 * WIDTH_MULTIPLE));
        make.centerY.equalTo(self);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(_drawDownBtn.mas_left).offset(-18 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(70 * WIDTH_MULTIPLE, 25 * WIDTH_MULTIPLE));
        make.centerY.equalTo(self);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_headerImgView);
        make.left.equalTo(_headerImgView.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.right.equalTo(_priceLabel.mas_left).offset(-10 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(_headerImgView);
        make.left.height.right.equalTo(_titleLabel);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - setViewModel
- (void)setWithViewModel:(HYReportCellViewModel *)viewModel{
    
    
    viewModel.cellIndexPath = self.indexPath;
    self.viewModel = viewModel;
    
    RAC(self.titleLabel,text) = RACObserve(viewModel, title);
    RAC(self,timeLabel.text) = RACObserve(viewModel, timeStr);
    RAC(self,priceLabel.text) = [RACObserve(viewModel, price) map:^id(id value) {
        
        return [NSString stringWithFormat:@"￥%@",value];
    }];
    [RACObserve(viewModel,headImageUrl) subscribeNext:^(NSString *headImgUrlStr) {
        
        [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:headImgUrlStr] placeholderImage:[UIImage imageNamed:@"header"]];
    }];

    [RACObserve(viewModel, state) subscribeNext:^(id x) {
       
        if ([x boolValue]) {
            
            [self.drawDownBtn setTitle:@"已领取" forState:UIControlStateNormal];
            self.drawDownBtn.enabled = NO;
        }
        else{
            
            [self.drawDownBtn setTitle:@"领取" forState:UIControlStateNormal];
        }
        DLog(@"%@",x);
    }];
}

#pragma mark - action
- (void)drawDownBtnAction{
    
    if (!self.viewModel.state) {
        
        [self.viewModel drawDownTheReport];
    }
}

#pragma mark - lazyload
- (UIImageView *)headerImgView{
    
    if (!_headerImgView) {
        
        _headerImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header"]];
        _headerImgView.contentMode = UIViewContentModeScaleAspectFill;
        _headerImgView.layer.cornerRadius = 20 * WIDTH_MULTIPLE;
        _headerImgView.clipsToBounds = YES;
    }
    return _headerImgView;
}

- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KFitFont(14);
        _titleLabel.textColor = KAPP_272727_COLOR;
        _titleLabel.text = @"万历十五年";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UILabel *)timeLabel{
    
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = KFitFont(13);
        _timeLabel.textColor = KAPP_b7b7b7_COLOR;
        _timeLabel.text = @"万历十五年";
        _timeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _timeLabel;
}

- (UILabel *)priceLabel{
    
    if (!_priceLabel) {
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = KFitFont(16);
        _priceLabel.textColor = KAPP_PRICE_COLOR;
        _priceLabel.text = @"￥12306";
        _priceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _priceLabel;
}

- (UIButton *)drawDownBtn{
    
    if (!_drawDownBtn) {
        
        _drawDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_drawDownBtn setBackgroundImage:[UIImage imageNamed:@"btn_yellow_bg"] forState:UIControlStateNormal];
        [_drawDownBtn setTitle:@"领取" forState:UIControlStateNormal];
        [_drawDownBtn setTitleColor:KAPP_WHITE_COLOR forState:UIControlStateNormal];
        _drawDownBtn.layer.cornerRadius = 3 * WIDTH_MULTIPLE;
        _drawDownBtn.layer.masksToBounds = YES;
        _drawDownBtn.titleLabel.font = KFitFont(16);
        [_drawDownBtn addTarget:self action:@selector(drawDownBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _drawDownBtn;
}


- (UIView *)bottomLine{
    
    if (!_bottomLine) {
        
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _bottomLine;
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
