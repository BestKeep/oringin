//
//  ShoppingCarCommon.h
//  BESTKEEP
//
//  Created by 魏鹏 on 15/8/27.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCarCommon : NSObject

@property(nonatomic) BOOL success;
@property(nonatomic,copy) NSString *msg;
@property(nonatomic,copy) NSString *code;
@property(nonatomic,retain) NSDictionary *data;
@end
