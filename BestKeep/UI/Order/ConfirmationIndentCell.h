//
//  ConfirmationIndentCell.h
//  BESTKEEP
//
//  Created by UTOUU on 15/8/19.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsModel;

@interface ConfirmationIndentCell : UITableViewCell

@property(nonatomic,strong) UILabel *addressLabel;
@property(nonatomic,strong) UIView *singleLine;
@property(nonatomic,strong) UIImageView *proImageView;
@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *sizeLabel;
@property(nonatomic,strong) UILabel *priceLabel1;
@property(nonatomic,strong) UILabel *priceLabel2;
@property(nonatomic,strong) UILabel *numLabel1;
@property(nonatomic,strong) UILabel *numLabel2;
@property(nonatomic,strong) UILabel *amountLabel;

@property(nonatomic,strong) UILabel *totalLabel;
@property(nonatomic,strong) UILabel *totalnumLabel;

@property(nonatomic,strong) UILabel *priceLabel3;
@property(nonatomic,strong) UILabel *numLabel3;


@property (nonatomic,strong) GoodsModel * goodsInfo;


@end
