//
//  AddController.h
//  BESTKEEP
//
//  Created by YISHANG on 15/8/29.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopingAddressController.h"
#import "DeliverAddress.h"
@interface AddController : BaseViewController

//@property (nonatomic,strong)NSString *DeliverName1;//收货人名字
//@property (nonatomic,strong)NSString *Telephone1;//收货人电话
//@property (nonatomic,strong)NSString *address1;//收货人地址
//@property (nonatomic,strong)NSString *isAddress1;
//@property (nonatomic,strong)NSString *addressmsg1;
//@property (nonatomic,strong)NSString *addId1;//收货ID
//@property (nonatomic,strong)NSString *provincName1;//省份名称
//@property (nonatomic,strong)NSString *cityName1;//城市名称
//@property (nonatomic,strong)NSString *countyName1;//区县名称
//@property (nonatomic,strong)NSString *postCode1;//邮编
//@property (nonatomic,strong)NSString *isDefault1;//是否是默认地址
//@property (nonatomic,strong)NSString *fixedTelephone1;//固定电话
//@property (nonatomic,strong)NSString *provinceCode1;//省份代码
//@property (nonatomic,strong)NSString *cityCode1;//城市代码
//@property (nonatomic,strong)NSString *countyCode1;//区县代码

@property (nonatomic,strong) DeliverAddress *address;

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end
