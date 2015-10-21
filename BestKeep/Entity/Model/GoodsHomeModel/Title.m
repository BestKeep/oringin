//
//  Title.m
//  BESTKEEP
//
//  Created by 魏鹏 on 15/10/16.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "Title.h"

@implementation Title
-(instancetype)init{
    self =  [super init];
    if (self) {
    }
    return self;
}
+(NSDictionary *)objectClassInArray{
    return @{
             @"list" : @"List",
             };
}
@end
