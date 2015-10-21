//
//  GoodsDetailDTO.h
//  BESTKEEP
//
//  Created by 魏鹏 on 15/10/9.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PropertyList;
@class ReserveList;

@interface GoodsDetailDTO : NSObject

@property(nonatomic,copy) NSString *checkFlagStr;
@property(nonatomic,copy) NSString *createDateStr;
@property(nonatomic,copy) NSString *deliverBeginDays;
@property(nonatomic,copy) NSString *deliverEndDays;
@property(nonatomic,copy) NSString *isExemptExpress;
@property(nonatomic,copy) NSString *isExemptExpressStr;
@property(nonatomic,copy) NSString *linePostTaxRatio;
@property(nonatomic,strong) NSArray *propertyList;
@property(nonatomic,copy) NSString *quotaTimeUnit;
@property(nonatomic,copy) NSString *quotaTimeValue;
@property(nonatomic,copy) NSString *singleDeliver;
@property(nonatomic,copy) NSString *updatedDateStr;
@property(nonatomic,strong) NSArray *reserveList;


@end
