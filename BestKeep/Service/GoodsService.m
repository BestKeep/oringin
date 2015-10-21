//
//  GoodsService.m
//  BESTKEEP
//
//  Created by dcj on 15/10/16.
//  Copyright © 2015年 YISHANG. All rights reserved.
//

#import "GoodsService.h"
#import "RequestFromServer.h"
#import "GoodsModel.h"


@implementation GoodsService

+(void)getGoodsListWithListKey:(NSString *)goodsListKey compeletion:(Compeletion)compeletion{

    //NSString * testUrlStr = @"http://file.bestkeep.cn/ui/mobile/app/data/oakley.json";
    NSString * strURL = [[strGOODSHOME stringByAppendingString:goodsListKey] stringByAppendingString:@".json"];
    [RequestFromServer requestWithURL:strURL type:@"GET" requsetHeadDictionary:nil requestBodyDictionary:nil showHUDView:nil showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            __block NSMutableArray * goodsList = [[NSMutableArray alloc] init];
            
            NSMutableArray * goodsNoArr = [[NSMutableArray alloc] init];
            
//            [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                GoodsModel * goods = [[GoodsModel alloc] initWithDictionary:obj];
//                [goodsNoArr addObject:goods.goods_no];
//                [goodsList addObject:goods];
//            }];
            [responseObject enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                GoodsModel * goods = [[GoodsModel alloc] initWithDictionary:obj];
                [goodsNoArr addObject:goods.goods_no];
                [goodsList addObject:goods];

            }];
            
            NSString * goods_nos = [goodsNoArr componentsJoinedByString:@","];
            
            __block NSArray * tempGoodsArr = goodsList;
            [self getGoodsReserveStatusWithGoodsNo:goods_nos compeletion:^(id result, NSError *error) {
                [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    for (GoodsModel * tempModel in tempGoodsArr) {
                        NSMutableString * goodsNo = [obj objectForKey:@"goodsNo"];
                        if ([tempModel.goods_no isEqualToString:goodsNo]) {
                            [tempModel objectForKeyValue:obj];
                        }
                    }

                }];
//                [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                    for (GoodsModel * tempModel in tempGoodsArr) {
//                        NSMutableString * goodsNo = [obj objectForKey:@"goodsNo"];
//                        if ([tempModel.goods_no isEqualToString:goodsNo]) {
//                            [tempModel objectForKeyValue:obj];
//                        }
//                    }
//                }];
//                
            }];
            compeletion?compeletion(goodsList,nil):nil;
        }else{
            NSError * error = [NSError errorWithDomain:@"请求数据失败" code:123456 userInfo:nil];
            compeletion?compeletion(nil,error):nil;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        compeletion?compeletion(operation,error):nil;
    }];
    
    
}

+(void)getGoodsReserveStatusWithGoodsNo:(NSString *)goodsNo compeletion:(Compeletion)compeletion{

    NSString * urlStr = [strBKAPI stringByAppendingString:goodsReserveStatus];

    NSDictionary * paramaDcit = @{@"goods_nos":goodsNo};
//    NSDictionary * headDict = [AppControlManager getSTHeadDictionary:paramaDcit strurl:urlStr];
    
    [RequestFromServer requestWithURL:urlStr type:@"POST" requsetHeadDictionary:nil requestBodyDictionary:paramaDcit showHUDView:nil showErrorAlertView:NO success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSArray * statuArr = [responseObject objectForKey:@"data"];
            compeletion(statuArr,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            compeletion(nil,error);
        }
    }];
    
    

}


@end
