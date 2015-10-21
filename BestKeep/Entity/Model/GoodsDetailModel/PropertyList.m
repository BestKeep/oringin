//
//  PropertyList.m
//  BESTKEEP
//
//  Created by 魏鹏 on 15/10/9.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "PropertyList.h"

@implementation PropertyList
-(instancetype)init{
    self =  [super init];
    if (self) {
    }
    return self;
}
+(NSDictionary *)objectClassInArray{
    return @{
             @"propertyRelList" : @"PropertyReList",
             };
}

@end
