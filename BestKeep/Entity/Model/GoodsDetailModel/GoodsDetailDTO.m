//
//  GoodsDetailDTO.m
//  BESTKEEP
//
//  Created by 魏鹏 on 15/10/9.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "GoodsDetailDTO.h"

@implementation GoodsDetailDTO

-(instancetype)init{
    self =  [super init];
    if (self) {
         }
    return self;
}
+(NSDictionary *)objectClassInArray{
    return @{
             @"propertyList" : @"PropertyList",
             @"reserveList" : @"ReserveList"
             };
}

@end
