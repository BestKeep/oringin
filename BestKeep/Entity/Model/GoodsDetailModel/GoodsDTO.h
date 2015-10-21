//
//  GoodsDTO.h
//  BESTKEEP
//
//  Created by 魏鹏 on 15/10/9.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsDTO : NSObject
@property(nonatomic,copy) NSString *categoryId;
@property(nonatomic,copy) NSString *categoryName;
@property(nonatomic,copy) NSString *channelId;
@property(nonatomic,copy) NSString *channelIsOpen;
@property(nonatomic,copy) NSString *channelName;
@property(nonatomic,copy) NSString *channelType;
@property(nonatomic,copy) NSString *channelTypeStr;
@property(nonatomic,copy) NSString *channelUrl;
@property(nonatomic,copy) NSString *checkDate;
@property(nonatomic,copy) NSString *checkFlag;
@property(nonatomic,copy) NSString *checkFlagStr;
@property(nonatomic,copy) NSString *checkUserId;
@property(nonatomic,copy) NSString *createdDate;
@property(nonatomic,copy) NSString *createdDateStr;
@property(nonatomic,copy) NSString *defaultExpressCompanyId;
@property(nonatomic,copy) NSString *deliverAddress;
@property(nonatomic,copy) NSString *deliverAddressName;
@property(nonatomic,copy) NSString *deliverBeginDays;
@property(nonatomic,copy) NSString *deliverEndDays;
@property(nonatomic,copy) NSString *goodsMarketPrice;
@property(nonatomic,copy) NSString *goodsName;
@property(nonatomic,copy) NSString *goodsNo;
@property(nonatomic,copy) NSString *goodsPlatformPrice;
@property(nonatomic,copy) NSString *id;//id
@property(nonatomic,copy) NSString *goodsRealPrice;
@property(nonatomic,copy) NSString *isExemptExpress;
@property(nonatomic) BOOL isExemptExpressStr;
@property(nonatomic,copy) NSString *linePostTaxRatio;
@property(nonatomic,copy) NSString *linePostTaxRatioAmount;
@property(nonatomic,copy) NSString *privilegeAmount;
@property(nonatomic,copy) NSString *quotaRatio;
@property(nonatomic,copy) NSString *quotaTimeUnit;
@property(nonatomic,copy) NSString *quotaTimeValue;
@property(nonatomic,copy) NSString *remark;
@property(nonatomic,copy) NSString *settlementPrice;
@property(nonatomic,copy) NSString *shoppingGuideRatio;
@property(nonatomic,copy) NSString *singleDeliver;
@property(nonatomic,copy) NSString *status;
@property(nonatomic,copy) NSString *taxAmount;
@property(nonatomic,copy) NSString *taxRatio;
@property(nonatomic,copy) NSString *updatedDate;
@property(nonatomic,copy) NSString *updatedDateStr;
@property(nonatomic,copy) NSString *version;
@property(nonatomic,copy) NSString *videoUrl;
@property(nonatomic,copy) NSString *warehouseId;


@end
