//
//  OrderInfo.m
//  BESTKEEP
//
//  Created by dcj on 15/9/11.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "OrderInfo.h"
#import "GoodsModel.h"

@implementation OrderInfo
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super initWithDictionary:dict];
    if (self) {
        
    }
    return self;
}

-(void)setUnKonwnValueKeyWithDict:(NSDictionary *)unKonwnDict{
    self.goodslist = [[NSMutableArray alloc] init];
    NSMutableArray * goodsArray = [unKonwnDict objectForKeyedSubscript:@"item_list"];
    [goodsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        GoodsModel * goods =[[GoodsModel alloc] initWithDictionary:obj];
        [self.goodslist addObject:goods];
    }];
}
-(BOOL)isGlobal{
    if ([_global_status isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
}


@end
