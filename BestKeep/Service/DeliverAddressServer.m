//
//  DeliverAddressServer.m
//  BESTKEEP
//
//  Created by YISHANG on 15/8/27.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "DeliverAddressServer.h"
#import "DeliverAddress.h"
#import "RequestFromServer.h"
#import "InterfaceURLs.h"
#import "AppControlManager.h"
#import "Result.h"

@implementation DeliverAddressServer
//收货地址列表'
+(void)getDeliverAddress:(MyCallback)callback{
    NSString *url = [strBKAPI stringByAppendingString:strDeliver_address_list];
    NSMutableDictionary *head_dic =[AppControlManager getSTHeadDictionary:nil strurl:url];
    [RequestFromServer requestWithURL:url type:@"POST" requsetHeadDictionary:head_dic
                requestBodyDictionary:nil showHUDView:nil showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        Result *deliverResult =[Result alloc];
        NSString *success =[[responseObject objectForKey:@"success"]stringValue];
        NSString *msg = [responseObject objectForKey:@"msg"];
        if ([success isEqualToString:@"1"]) {
            deliverResult.success = YES;
            NSDictionary *data_dic =[responseObject objectForKey:@"data"];
            if ([data_dic count]!=0) {
                NSMutableArray *list_Array =[NSMutableArray array];
                list_Array = [data_dic objectForKey:@"list"];
                NSMutableArray *data_Array = [NSMutableArray array];
                for (int i=0; i<list_Array.count; i++) {
                    NSMutableDictionary *list_data = list_Array[i];
                    DeliverAddress *address =[[DeliverAddress alloc]init];
                    address.deliverId = [list_data objectForKey:@"id"];
                    address.deliverName = [list_data objectForKey:@"deliver_name"];
                    address.deliverProvinceName = [list_data objectForKey:@"province_name"];
                    address.deliverCityName = [list_data objectForKey:@"city_name"];
                    address.deliverCountyName = [list_data objectForKey:@"county_name"];
                    address.deliverAddress = [list_data objectForKey:@"address"];
                    address.deliverPostCode = [list_data objectForKey:@"post_code"];
                    address.deliverIsDefault = [list_data objectForKey:@"is_default"];
                    address.deliverTelephone = [list_data objectForKey:@"telephone"];
                    address.deliverFixedTelephone = [list_data objectForKey:@"fixed_telephone"];
                    address.deliverProvinceCode  = [list_data objectForKey:@"province_code"];
                    address.deliverCityCode = [list_data objectForKey:@"city_code"];
                    address.deliverCountyCode = [list_data objectForKey:@"county_code"];
                    if ([address.deliverIsDefault isEqualToString:@"1"]) {
                        address.isDefaultAddress = YES;
                    }else{
                        address.isDefaultAddress = NO;
                    }
                    
                    [data_Array addObject:address];
                }
                deliverResult.data =data_Array;
             }
        }
        else{
            deliverResult.success = NO;
            [ShowMessage showMessage:msg];
        }
        callback(deliverResult,nil);
                    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(operation,error);
    }];
    
}
//收货地址设置默认
+(void)getDeliverAddress:(NSDictionary *)parameters :(MyCallback)callback{
    NSString *url = [strBKAPI stringByAppendingString:strDeliver_default_address];
    NSMutableDictionary *head_dic =[AppControlManager getSTHeadDictionary:parameters strurl:url];
    [RequestFromServer requestWithURL:url type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:parameters showHUDView:nil showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject != nil) {
            Result *addressResult =[Result alloc];
//            NSString *success =[[responseObject objectForKey:@"success"]stringValue];
            NSString *msg = addressResult.msg = [responseObject objectForKey:@"msg"];
              [ShowMessage showMessage:msg];
            addressResult.success = [[responseObject objectForKey:@"success"] boolValue];
            callback(addressResult,nil);
 
        }
           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               callback(operation,error);
    }];
}
//删除收货地址
+(void)getDleiverDelete:(NSDictionary *)parametser :(MyCallback)callback{
    NSString *url = [strBKAPI stringByAppendingString:strDeliver_delete];
    NSMutableDictionary *head_dic =[AppControlManager getSTHeadDictionary:parametser strurl:url];
    [RequestFromServer requestWithURL:url type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:parametser showHUDView:nil showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (responseObject != nil) {
                Result *deleteResult =[Result alloc];
                NSString *msg = deleteResult.msg = [responseObject objectForKey:@"msg"];
                deleteResult.success =[[responseObject objectForKey:@"success"] boolValue];
                [ShowMessage showMessage:msg];
                callback(deleteResult,nil);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            callback(operation,error);
        }];
}
//编辑收货地址
+(void)getdeliveredit:(NSDictionary *)parameters :(MyCallback)callback{
    NSString *url = [strBKAPI stringByAppendingString:strDeliver_edit];
    NSMutableDictionary *head_dic =[AppControlManager getSTHeadDictionary:parameters strurl:url];
    [RequestFromServer requestWithURL:url type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:parameters showHUDView:nil showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        Result *deleteResult =[[Result alloc] init];
        NSString *success =[[responseObject objectForKey:@"success"]stringValue];
        if ([success isEqualToString:@"1"]) {
            deleteResult.success =YES;
            deleteResult.msg = [responseObject objectForKey:@"msg"];
            
        }else{
            deleteResult.success = NO;
            deleteResult.msg = [responseObject objectForKey:@"msg"];
            deleteResult.code = [responseObject objectForKey:@"code"];
        }
        callback(deleteResult,nil);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(operation,error);
    }];
}
#pragma maek- 添加收货地址

+(void)addAddress:(NSString *)dic view:(UIView *)view callback:(MyCallback)callback{
    NSMutableDictionary *data_dic = [[NSMutableDictionary alloc]init];
    [data_dic setObject:dic forKey:@"data"];
    NSString *strURL = [strBKAPI stringByAppendingString:strDeliver_add];
    NSDictionary *head_dic = [AppControlManager getSTHeadDictionary:data_dic strurl:strURL] ;
    
    
    [RequestFromServer requestWithURL:strURL type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:data_dic showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result_dic  = responseObject;
        Result *add_Restlt = [[Result alloc]init];
        BOOL success = [[result_dic objectForKey:@"success"]boolValue];
        NSString *msg = [result_dic objectForKey:@"msg"];
        NSString *code = [result_dic objectForKey:@"code"];
        add_Restlt.success = success;
        add_Restlt.code = code;
        add_Restlt.msg = msg;
        callback(add_Restlt,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(operation,error);
    }];
}

#pragma mark - 获取用户默认地址
+(void)getDefaultAddress:(UIView*)view callback:(MyCallback)callback;{
    NSString *strURL = [strBKAPI stringByAppendingString:strDefault_address];
    NSDictionary *head_dic = [AppControlManager getSTHeadDictionary:nil strurl:strURL];
    
    [RequestFromServer requestWithURL:strURL type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:nil showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *result_dic  = responseObject;
        Result *add_Restlt = [[Result alloc]init];
        BOOL success = [[result_dic objectForKey:@"success"]boolValue];
        NSString *msg = [result_dic objectForKey:@"msg"];
        NSString *code = [result_dic objectForKey:@"code"];
        NSDictionary *data = [result_dic objectForKey:@"data"];
        add_Restlt.success = success;
        add_Restlt.code = code;
        add_Restlt.msg = msg;
        add_Restlt.data = data;
        callback(add_Restlt,nil);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(operation,error);
    }];
}
@end
