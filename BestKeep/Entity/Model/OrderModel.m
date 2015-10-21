//
//  OrderModel.m
//  BESTKEEP
//
//  Created by 魏鹏 on 15/8/28.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel
-(instancetype)init{
   self = [super init];
    if (self) {
        
    }
    return self;
}
@end

@implementation OrderModel1
-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)setCustoms_tax_amount_totalWithGoodsArray:(NSArray *)goodsArray{
    __block CGFloat taxAmount = 0;
    [goodsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        OrderModel2 * model = (OrderModel2 *)obj;
        taxAmount = taxAmount + [model.customs_tax_amount floatValue];
    }];
    self.customs_tax_amount_total = [NSString stringWithFormat:@"%0.2f",taxAmount];
}

-(BOOL)isGlobal{
    if ([_global_status isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
}

@end

@implementation OrderModel2
-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end