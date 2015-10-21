//
//  ListDetailPriceViewBuyEarth.m
//  
//
//  Created by UTOUU on 15/10/16.
//
//

#import "ListDetailPriceViewBuyEarth.h"
#import "Masonry.h"
#define RgbColor(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@implementation ListDetailPriceViewBuyEarth

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        self.backgroundColor = [UIColor whiteColor];
        
        _headLabel = [UILabel new];
        _headLabel.textColor = [UIColor blackColor];
        _headLabel.font = [UIFont systemFontOfSize:14.0];
        _headLabel.numberOfLines = 0;
        _headLabel.backgroundColor = [UIColor whiteColor];
        _headLabel.text = @"----";
        [self.contentView addSubview:_headLabel];
        
        
        _line1 = [UILabel new];
        _line1.backgroundColor = [UIColor grayColor];
        _line1.alpha = 0.4;
        [self.contentView addSubview:_line1];
        
        
        _VIPLabel = [UILabel new];
        _VIPLabel.backgroundColor = [UIColor whiteColor];
        _VIPLabel.textColor = [UIColor grayColor];
        _VIPLabel.font = [UIFont systemFontOfSize:12.0];
        _VIPLabel.text = @"会员价:";
        [self.contentView addSubview:_VIPLabel];
        
        
        _VIPPrice = [UILabel new];
        _VIPPrice.textColor = [UIColor redColor];
        _VIPPrice.text = @"￥0.00";
        _VIPPrice.font = [UIFont systemFontOfSize:16.0];
        _VIPPrice.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_VIPPrice];
        
        
        _marketLabel = [UILabel new];
        _marketLabel.backgroundColor = [UIColor whiteColor];
        _marketLabel.textColor = [UIColor grayColor];
        _marketLabel.font = [UIFont systemFontOfSize:12.0];
        _marketLabel.text = @"市场价:";
        [self.contentView addSubview:_marketLabel];
        
        
        _marketPrice = [UILabel new];
        _marketPrice.backgroundColor = [UIColor whiteColor];
        _marketPrice.textColor = [UIColor grayColor];
        _marketPrice.font = [UIFont systemFontOfSize:12.0];
        _marketPrice.text = @"￥0.00";
        [self.contentView addSubview:_marketPrice];
        
        
        _line2 = [UILabel new];
        _line2.backgroundColor = [UIColor grayColor];
        _line2.alpha = 0.5;
        [self.contentView addSubview:_line2];
        
        
        _tangLabel = [UILabel new];
        _tangLabel.font = [UIFont systemFontOfSize:14.0];
        _tangLabel.textColor = [UIColor grayColor];
        _tangLabel.backgroundColor = [UIColor whiteColor];
        _tangLabel.text = @"糖赋: --- ";
        [self.contentView addSubview:_tangLabel];
        
        _haiguan = [UILabel new];
        _haiguan.font = [UIFont systemFontOfSize:14.0];
        _haiguan.textColor = [UIColor grayColor];
        _haiguan.backgroundColor = [UIColor whiteColor];
        _haiguan.text = @"海关税费:￥---";
        [self.contentView addSubview:_haiguan];
        
        _mianLabel = [UILabel new];
        _mianLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _mianLabel.textColor = [UIColor whiteColor];
        _mianLabel.backgroundColor = [UIColor redColor];
        _mianLabel.text = @"免";
        _mianLabel.layer.masksToBounds = YES;
        _mianLabel.textAlignment = NSTextAlignmentCenter;
        _mianLabel.layer.cornerRadius = 3.0;
        [self.contentView addSubview:_mianLabel];
        
        _mianzheng = [UILabel new];
        _mianzheng.font = [UIFont systemFontOfSize:14.0];
        _mianzheng.textColor = [UIColor grayColor];
        _mianzheng.backgroundColor = [UIColor whiteColor];
        _mianzheng.text = @" 税费≤50元免征";
        [self.contentView addSubview:_mianzheng];
        
        _adressLabel = [UILabel new];
        _adressLabel.font = [UIFont systemFontOfSize:14.0];
        _adressLabel.textColor = [UIColor grayColor];
        _adressLabel.backgroundColor = [UIColor whiteColor];
        _adressLabel.text = @"发货地: --- ";
        [self.contentView addSubview:_adressLabel];
        
        
        _redLabel = [UILabel new];
        _redLabel.font = [UIFont boldSystemFontOfSize:12.0];
        _redLabel.textColor = [UIColor whiteColor];
        _redLabel.backgroundColor = [UIColor redColor];
        _redLabel.text = @"同种商品一天限购4单";
        _redLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_redLabel];
        
        _detailLabel = [UILabel new];
        _detailLabel.font = [UIFont systemFontOfSize:10.0];
        _detailLabel.textColor = [UIColor blackColor];
        _detailLabel.backgroundColor = [UIColor whiteColor];
        _detailLabel.numberOfLines = 0;
        _detailLabel.attributedText = [self myString];
        [self.contentView addSubview:_detailLabel];
        
        _footerView = [UIView new];
        _footerView.backgroundColor = RgbColor(239 , 239, 239);
        [self.contentView addSubview:_footerView];
        
        
        _jiangImage = [UILabel new];
        _jiangImage.backgroundColor = RGB(44, 179, 138);
        _jiangImage.text = @"奖";
        _jiangImage.font = [UIFont boldSystemFontOfSize:14];
        _jiangImage.textColor = [UIColor whiteColor];
        _jiangImage.textAlignment = NSTextAlignmentCenter;
        _jiangImage.layer.cornerRadius = 3.0f;
        _jiangImage.layer.masksToBounds = YES;
        [_footerView addSubview:_jiangImage];
        
        _dataLabel = [UILabel new];
        _dataLabel.textColor = COLOR_14;
        _dataLabel.text = @" --- ";
        _dataLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _dataLabel.backgroundColor = [UIColor clearColor];
        [_footerView addSubview:_dataLabel];
        
        
        _gongxianzhiLabel = [UILabel new];
        _gongxianzhiLabel.textColor = COLOR_05;
        _gongxianzhiLabel.text = @"贡献值";
        _gongxianzhiLabel.font = [UIFont systemFontOfSize:14.0];
        _gongxianzhiLabel.backgroundColor = [UIColor clearColor];
        [_footerView addSubview:_gongxianzhiLabel];
        
        [_headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
            make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        }];
        
        [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).offset(0);
            make.top.mas_equalTo(_headLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(@(1));
        }];
        
        [_VIPLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(10);
            make.top.mas_equalTo(_line1.mas_bottom).offset(5);
        }];
        
        [_VIPPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_VIPLabel.mas_right).offset(5);
            make.centerY.mas_equalTo(_VIPLabel.mas_centerY).offset(0);
        }];
        
        [_marketLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(10);
            make.top.mas_equalTo(_VIPLabel.mas_bottom).offset(5);
        }];
        
        [_marketPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_marketLabel.mas_right).offset(5);
            make.centerY.mas_equalTo(_marketLabel.mas_centerY).offset(0);
        }];
        
        [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_marketPrice.mas_left);
            make.right.mas_equalTo(_marketPrice.mas_right);
            make.centerY.mas_equalTo(_marketPrice.mas_centerY);
            make.height.mas_equalTo(@(1));
        }];
        
        [_tangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(10);
            make.top.mas_equalTo(_marketLabel.mas_bottom).offset(5);
        }];
        
        [_haiguan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(10);
            make.top.mas_equalTo(_tangLabel.mas_bottom).offset(5);
        }];
        
        [_mianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_haiguan.mas_right).offset(5);
            make.centerY.mas_equalTo(_haiguan.mas_centerY);
            make.width.mas_equalTo(@(17));
            make.height.mas_equalTo(@(17));
        }];
        
        [_mianzheng mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_mianLabel.mas_right).offset(5);
            make.centerY.mas_equalTo(_haiguan.mas_centerY);
        }];
        
        [_adressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(10);
            make.top.mas_equalTo(_haiguan.mas_bottom).offset(5);
        }];
        
        [_redLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
            make.top.mas_equalTo(_adressLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(@(20));
        }];
        
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
            make.top.mas_equalTo(_redLabel.mas_bottom).offset(5);
        }];
        
        
        [_footerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left);
            make.right.mas_equalTo(self.contentView.mas_right);
            make.height.mas_equalTo(@(35));
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
        }];
        
        [_jiangImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_footerView.mas_left).offset(10);
            make.centerY.mas_equalTo(_footerView.mas_centerY);
            make.height.mas_equalTo(@(20));
            make.width.mas_equalTo(@(20));
        }];
        
        [_dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_jiangImage.mas_right).offset(2);
            make.centerY.mas_equalTo(_footerView.mas_centerY);
        }];
        
        [_gongxianzhiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_dataLabel.mas_right);
            make.centerY.mas_equalTo(_footerView.mas_centerY);
        }];
        
    }
    return self;
}
-(void)setGoodsModel:(GoodsDataModel *)goodsModel{
    _goodsModel = goodsModel;
    [self updateData];
}
-(void)updateData{
    self.headLabel.text = _goodsModel.goodsDTO.goodsName;
    self.VIPPrice.text = [NSString stringWithFormat:@"¥ %.2f", [_goodsModel.goodsDTO.goodsRealPrice floatValue]];
    self.marketPrice.text = [NSString stringWithFormat:@"¥ %.2f", [_goodsModel.goodsDTO.goodsMarketPrice floatValue]];
    self.tangLabel.text = [NSString stringWithFormat:@"糖赋: ¥ %.0f",floor([_goodsModel.goodsDTO.taxAmount doubleValue])];
    self.adressLabel.text = [NSString stringWithFormat:@"发货地: %@",_goodsModel.goodsDTO.deliverAddressName];//@"海关税费:￥---  税费≤50元免征"
    self.haiguan.text = [NSString stringWithFormat:@"海关税费:￥%@",_goodsModel.goodsDTO.linePostTaxRatioAmount];
    NSString *gong = [NSString stringWithFormat:@"%.2f",[_goodsModel.goodsDTO.taxAmount doubleValue]/100];
    self.dataLabel.text = [NSString stringWithFormat:@"%@",gong];
    
}
- (NSAttributedString*)myString
{
    NSString* allMoney = @"单笔订单应征税额在人民币50元(含50元)以下的,海关予以免征.";
    NSString * account = [NSString stringWithFormat:@"BestKeep所售商品是宁波跨境贸易电子商务进口商品,依据《中华人民共和国进境物品归类表》的税率,以实际成交价格,计算进境物品进口税税额,税额由消费者支付给商家,商家统一代收代缴,消费者委托商家向海关申报.%@",allMoney];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:account] ;
    NSRange detail  = [account rangeOfString:[NSString stringWithFormat:@"%@",allMoney]];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:detail];
    return attributedString;
}

@end
