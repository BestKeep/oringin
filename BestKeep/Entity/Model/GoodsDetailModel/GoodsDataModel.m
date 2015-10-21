//
//  GoodsDataModel.m
//  BESTKEEP
//
//  Created by 魏鹏 on 15/10/9.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "GoodsDataModel.h"
#import "NSObject+MJKeyValue.h"

@implementation GoodsDataModel

-(instancetype)init{
   self =  [super init];
    if (self) {
//        self.imgList_Array = [[NSMutableArray alloc] init];
//        self.paramList_Array = [[NSMutableArray alloc] init];
    }
    return self;
}
+(NSDictionary *)objectClassInArray{
    return @{
             @"paramList" : @"ParamList",
             @"imgList" : @"ImgList"
             };
}


@end
