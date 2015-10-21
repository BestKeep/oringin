//
//  DeliverAddress.h
//  BESTKEEP
//
//  Created by YISHANG on 15/8/27.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeliverAddress : NSObject
//收货地址ID
@property (nonatomic,strong) NSString *deliverId;
//收货人姓名
@property (nonatomic,strong) NSString *deliverName;
//省份名称
@property (nonatomic,strong) NSString *deliverProvinceName;
//城市名称
@property (nonatomic,strong) NSString *deliverCityName;
//区县名称
@property (nonatomic,strong) NSString *deliverCountyName;
//详细地址
@property (nonatomic,strong) NSString *deliverAddress;
//邮编
@property (nonatomic,strong) NSString *deliverPostCode;
//是否默认地址
@property (nonatomic,strong) NSString  *deliverIsDefault;
//手机电话
@property (nonatomic,strong) NSString *deliverTelephone;
//固定电话
@property (nonatomic,strong) NSString *deliverFixedTelephone;
//省份代码
@property (nonatomic,strong) NSString *deliverProvinceCode;
//城市代码
@property (nonatomic,strong) NSString *deliverCityCode;
//区县代码
@property (nonatomic,strong) NSString *deliverCountyCode;
@property (nonatomic,assign) BOOL isDefaultAddress;
@end
