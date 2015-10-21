//
//  HOME.m
//  BESTKEEP
//
//  Created by 魏鹏 on 15/10/16.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "HOME.h"

@implementation HOME
-(instancetype)init{
    self =  [super init];
    if (self) {
    }
    return self;
}
+(NSDictionary *)objectClassInArray{
    return @{
             @"top" : @"Title",
             @"global" : @"Title",
             @"tshirt" : @"Title"
             };
}
@end
