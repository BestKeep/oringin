//
//  GoodsDataModel.h
//  BESTKEEP
//
//  Created by 魏鹏 on 15/10/9.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GoodsDTO;
@class GoodsDetailDTO;
@class ImgList;
@class ParamList;

@interface GoodsDataModel : NSObject

@property(nonatomic,copy) NSString *amount;
@property(nonatomic,copy) NSString *collectflag;
@property(nonatomic,copy) NSString *deliverDateStr;
@property(nonatomic,copy) NSString *logisticsData;
@property(nonatomic,copy) NSString *preSaleReserveAmount;
@property(nonatomic,copy) NSString *preSalebatchAmount;
@property(nonatomic,copy) NSString *propRelCount;
@property(nonatomic,copy) NSString *putawayTypeStr;
@property(nonatomic,copy) NSString *saleReserveAmount;

@property(nonatomic,strong) GoodsDTO* goodsDTO;
@property(nonatomic,strong) GoodsDetailDTO* goodsDetailDTO;
@property(nonatomic,strong) NSMutableArray *imgList;
@property(nonatomic,strong) NSMutableArray *paramList;


@property(nonatomic,copy) NSString *marketprice;
@property(nonatomic,copy) NSString *memberShipprice;
@property(nonatomic,copy) NSString *sugarTax;
@property(nonatomic,copy) NSString *tariff;


@end