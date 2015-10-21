
//
//  ShoppingCarList.m
//  BESTKEEP
//
//  Created by 魏鹏 on 15/8/27.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "ShoppingCarList.h"

@implementation ShoppingCarList



-(BOOL)isOrderChanged{
    
    return ![self.amount isEqualToString:self.amountSign];
}

@end
@implementation superShopping

-(instancetype)init{
    self = [super init];
    if (self){
        
    }
    return self;
}


@end

