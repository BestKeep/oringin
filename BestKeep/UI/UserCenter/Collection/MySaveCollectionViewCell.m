//
//  MySaveCollectionViewCell.m
//  BESTKEEP
//
//  Created by UTOUU on 15/8/26.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "MySaveCollectionViewCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#define RgbColor(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@interface MySaveCollectionViewCell ()

@property (nonatomic,strong) CollectionGoodsModel * cellModel;
@property (nonatomic,strong) UIImageView * goodsStatuIcon;

@end

@implementation MySaveCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _imageView1 = [[UIImageView alloc] init];
        _imageView1.backgroundColor = COLOR_08;
        _imageView1.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imageView1];
        
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button1 setBackgroundColor:[UIColor clearColor]];
        _button1.layer.cornerRadius = 12.5;
        _button1.layer.borderWidth = 0.0;
        _button1.layer.masksToBounds = YES;
        _button1.layer.borderColor = [UIColor grayColor].CGColor;
        [_button1 setBackgroundImage:[UIImage imageNamed:@"select_image.png"] forState:UIControlStateSelected];
        [_button1 setBackgroundImage:[UIImage imageNamed:@"unselect_image.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:_button1];
        
        [_button1 addTarget:self action:@selector(selectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        _label1 = [UILabel new];
        [_label1 setText:@"---"];
        [_label1 setFont:[UIFont boldSystemFontOfSize:15.0]];
        [_label1 setBackgroundColor:[UIColor whiteColor]];
        [_label1 setTextColor:RgbColor(48, 54, 69)];
        [self.contentView addSubview:_label1];
        
        _label2 = [UILabel new];
        [_label2 setText:@"￥--元"];
        [_label2 setFont:[UIFont boldSystemFontOfSize:15.0]];
        [_label2 setBackgroundColor:[UIColor whiteColor]];
        [_label2 setTextColor:RgbColor(48, 54, 69)];
        [self.contentView addSubview:_label2];
        

        _goodsStatuIcon = [[UIImageView alloc] init];
        _goodsStatuIcon.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_goodsStatuIcon];
        
        [_imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left);
            make.right.mas_equalTo(self.contentView.mas_right);
            make.top.mas_equalTo(self.contentView.mas_top);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-50);
        }];
        
        [_button1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(10);
            make.width.mas_equalTo(@(25));
            make.top.mas_equalTo(self.contentView.mas_top).offset(10);
            make.height.mas_equalTo(@(25));
        }];
        
        [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
            make.top.mas_equalTo(_imageView1.mas_bottom).offset(4);
        }];
        
        [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(10);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(- 4);
        }];
        
        [_goodsStatuIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).offset(0);
            make.width.mas_equalTo(@(56));
            make.top.mas_equalTo(self.contentView.mas_top).offset(0);
            make.height.mas_equalTo(@(56));
        }];
        
    }
    return self;
}

-(void)selectionButtonClick:(UIButton *)selectedButton{
    selectedButton.selected = !selectedButton.selected;
    self.cellModel.isSelected = selectedButton.selected;
    if ([self
        .mysaveCollectionDelegate respondsToSelector:@selector(mySaveCollectionView:selectedButton:)]) {
        [self.mysaveCollectionDelegate mySaveCollectionView:self selectedButton:selectedButton];
    }
}

-(void)updateCellContentViewWithModel:(CollectionGoodsModel *)goodModel{
    self.cellModel = goodModel;
    [_label1 setText:goodModel.goods_name];
    [_label2 setText:[NSString stringWithFormat:@"￥%@元",goodModel.member_price]];
    [_imageView1 sd_setImageWithURL:[NSURL URLWithString:goodModel.goods_img_small] placeholderImage:nil];
    switch (self.cellModel.goodsStatu) {
        case GoodsStatuIconHasGoods:
            _goodsStatuIcon.image = [UIImage imageNamed:@"icon_purchase_goods"];
            break;
        case GoodsStatuIconNoIcon:
            //            _listImageView.image = [UIImage imageNamed:nil];
            break;
        case GoodsStatuIconNoSale:
            _goodsStatuIcon.image = [UIImage imageNamed:@"icon_no_buy"];
            break;
        case GoodsStatuIconNoGoods:
            _goodsStatuIcon.image = [UIImage imageNamed:@"icon_no_goods"];
            break;
        case GoodsStatuIconpurchase:
            _goodsStatuIcon.image = [UIImage imageNamed:@"icon_purchase_goods"];
            break;
            
        default:
            break;
    }
}


@end
