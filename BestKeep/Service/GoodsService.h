//
//  GoodsService.h
//  BESTKEEP
//
//  Created by dcj on 15/10/16.
//  Copyright © 2015年 YISHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Compeletion)(id result , NSError * error);

@interface GoodsService : NSObject


/**
 *  goodsList
 */

+(void)getGoodsListWithListKey:(NSString *)goodsListKey compeletion:(Compeletion)compeletion;


+(void)getGoodsReserveStatusWithGoodsNo:(NSString *)goodsNo compeletion:(Compeletion)compeletion;

@end
