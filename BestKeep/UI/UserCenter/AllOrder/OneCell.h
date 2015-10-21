//
//  OneCell.h
//  BESTKEEP
//
//  Created by YISHANG on 15/8/26.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"


@interface OneCell : UITableViewCell
@property (nonatomic,strong)UIView *view2;
@property(nonatomic,strong) UIImageView *proImageView;
@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *sizeLabel;
@property(nonatomic,strong) UILabel *priceLabel1;
@property(nonatomic,strong) UILabel *priceLabel2;
@property(nonatomic,strong) UILabel *numLabel1;
@property(nonatomic,strong) UILabel *numLabel2;
@property(nonatomic,strong) UILabel *amountLabel;

@property (nonatomic,strong) GoodsModel * goodsInfo;


@end
