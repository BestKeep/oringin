//
//  OneCell.m
//  BESTKEEP
//
//  Created by YISHANG on 15/8/26.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "OneCell.h"
#define LEFT 15
#define CELLHEIGHT 243

@implementation OneCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
        self.view2.backgroundColor = COLOR_08;
        [self.contentView addSubview:self.view2];
        
        //商品图片
        self.proImageView = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT,7,130-15, 130-15)];
        [self.view2 addSubview:self.proImageView];
        
        //图片名称
        self.nameLabel = [UILabel new];
        [self initLabel:self.nameLabel Frame:CGRectZero FontSize:12 Color:COLOR_05];
        [self.view2 addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.proImageView.mas_right).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.top.equalTo(self.view2.mas_top).mas_offset(7);
        }];
        //商品尺寸
        self.sizeLabel = [UILabel new];
        [self initLabel:self.sizeLabel Frame:CGRectZero FontSize:10 Color:COLOR_05];
        [self.view2 addSubview:self.sizeLabel];
        [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.proImageView.mas_right).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.top.equalTo(self.nameLabel.mas_bottom).mas_offset(5);
        }];
        
        //实付款
        self.priceLabel2 = [UILabel new];
        [self initLabel:self.priceLabel2 Frame:CGRectZero FontSize:10 Color:COLOR_05];
        [self.view2 addSubview:self.priceLabel2];
        [self.priceLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.proImageView.mas_right).offset(15);
            make.bottom.equalTo(self.view2.mas_bottom).mas_offset(-8);
        }];
        
        //实付款数目
        self.numLabel2 = [UILabel new];
        [self initLabel:self.numLabel2 Frame:CGRectZero FontSize:10 Color:COLOR_06];
        [self.view2 addSubview:self.numLabel2];
        [self.numLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.priceLabel2.mas_right).offset(5);
            make.bottom.equalTo(self.view2.mas_bottom).mas_offset(-8);
        }];
        
        //有糖价
        self.priceLabel1 = [UILabel new];
        [self initLabel:self.priceLabel1 Frame:CGRectZero FontSize:10 Color:COLOR_05];
        [self.view2 addSubview:self.priceLabel1];
        [self.priceLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.proImageView.mas_right).offset(15);
            make.bottom.equalTo(self.priceLabel2.mas_top).mas_offset(-5);
        }];
        
        //有糖价数目
        self.numLabel1 = [UILabel new];
        [self initLabel:self.numLabel1 Frame:CGRectZero FontSize:10 Color:COLOR_06];
        [self.view2 addSubview:self.numLabel1];
        [self.numLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.priceLabel1.mas_right).offset(5);
            make.bottom.equalTo(self.priceLabel2.mas_top).mas_offset(-5);
        }];
        
        //购买数量
        self.amountLabel = [UILabel new];
        [self initLabel:self.amountLabel Frame:CGRectZero FontSize:12 Color:COLOR_05];
        [self.view2 addSubview:self.amountLabel];
        [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.bottom.equalTo(self.view2.mas_bottom).mas_offset(-8);
        }];

        
    }
    return self;
}
-(void)initLabel:(UILabel*)textLabel Frame:(CGRect)frame FontSize:(CGFloat)size Color:(UIColor*)color {
    textLabel.frame = frame;
    textLabel.font = [UIFont boldSystemFontOfSize:size];
    textLabel.numberOfLines = 0;
    textLabel.textColor = color;
    [textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
}

-(void)setGoodsInfo:(GoodsModel *)goodsInfo{
    _goodsInfo = goodsInfo;
    [self updateGoodsInfo];
    
}

-(void)updateGoodsInfo{
    [self.proImageView sd_setImageWithURL:[NSURL URLWithString:self.goodsInfo.goods_img] placeholderImage:[UIImage imageNamed:@"default"]];
    self.nameLabel.text = self.goodsInfo.goods_name;
    self.sizeLabel.text = self.goodsInfo.sale_property;
    self.priceLabel1.text = @"有糖价";
    self.priceLabel2.text = @"实付款";
    self.numLabel1.text = [NSString stringWithFormat:@"¥%@",self.goodsInfo.member_price];
    self.numLabel2.text = [NSString stringWithFormat:@"¥%@",self.goodsInfo.total_amount];
    NSString *total_amount = [NSString stringWithFormat:@"%@%@",@"X ",self.goodsInfo.amount];
    self.amountLabel.text = total_amount;
    
}




@end
