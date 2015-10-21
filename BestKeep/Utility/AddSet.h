//
//  AddSet.h
//  BESTKEEP
//
//  Created by YISHANG on 15/8/29.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddSet : NSObject
//收货地址
//收货地址ID
+(void)setAddID:(NSString *)addId;
+(NSString *)getAddId;
//收货人名
+(void)setAddName:(NSString *)addName;
+(NSString *)getAddName;
//省份名称
+(void)setAddProvinceName:(NSString*)addProvinceName;
+(NSString *)getAddProvinceName;
//城市名称
+(void)setAddCityName:(NSString *)addCityName;
+(NSString *)getAddCityName;
//区县名称
+(void)setAddCountyName:(NSString *)addCountyName;
+(NSString *)getAddCountyName;
//详细地址
+(void)setAddAddress:(NSString *)addAddress;
+(NSString *)getAddAddress;
//邮编
+(void)setAddPostCode:(NSString *)addPostCode;
+(NSString *)getAddPostCode;
//是否默认地址
+(void)setAddIsDefaulit:(NSString *)addIsDefaulit;
+(NSString *)getAddIsDefaulit;
//手机电话
+(void)setAddTelephone:(NSString *)addTelephone;
+(NSString *)getAddTelephone;
//固定电话
+(void)setAddFixedTelephone:(NSString *)addFixedTelephone;
+(NSString *)getAddFixedTelephone;
//省份代码
+(void)setAddProvinceCode:(NSString *)addProvinceCode;
+(NSString *)getAddProvinceCode;
//城市代码
+(void)setAddCityCode:(NSString *)addCityCode;
+(NSString *)getAddCityCode;
//区县代码
+(void)setAddCountyCode:(NSString *)addCountyCode;
+(NSString *)getAddCountyCode;

+(void)setadd:(id)obj;
+(id)getaddobj;
@end
