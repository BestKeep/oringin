//
//  GoodsModel.m
//  BESTKEEP
//
//  Created by dcj on 15/8/29.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel

-(void)setStatus:(NSString *)status{
    _status = status;
    if ([_status isEqualToString:@"0"]) {
        _goodsStatu = GoodsStatuIconNoSale;
    }else if ([_status isEqualToString:@"1"]){
        _goodsStatu = GoodsStatuIconHasGoods;
    }else if ([_status isEqualToString:@"2"]){
        _goodsStatu = GoodsStatuIconNoGoods;
    }else if ([_status isEqualToString:@"3"]){
        _goodsStatu = GoodsStatuIconpurchase;
    }else{
        _goodsStatu = GoodsStatuIconNoIcon;
    }
}


@end

@implementation CollectionGoodsModel

-(NSString *)getPriceBalance{

    NSInteger markPrice = [self.market_price integerValue];
    NSInteger memberPrice = [self.member_price integerValue];
    return [NSString stringWithFormat:@"以降%ld元",(long)(markPrice - memberPrice)];
}
@end
