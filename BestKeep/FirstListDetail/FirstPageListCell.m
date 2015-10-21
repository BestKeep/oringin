//
//  FirstPageListCell.m
//  UTOUU_TEST
//
//  Created by UTOUU on 15/9/7.
//  Copyright (c) 2015年 UTOUU. All rights reserved.
//

#import "FirstPageListCell.h"
#import "Masonry.h"
#import "GoodsModel.h"
#import "UIImageView+WebCache.h"
#define RgbColor(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

//#define Image_Height_Width_Ratio    480.0/410.0

@interface FirstPageListCell ()
@property(nonatomic , strong)UIImageView* listImageView;
@property(nonatomic , strong)UIImageView* littleImageView;
@property(nonatomic , strong)UILabel* listTitleLabel;
@property(nonatomic , strong)UILabel* listVIPPrice;
@property(nonatomic , strong)UILabel* listLostPrice;
@property(nonatomic , strong)UIButton* listShareBtn;
@property(nonatomic , strong)UILabel* tangLabel;

@property(nonatomic , strong)UILabel* huiyuanjia;
@property(nonatomic , strong)UILabel* shichangjia;
@property(nonatomic , strong)UILabel* henxian;

@end


@implementation FirstPageListCell

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
        self.backgroundColor = [UIColor clearColor];
        self.coustomContentView.backgroundColor = [UIColor whiteColor];
        self.bottomMargin = 7;
        UIView * imageBackView = [[UIView alloc] init];
        imageBackView.backgroundColor = [UIColor lightGrayColor];
        _listImageView = [[UIImageView alloc] init];
        [self.coustomContentView addSubview:imageBackView];
        imageBackView.clipsToBounds = YES;
        [imageBackView addSubview:_listImageView];
        
        _littleImageView = [[UIImageView alloc] init];
        _littleImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.coustomContentView addSubview:_littleImageView];
        
        _listTitleLabel = [UILabel new];
        _listTitleLabel.font = [UIFont systemFontOfSize:16.0];
        _listTitleLabel.backgroundColor = [UIColor whiteColor];
        _listTitleLabel.text = @"---";
        _listTitleLabel.textColor = [UIColor blackColor];
        [self.coustomContentView addSubview:_listTitleLabel];
        
        _huiyuanjia = [UILabel new];
        _huiyuanjia.font = [UIFont systemFontOfSize:13.0];
        _huiyuanjia.textColor = [UIColor grayColor];
        _huiyuanjia.text = @"会员价:";
        [self.coustomContentView addSubview:_huiyuanjia];
        
        _listVIPPrice = [UILabel new];
        _listVIPPrice.font = [UIFont systemFontOfSize:16.0];
        _listVIPPrice.backgroundColor = [UIColor whiteColor];
        _listVIPPrice.textColor = [UIColor orangeColor];
        _listVIPPrice.text = @"￥0.00";
        [self.coustomContentView addSubview:_listVIPPrice];
        
        _shichangjia = [UILabel new];
        _shichangjia.font = [UIFont systemFontOfSize:13.0];
        _shichangjia.textColor = [UIColor grayColor];
        _shichangjia.text = @"市场价:";
        [self.coustomContentView addSubview:_shichangjia];
        
        _listLostPrice = [UILabel new];
        _listLostPrice.font = [UIFont systemFontOfSize:13.0];
        _listLostPrice.backgroundColor = [UIColor whiteColor];
        _listLostPrice.textColor = [UIColor grayColor];
        _listLostPrice.text = @"￥0.00";
        [self.coustomContentView addSubview:_listLostPrice];
        
        _henxian = [UILabel new];
        _henxian.backgroundColor = [UIColor grayColor];
        _henxian.alpha = 0.5;
        [self.coustomContentView addSubview:_henxian];
        
        _listShareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_listShareBtn setBackgroundImage:[UIImage imageNamed:@"share_four"] forState:UIControlStateNormal];
        [self.coustomContentView addSubview:_listShareBtn];
        [_listShareBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        _tangLabel = [UILabel new];
        _tangLabel.font = [UIFont systemFontOfSize:14.0];
        _tangLabel.textColor = [UIColor grayColor];
        _tangLabel.backgroundColor = [UIColor whiteColor];
        [self.coustomContentView addSubview:_tangLabel];
        
    
        UIButton * sizeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sizeButton.backgroundColor = [UIColor clearColor];
        [self.coustomContentView addSubview:sizeButton];
        [sizeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.coustomContentView.mas_left).offset(0);
            make.width.mas_equalTo(@(150));
            make.top.mas_equalTo(self.coustomContentView.mas_top).offset(0);
            make.bottom.mas_equalTo(self.coustomContentView.mas_bottom).offset(0);
        }];
    
        [_listImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(imageBackView.mas_centerX);
            make.centerY.equalTo(imageBackView.mas_centerY);
            make.width.equalTo(@(150.0));
            make.height.equalTo(@(150.0*88/41));
        }];
        
        [_littleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(imageBackView.mas_right).offset(0);
            make.width.mas_equalTo(@(56));
            make.top.mas_equalTo(imageBackView.mas_top).offset(0);
            make.height.mas_equalTo(@(56));
        }];
        
        [_listTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageBackView.mas_right).offset(10);
            make.right.mas_equalTo(self.coustomContentView.mas_right).offset(-10);
            make.top.mas_equalTo(self.coustomContentView.mas_top).offset(10);
        }];
        
        [_huiyuanjia mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageBackView.mas_right).offset(10);
            make.top.mas_equalTo(_listTitleLabel.mas_bottom).offset(10);
        }];
        
        [_listVIPPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_huiyuanjia.mas_right).offset(2);
            make.centerY.mas_equalTo(_huiyuanjia.mas_centerY);
        }];
        
        [_shichangjia mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageBackView.mas_right).offset(10);
            make.top.mas_equalTo(_huiyuanjia.mas_bottom).offset(5);
        }];
        
        [_listLostPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_huiyuanjia.mas_right).offset(2);
            make.centerY.mas_equalTo(_shichangjia.mas_centerY);
        }];
        
        [_henxian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_listLostPrice.mas_left).offset(0);
            make.centerY.mas_equalTo(_listLostPrice.mas_centerY);
            make.height.mas_equalTo(@(1));
            make.width.mas_equalTo(_listLostPrice.mas_width);
        }];
        
        [_tangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageBackView.mas_right).offset(10);
            make.top.mas_equalTo(_shichangjia.mas_bottom).offset(10);
        }];
        
        [_listShareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.coustomContentView.mas_right).offset(-10);
            make.bottom.mas_equalTo(self.coustomContentView.mas_bottom).offset(-10);
            make.width.mas_equalTo(@(17));
            make.height.mas_equalTo(@(17));
        }];
        
        [sizeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_listShareBtn.mas_centerX);
            make.centerY.equalTo(_listShareBtn.mas_centerY);
            make.width.equalTo(@(40));
            make.height.equalTo(@(40));
        }];
    }
    return self;
}

