//
//  AliPayResultManager.m
//  BESTKEEP
//
//  Created by dcj on 15/9/15.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "AliPayResultManager.h"
#import "ALiPayResult.h"
@implementation AliPayResultManager

+(instancetype)sharedInstance{
    static AliPayResultManager * manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AliPayResultManager alloc] init];
    });
    return manager;
}

-(ALiPayResult *)analyzeResultDict:(NSDictionary *)resultDict{
    
    NSError * error = [self checkErrorWithCode:[[resultDict objectForKey:@"resultStatus"] integerValue]];
    ALiPayResult * aliPayResult = [[ALiPayResult alloc] initWithDictionary:resultDict];
    aliPayResult.error = error;
 
    return aliPayResult;
}

-(NSError *)checkErrorWithCode:(NSInteger)code{

    NSString * errorDomain;
    if (code == 9000) {
        return nil;
    }else if (code == 8000){
        errorDomain = @"正在处理中";
    }else if (code == 4000){
        errorDomain = @"支付失败";
    }else if (code == 6001){
        errorDomain = @"取消支付";
    }else if (code == 6002){
        errorDomain = @"网络连接出错";
    }
    NSError * error = [NSError errorWithDomain:errorDomain code:code userInfo:nil];

    return error;
}
@end
