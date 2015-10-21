//
//  ConfirmationIndentCell.m
//  BESTKEEP
//
//  Created by UTOUU on 15/8/19.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "ConfirmationIndentCell.h"
#import "GoodsModel.h"
#define LEFT 15
#define CELLHEIGHT 163

@implementation ConfirmationIndentCell

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
       
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 133)];
        view1.backgroundColor = COLOR_08;
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, view1.frame.origin.y+view1.frame.size.height, SCREEN_WIDTH, 30)];
        view2.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view1];
        [self.contentView addSubview:view2];
        

        //商品图片
        self.proImageView = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT, 6.5, 133-13, 133-13)];
        self.proImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.proImageView.contentMode = UIViewContentModeScaleAspectFit;
        [view1 addSubview:self.proImageView];
        
        
        
       //图片名称
        self.nameLabel = [UILabel new];
        [self initLabel:self.nameLabel Frame:CGRectZero FontSize:12 Color:COLOR_05];
        [view1 addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.proImageView.mas_right).offset(15);
            make.right.equalTo(view1.mas_right).offset(-15);
            make.top.equalTo(view1.mas_top).mas_offset(6.5);
        }];
        
        //商品尺寸
        self.sizeLabel = [UILabel new];
        [self initLabel:self.sizeLabel Frame:CGRectZero FontSize:10 Color:COLOR_05];
        [view1 addSubview:self.sizeLabel];
        [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.proImageView.mas_right).offset(15);
            make.right.equalTo(view1.mas_right).offset(-15);
            make.top.equalTo(self.nameLabel.mas_bottom).mas_offset(5);
        }];
        
        //海关税
        self.priceLabel3 = [UILabel new];
        [self initLabel:self.priceLabel3 Frame:CGRectZero FontSize:10 Color:COLOR_05];
        [view1 addSubview:self.priceLabel3];
        [self.priceLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.proImageView.mas_right).offset(15);
            make.bottom.equalTo(view1.mas_bottom).mas_offset(-6);
        }];
        
        //海关税数目
        self.numLabel3 = [UILabel new];
        [self initLabel:self.numLabel3 Frame:CGRectZero FontSize:10 Color:COLOR_06];
        [view1 addSubview:self.numLabel3];
        [self.numLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.priceLabel3.mas_right).offset(5);
            make.bottom.equalTo(view1.mas_bottom).mas_offset(-6);
        }];

        
        //实付款
        self.priceLabel2 = [UILabel new];
        [self initLabel:self.priceLabel2 Frame:CGRectZero FontSize:10 Color:COLOR_05];
        [view1 addSubview:self.priceLabel2];
        [self.priceLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.proImageView.mas_right).offset(15);
            make.bottom.equalTo(self.priceLabel3.mas_top).mas_offset(-5);
        }];
        
        //实付款数目
        self.numLabel2 = [UILabel new];
        [self initLabel:self.numLabel2 Frame:CGRectZero FontSize:10 Color:COLOR_06];
        [view1 addSubview:self.numLabel2];
        [self.numLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.priceLabel2.mas_right).offset(5);
            make.bottom.equalTo(self.priceLabel3.mas_top).mas_offset(-5);
        }];
        
        
        //有糖价
        self.priceLabel1 = [UILabel new];
        [self initLabel:self.priceLabel1 Frame:CGRectZero FontSize:10 Color:COLOR_05];
        [view1 addSubview:self.priceLabel1];
        [self.priceLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.proImageView.mas_right).offset(15);
            make.bottom.equalTo(self.priceLabel2.mas_top).mas_offset(-5);
        }];
        
        //有糖价数目
        self.numLabel1 = [UILabel new];
        [self initLabel:self.numLabel1 Frame:CGRectZero FontSize:10 Color:COLOR_06];
        [view1 addSubview:self.numLabel1];
        [self.numLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.priceLabel1.mas_right).offset(5);
            make.bottom.equalTo(self.priceLabel2.mas_top).mas_offset(-5);
        }];
        
        
        //购买数量
        self.amountLabel = [UILabel new];
        [self initLabel:self.amountLabel Frame:CGRectZero FontSize:12 Color:COLOR_05];
        [view1 addSubview:self.amountLabel];
        [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view1.mas_right).offset(-15);
            make.bottom.equalTo(view1.mas_bottom).mas_offset(-5);
        }];
        
        //合计数字
        self.totalnumLabel = [UILabel new];
        [self initLabel:self.totalnumLabel Frame:CGRectZero FontSize:12 Color:COLOR_06];
        [view2 addSubview:self.totalnumLabel];
        [self.totalnumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view2.mas_right).offset(-15);
            make.centerY.equalTo(view2.mas_centerY);
        }];
        self.totalLabel = [UILabel new];
        self.totalLabel.text = @"小计";
        [self initLabel:self.totalLabel Frame:CGRectZero FontSize:12 Color:COLOR_05];
        [view2 addSubview:self.totalLabel];
        [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.totalnumLabel.mas_left).offset(-10);
            make.centerY.equalTo(view2.mas_centerY);
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

- (void)layoutSubviews
{
       
}


-(void)setGoodsInfo:(GoodsModel *)goodsInfo{
    _goodsInfo = goodsInfo;
    [self updateData];
}

-(void)updateData{
    [self.proImageView sd_setImageWithURL:[NSURL URLWithString:self.goodsInfo.goods_img] placeholderImage:[UIImage imageNamed:@"default"]];//设置商品图片
    
    [self.nameLabel setText:self.goodsInfo.goods_name];
    [self.sizeLabel setText:self.goodsInfo.sale_property];
    [self.priceLabel1 setText:@"有糖价:"];
    [self.priceLabel2 setText:@"糖赋:"];
    NSString *tax = [NSString stringWithFormat:@"¥%@",self.goodsInfo.tax_amount];
    [self.numLabel2 setText:tax];
    NSString *member = [NSString stringWithFormat:@"¥%@",self.goodsInfo.member_price];
    [self.numLabel1 setText:member];
    
    float cums_tax = [self.goodsInfo.customs_tax_amount floatValue]/[self.goodsInfo.amount integerValue];
    
    NSString *cums = [NSString stringWithFormat:@"¥%0.2f",cums_tax];
    [self.numLabel3 setText:cums];
    [self.priceLabel3 setText:@"海关税:"];
    if([self.goodsInfo.customs_tax_amount isEqualToString:@"0.00"]){
        self.numLabel3.hidden = YES;
        self.priceLabel3.hidden = YES;
    }
    
    NSString *total_amount = [NSString stringWithFormat:@"%@%@",@"X ",self.goodsInfo.amount];
    [self.amountLabel setText:total_amount];
    NSString *total = [NSString stringWithFormat:@"¥%@",self.goodsInfo.total_amount];
    [self.totalnumLabel setText:total];

}



@end
