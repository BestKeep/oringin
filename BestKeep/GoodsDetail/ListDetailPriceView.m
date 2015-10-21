//
//  ListDetailPriceView.m
//  
//
//  Created by UTOUU on 15/9/21.
//
//

#import "ListDetailPriceView.h"
#import "Masonry.h"
#define RgbColor(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]


@implementation ListDetailPriceView

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
        _VIPPrice.text = @"￥269.00";
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
        _marketPrice.text = @"￥800.00";
        [self.contentView addSubview:_marketPrice];
        
        
        _line2 = [UILabel new];
        _line2.backgroundColor = [UIColor grayColor];
        _line2.alpha = 0.5;
        [self.contentView addSubview:_line2];
        
        
        _tangLabel = [UILabel new];
        _tangLabel.font = [UIFont systemFontOfSize:14.0];
        _tangLabel.textColor = [UIColor grayColor];
        _tangLabel.backgroundColor = [UIColor whiteColor];
        _tangLabel.text = @"糖赋: 50%";
        [self.contentView addSubview:_tangLabel];

        
        _adressLabel = [UILabel new];
        _adressLabel.font = [UIFont systemFontOfSize:14.0];
        _adressLabel.textColor = [UIColor grayColor];
        _adressLabel.backgroundColor = [UIColor whiteColor];
        _adressLabel.text = @"发货地: 上海市(预计15~30天发货)";
        [self.contentView addSubview:_adressLabel];
        
        
        _footerView = [UIView new];
        _footerView.backgroundColor = RgbColor(239 , 239, 239);
        [self.contentView addSubview:_footerView];
        
        
        _jiangImage = [UILabel new];
        _jiangImage.backgroundColor = RGB(44, 179, 138);
        _jiangImage.text = @"奖";
        _jiangImage.layer.masksToBounds = YES;
        _jiangImage.font = [UIFont boldSystemFontOfSize:14];
        _jiangImage.textColor = [UIColor whiteColor];
        _jiangImage.textAlignment = NSTextAlignmentCenter;
        _jiangImage.layer.cornerRadius = 3.0f;
        [_footerView addSubview:_jiangImage];
       
        _dataLabel = [UILabel new];
        _dataLabel.textColor = RGB(44, 179, 138);
        //_dataLabel.text = @"26";
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
        
        [_adressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(10);
            make.top.mas_equalTo(_tangLabel.mas_bottom).offset(5);
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
    
//    self.adressLabel.text = [NSString stringWithFormat:@"发货地: %@(预计%@~%@天发货)",_goodsModel.goodsDTO.deliverAddressName,_goodsModel.goodsDTO.deliverBeginDays,_goodsModel.goodsDTO.deliverEndDays];
    NSString *gong = [NSString stringWithFormat:@"%.2f",[_goodsModel.goodsDTO.taxAmount doubleValue]/100];
    self.dataLabel.text = [NSString stringWithFormat:@"%@",gong];
    
}
@end
