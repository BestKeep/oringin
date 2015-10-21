//
//  ListDetailBuyView.m
//  
//
//  Created by UTOUU on 15/9/21.
//
//

#import "ListDetailBuyView.h"
#import "Masonry.h"
#define RgbColor(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]



@implementation ListDetailBuyView  //弹出视图的商品展示头部
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
//        self.backgroundColor = [UIColor blackColor];
//        self.alpha = 0.4;
 
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
        
        _detailImageView = [UIImageView new];
        _detailImageView.layer.borderWidth = 1.0;
        _detailImageView.layer.borderColor = COLOR_05.CGColor;
        _detailImageView.backgroundColor = [UIColor whiteColor];
        _detailImageView.contentMode = UIViewContentModeScaleAspectFit ;
        [_bgView addSubview:_detailImageView];
        
        _priceLabel = [UILabel new];
        _priceLabel.font = [UIFont boldSystemFontOfSize:20.0];
        _priceLabel.textColor = [UIColor orangeColor];
        
        _priceLabel.backgroundColor = [UIColor whiteColor];
        [_bgView addSubview:_priceLabel];
        
        _saveLabel = [UILabel new];
        _saveLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _saveLabel.textColor = COLOR_05;
        _saveLabel.backgroundColor = [UIColor whiteColor];
       
        [_bgView addSubview:_saveLabel];
        
        _colorLabel = [UILabel new];
        _colorLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _colorLabel.textColor = COLOR_05;
        _colorLabel.numberOfLines = 0;
        _colorLabel.backgroundColor = [UIColor whiteColor];
       
        _priceLabel.numberOfLines = 0;
        [_bgView addSubview:_colorLabel];
        
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.layer.borderWidth = 1.0;
        _cancelBtn.layer.borderColor = COLOR_07.CGColor;
        _cancelBtn.layer.cornerRadius = 15.0;
        _cancelBtn.layer.masksToBounds = YES;
        [_cancelBtn setTitle:@"X" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:COLOR_07 forState:UIControlStateNormal];
        [_cancelBtn setBackgroundColor:[UIColor whiteColor]];
        _cancelBtn.alpha = 1.0;
        [_bgView addSubview:_cancelBtn];

        _line = [UILabel new];
        _line.backgroundColor = [UIColor grayColor];
        _line.alpha = 0.4;
        //_line.hidden = YES;
        [_bgView addSubview:_line];
        
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.top.mas_equalTo(self.mas_top).offset(100);
        }];

        [_detailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_bgView.mas_left).offset(10);
            make.width.mas_equalTo(@(113));
            make.height.mas_equalTo(@(113));
            make.top.mas_equalTo(_bgView.mas_top).offset(-22);
        }];
        
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_detailImageView.mas_right).offset(12);
            make.top.mas_equalTo(_bgView.mas_top).offset(20);
        }];
        
        [_saveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_detailImageView.mas_right).offset(12);
            make.top.mas_equalTo(_priceLabel.mas_bottom).offset(9);
        }];
        
        [_colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_detailImageView.mas_right).offset(12);
            make.right.mas_equalTo(self.mas_right).offset(-10);
            make.top.mas_equalTo(_saveLabel.mas_bottom).offset(4);
        }];
        
        [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_bgView.mas_right).offset(-10);
            make.top.mas_equalTo(_bgView.mas_top).offset(10);
            make.height.mas_equalTo(@(30));
            make.width.mas_equalTo(@(30));
        }];
        
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_bgView.mas_left).offset(10);
            make.right.mas_equalTo(_bgView.mas_right);
            make.height.mas_equalTo(@(1));
            make.top.mas_equalTo(_detailImageView.mas_bottom).offset(35);
        }];
        
        }
    return self;
}
-(void)setGoodsDataModel:(GoodsDataModel *)goodsDataModel{
    _goodsDataModel = goodsDataModel;
    [self updataGoodsInfo];
}
-(void)updataGoodsInfo{
    NSArray *imgArray = self.goodsDataModel.imgList;
    for (ImgList *temp_imglist in imgArray) {
        if ([temp_imglist.imageType isEqualToString:@"3"]) {
            [_detailImageView sd_setImageWithURL:[NSURL URLWithString:temp_imglist.imageUrl] placeholderImage:[UIImage imageNamed:@"default"]];
        }
    }
    _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[self.goodsDataModel.goodsDTO.goodsRealPrice floatValue]];
    if ([self.ready_buy isEqualToString:@"3"]) {
        if (![self.goodsDataModel.amount isEqualToString:@"0"]) {
           _saveLabel.text = [NSString stringWithFormat:@"%@%@%@",@"库存 ",self.goodsDataModel.amount,@" 件"];
            _reservice = self.goodsDataModel.amount;
        }else if(![self.goodsDataModel.saleReserveAmount isEqualToString:@"0"] ){
            _saveLabel.text = [NSString stringWithFormat:@"%@%@%@",@"库存 ",self.goodsDataModel.saleReserveAmount,@" 件"];
             _reservice = self.goodsDataModel.saleReserveAmount;
        }else{
            _saveLabel.text = [NSString stringWithFormat:@"%@%@%@",@"库存 ",@"0",@" 件"];
            _reservice = @"0";
        }
    }else{
        if (![self.goodsDataModel.amount isEqualToString:@"0"]) {
            _saveLabel.text = [NSString stringWithFormat:@"%@%@%@",@"库存 ",self.goodsDataModel.amount,@" 件"];
            _reservice = self.goodsDataModel.amount;
        }else if(![self.goodsDataModel.saleReserveAmount isEqualToString:@"0"] ){
            _saveLabel.text = [NSString stringWithFormat:@"%@%@%@",@"库存 ",self.goodsDataModel.saleReserveAmount,@" 件"];
            _reservice = self.goodsDataModel.saleReserveAmount;
        }else{
            _saveLabel.text = [NSString stringWithFormat:@"%@%@%@",@"库存 ",@"0",@" 件"];
            _reservice = @"0";
        }
    }
}
@end
