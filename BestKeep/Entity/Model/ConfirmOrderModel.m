//
//  ConfirmOrderModel.m
//  BESTKEEP
//
//  Created by dcj on 15/10/21.
//  Copyright © 2015年 YISHANG. All rights reserved.
//

#import "ConfirmOrderModel.h"
#import "OrderInfo.h"
@implementation ConfirmOrderModel


-(void)setUnKonwnValueKeyWithDict:(NSDictionary *)unKonwnDict{
    NSMutableArray * orderArr = [unKonwnDict objectForKey:@"list"];
    NSMutableArray * orderList = [[NSMutableArray alloc] init];
    [orderArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        OrderInfo *order = [[OrderInfo alloc] initWithDictionary:obj];
        [orderList addObject:order];
    }];
    self.orderList = orderList;
}

@end
