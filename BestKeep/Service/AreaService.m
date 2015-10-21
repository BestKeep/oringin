//
//  AreaService.m
//  BESTKEEP
//
//  Created by YISHANG on 15/8/27.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "AreaService.h"
#import "RequestFromServer.h"
#import "InterfaceURLs.h"
#import "AppControlManager.h"
#import "Result.h"
#import "Area.h"
@implementation AreaService
#pragma mark- 查询地区/省份

+(void)GetArea:(UIView *)view callback:(MyCallback)callback{
    
    NSString *strURL = [strBKAPI stringByAppendingString:strArea_province];
    NSDictionary *head_dic = [AppControlManager getSTHeadDictionary:nil strurl:strURL];
    
    [RequestFromServer requestWithURL:strURL type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:nil showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result_dic  = responseObject;
        BOOL success = [[result_dic objectForKey:@"success"]boolValue];
        NSString *msg = [result_dic objectForKey:@"msg"];
        NSString *code = [result_dic objectForKey:@"code"];
        if (success) {
            
            
            NSDictionary *data_dic = [result_dic objectForKey:@"data"];
            NSArray *list_array = [data_dic objectForKey:@"list"];
            NSMutableArray *data_array = [[NSMutableArray alloc]init];
            
            for (int i =0; i < list_array.count; i++) {
                NSDictionary *area_dic = list_array[i];
                Area *Area_Data = [[Area alloc]init];
                Area_Data.AreaCode = [area_dic objectForKey:@"code"];
                Area_Data.AreaName = [area_dic objectForKey:@"name"];
                [data_array addObject:Area_Data];
            }
            callback(data_array,nil);
        }else{
            NSLog(@"Get Area failed");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
}

#pragma mark- 查询地区/城市

+(void)GetCity:(NSString *)province_code view:(UIView *)view callback:(MyCallback)callback{
    
    NSMutableDictionary *body_dic = [[NSMutableDictionary alloc]init];
    [body_dic setValue:province_code forKey:@"province_code"];
    NSString *strURL = [strBKAPI stringByAppendingString:strArea_city];
    NSDictionary *head_dic = [AppControlManager getSTHeadDictionary:body_dic strurl:strURL];
    [RequestFromServer requestWithURL:strURL type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:body_dic showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result_dic  = responseObject;
        BOOL success = [[result_dic objectForKey:@"success"]boolValue];
        NSString *msg = [result_dic objectForKey:@"msg"];
        NSString *code = [result_dic objectForKey:@"code"];
        if (success) {
            
            
            NSDictionary *data_dic = [result_dic objectForKey:@"data"];
            NSArray *list_array = [data_dic objectForKey:@"list"];
            NSMutableArray *data_array = [[NSMutableArray alloc]init];
            
            for (int i =0; i < list_array.count; i++) {
                NSDictionary *area_dic = list_array[i];
                Area *Area_Data = [[Area alloc]init];
                Area_Data.AreaCode = [area_dic objectForKey:@"code"];
                Area_Data.AreaName = [area_dic objectForKey:@"name"];
                [data_array addObject:Area_Data];
            }
            callback(data_array,nil);
        }else{
            NSLog(@"Get City failed");
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}


#pragma mark- 查询地区/区县

+(void)GetSquare:(NSString *)city_code view:(UIView *)view callback:(MyCallback)callback{
    
    NSString *strURL = [strBKAPI stringByAppendingString:strArea_county];
    NSMutableDictionary *body_dic = [[NSMutableDictionary alloc]init];
    [body_dic setValue:city_code forKey:@"city_code"];
    NSDictionary *head_dic = [AppControlManager getSTHeadDictionary:body_dic strurl:strURL];
    [RequestFromServer requestWithURL:strURL type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:body_dic showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result_dic  = responseObject;
        BOOL success = [[result_dic objectForKey:@"success"]boolValue];
        NSString *msg = [result_dic objectForKey:@"msg"];
        NSString *code = [result_dic objectForKey:@"code"];
        if (success) {
            
            
            NSDictionary *data_dic = [result_dic objectForKey:@"data"];
            NSArray *list_array = [data_dic objectForKey:@"list"];
            NSMutableArray *data_array = [[NSMutableArray alloc]init];
            
            for (int i =0; i < list_array.count; i++) {
                NSDictionary *area_dic = list_array[i];
                Area *Area_Data = [[Area alloc]init];
                Area_Data.AreaCode = [area_dic objectForKey:@"code"];
                Area_Data.AreaName = [area_dic objectForKey:@"name"];
                [data_array addObject:Area_Data];
            }
            callback(data_array,nil);
        }else{
            NSLog(@"Get Square failed");
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
}@end
