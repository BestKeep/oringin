//
//  AppControlManager.m
//  MobileUU
//
//  Created by 王義傑 on 15/5/21.
//  用于生成HTTP请求的头部参数
//  Copyright (c) 2015年 Shanghai Pecker Network Technology. All rights reserved.
//

#import "AppControlManager.h"
#import "MD5.h"
#import "Userinfo.h"
#import "DataSigner.h"

@implementation AppControlManager

+(NSMutableDictionary *)getSTHeadDictionary :(NSDictionary *)dic_params strurl:(NSString*)url;{
    
    @try {
        NSString *strST = [Userinfo getST];
        if (strST == nil) {
            strST = @"";
        }
        else{
            strST = [Userinfo getST];
        }
          //时间
        NSString *time = [MD5 getSystemTime];
        
        //生成sign
        NSString *strSign = [MD5 md5:dic_params time:time];
        
        NSString *sign = strSign;
        NSMutableDictionary *head_dic = [[NSMutableDictionary alloc] initWithCapacity:5];
        NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
        NSString* versionNum =[infoDict objectForKey:@"CFBundleVersion"];
        NSString *version = [NSString stringWithFormat:@"%@.%@",[infoDict objectForKey:@"CFBundleShortVersionString"],versionNum];
        NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
        NSString *deviceModel = [[UIDevice currentDevice] model];
        NSString *deviceSys = [[UIDevice currentDevice] systemVersion];
        CGFloat screenScale = [[UIScreen mainScreen] scale];
        NSString *user_agent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)",appName,version,deviceModel,deviceSys,screenScale];
        [head_dic setObject:sign forKey:@"cas-client-sign"];
        [head_dic setObject:time forKey:@"cas-client-time"];
        [head_dic setObject:url forKey:@"cas-client-service"];//@"http://app.utouu"
        [head_dic setObject:strST forKey:@"cas-client-st"];
        [head_dic setObject:user_agent forKey:@"User-Agent"];
        return head_dic;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


+(NSString *)getAliPayOrder:(NSString *)orderInfo{
    NSDictionary * infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString * privateKey = [infoDict objectForKey:@"privateKey"];
    
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderInfo];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    //    NSString *orderString = nil;
    if (signedString != nil) {
        //        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
        //                       orderInfo, signedString, @"RSA"];
        
    }
    //    return orderString;
    return orderInfo;
}




@end
