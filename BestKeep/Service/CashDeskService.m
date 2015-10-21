//
//  CashDeskService.m
//  BESTKEEP
//
//  Created by dcj on 15/8/28.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "CashDeskService.h"
#import "RequestFromServer.h"
#import "AppControlManager.h"
#import "InterfaceURLs.h"
#import "AccountInfoModel.h"

@implementation CashDeskService

+(void)getAvailableMoenyCompeletion:(RequestCompeliton)compeletion{
    
     NSString * urlStr = [strBKAPI stringByAppendingString:strAccount_info];
    NSDictionary * headDict = [AppControlManager getSTHeadDictionary:nil strurl:urlStr];
   
    [RequestFromServer requestWithURL:urlStr type:@"POST" requsetHeadDictionary:headDict requestBodyDictionary:nil showHUDView:nil showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject objectForKey:@"success"]) {
            NSArray * acountList = [[responseObject objectForKey:@"data"] objectForKey:@"account"];
            NSMutableArray * accountListInfo = [[NSMutableArray alloc] init];
          [acountList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
              AccountInfoModel * account  = [[AccountInfoModel alloc] initWithDictionary:obj];
              account.banlance = [[obj objectForKey:@"banlance"] stringValue];
              [accountListInfo addObject:account];
              
          }];
            compeletion?compeletion(accountListInfo,nil):nil;
            
        }else{
            NSError * error = [NSError errorWithDomain:[responseObject objectForKey:@"msg"] code:[[responseObject objectForKey:@"code"] integerValue] userInfo:nil];
            compeletion?compeletion(nil,error):nil;
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        compeletion?compeletion(operation,error):nil;
    }];


}
+(void)confirmPayForOrderHeadParams:(NSDictionary *)headParams andBodyParams:(NSDictionary *)bodyParams RequestCompeliton:(RequestCompeliton)compeletion{

     NSString * urlStr = [strBKAPI stringByAppendingString:strOrder_pay];
    NSDictionary * headDict = [AppControlManager getSTHeadDictionary:headParams strurl:urlStr];
   

    [RequestFromServer requestWithURL:urlStr type:@"POST" requsetHeadDictionary:headDict requestBodyDictionary:bodyParams showHUDView:nil showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        compeletion?compeletion(@"true",nil):nil;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        compeletion?compeletion(nil,error):nil;
    }];
    
}


+(void)calculateOrdersMoneyWithOrders:(NSArray *)orders requestCompeletion:(RequestCompeliton)compeletion{
    NSString * orderStr = @"";
    if (orders) {
        orderStr = [orders componentsJoinedByString:@","];

    }
   //NSDictionary * bodyDict = @{orderStr:@"order_no"};
    NSString * urlStr = [strBKAPI stringByAppendingString:strOrder_total];
    NSDictionary * bodyDict = [NSDictionary dictionaryWithObjectsAndKeys:orderStr,@"order_no", nil];
    NSDictionary * headDict = [AppControlManager getSTHeadDictionary:bodyDict strurl:urlStr];
    
    
    [RequestFromServer requestWithURL:urlStr type:@"POST" requsetHeadDictionary:headDict requestBodyDictionary:bodyDict showHUDView:nil showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject objectForKey:@"success"]) {
            NSDictionary * totalCount = [responseObject objectForKey:@"data"];
            compeletion?compeletion(totalCount,nil):nil;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        compeletion?compeletion(nil,error):nil;
    }];
}

+(void)getMenberBind:(RequestCompeliton)compeletion{
   
    NSString * urlStr = [strBKAPI stringByAppendingString:strMenber_bind];
     NSDictionary * headDict = [AppControlManager getSTHeadDictionary:nil strurl:urlStr];
    [RequestFromServer requestWithURL:urlStr type:@"POST" requsetHeadDictionary:headDict requestBodyDictionary:nil showHUDView:nil showErrorAlertView:NO success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject objectForKey:@"success"]) {
            NSDictionary * bonfInfo = [responseObject objectForKey:@"data"];
            
            compeletion?compeletion(bonfInfo,nil):nil;
            
        }else{
            NSError * error = [NSError errorWithDomain:[responseObject objectForKey:@"msg"] code:[[responseObject objectForKey:@"code"] integerValue] userInfo:nil];
            compeletion?compeletion(nil,error):nil;
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        compeletion?compeletion(nil,error):nil;
    }];
    
    
}














@end