-(void)setGoodsModel:(GoodsModel *)goodsModel{
    _goodsModel = goodsModel;
    [self updateData];
}

-(void)updateData{

    self.listTitleLabel.text = self.goodsModel.goods_name;
    self.listVIPPrice.text = [NSString stringWithFormat:@"¥ %.2f",[self.goodsModel.member_price floatValue]];
    self.listLostPrice.text = [NSString stringWithFormat:@"¥ %.2f",[self.goodsModel.market_price floatValue]];
    //CGFloat tax = [self.goodsModel.tax floatValue];
   // self.tangLabel.text = [NSString stringWithFormat:@"糖赋: %0.1f%@",tax*100,@"%"];
    
    
    __weak typeof(self)wSelf = self;
    [self.listImageView sd_setImageWithURL:[NSURL URLWithString:self.goodsModel.goods_image] placeholderImage:[UIImage imageNamed:@"default.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        __block CGFloat ratio = image.size.height/image.size.width;
        if (ratio<1) {
            [wSelf.listImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(150));
                make.width.equalTo(@(150/ratio));
            }];
        }else{
            [wSelf.listImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(150*ratio));
                make.width.equalTo(@(150));
            }];
        }
        
    }];
    switch (self.goodsModel.goodsStatu) {
        case GoodsStatuIconHasGoods:
            _littleImageView.image = [UIImage imageNamed:@"icon_purchase_goods"];
            break;
            case GoodsStatuIconNoIcon:
//            _listImageView.image = [UIImage imageNamed:nil];
            break;
            case GoodsStatuIconNoSale:
            _littleImageView.image = [UIImage imageNamed:@"icon_no_buy"];
            break;
            case GoodsStatuIconNoGoods:
            _littleImageView.image = [UIImage imageNamed:@"icon_no_goods"];
            break;
            case GoodsStatuIconpurchase:
            _littleImageView.image = [UIImage imageNamed:@"icon_purchase_goods"];
            break;
            
        default:
            break;
    }
}


-(CGFloat)cellHeightWithModel:(GoodsModel *)model{

    return 150+self.bottomMargin;
}


-(void)buttonClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(firstPageListCell:action:)]) {
        [self.delegate firstPageListCell:self action:FirstPageListCellActionShare];
    }
}



@end
