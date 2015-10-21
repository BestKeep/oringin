//
//  AddSet.m
//  BESTKEEP
//
//  Created by YISHANG on 15/8/29.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "AddSet.h"

@implementation AddSet
//收货地址ID
NSString *addid;
+(void)setAddID:(NSString *)addId{
    addid = addId;
}
+(NSString *)getAddId{
    return addid;
}
//收货人名
NSString *addname;
+(void)setAddName:(NSString *)addName{
    addname = addName;
}
+(NSString *)getAddName{
    return addname;
}
//省份名称
NSString *provincename;
+(void)setAddProvinceName:(NSString*)addProvinceName{
    provincename = addProvinceName;
}
+(NSString *)getAddProvinceName{
    return provincename;
}
//城市名称
NSString *cityname;
+(void)setAddCityName:(NSString *)addCityName{
    cityname = addCityName;
}
+(NSString *)getAddCityName{
    return cityname;
}
//区县名称
NSString *countyname;
+(void)setAddCountyName:(NSString *)addCountyName{
    countyname=addCountyName;
}
+(NSString *)getAddCountyName{
    return countyname;
}
//详细地址
NSString *address;
+(void)setAddAddress:(NSString *)addAddress{
    address = addAddress;
}
+(NSString *)getAddAddress{
    return address;
}
//邮编
NSString * postcode;
+(void)setAddPostCode:(NSString *)addPostCode{
    postcode = addPostCode;
}
+(NSString *)getAddPostCode{
    return postcode;
}
//是否默认地址
NSString *isdefaulit;
+(void)setAddIsDefaulit:(NSString *)addIsDefaulit{
    isdefaulit =  addIsDefaulit;
}
+(NSString *)getAddIsDefaulit{
    return isdefaulit;
}
//手机电话
NSString *telephone;
+(void)setAddTelephone:(NSString *)addTelephone{
    telephone =  addTelephone;
}
+(NSString *)getAddTelephone{
    return telephone;
}
//固定电话
NSString *fixedtelephone;
+(void)setAddFixedTelephone:(NSString *)addFixedTelephone{
    fixedtelephone = addFixedTelephone;
}
+(NSString *)getAddFixedTelephone{
    return fixedtelephone;
}
//省份代码
NSString *provincecode;
+(void)setAddProvinceCode:(NSString *)addProvinceCode{
    provincecode =  addProvinceCode;
}
+(NSString *)getAddProvinceCode{
    return provincecode;
}
//城市代码
NSString * citycode;
+(void)setAddCityCode:(NSString *)addCityCode{
    citycode = addCityCode;
}
+(NSString *)getAddCityCode{
    return citycode;
}
//区县代码
NSString *countycode;
+(void)setAddCountyCode:(NSString *)addCountyCode{
    countycode = addCountyCode;
}
+(NSString *)getAddCountyCode{
    return countycode;
}
id addobjs;
+(void)setadd:(id)obj{
    addobjs = obj;
}
+(id)getaddobj{
    return addobjs;
}
@end
