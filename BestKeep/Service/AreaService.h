//
//  AreaService.h
//  BESTKEEP
//
//  Created by YISHANG on 15/8/27.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaService : NSObject
typedef void (^MyCallback)(id obj,NSError* error);
/*
 查询地区/省份
 */
+(void)GetArea:(UIView *)view callback:(MyCallback)callback;

/*
 查询地区/城市
 */
+(void)GetCity:(NSString *)province_code view:(UIView *)view callback:(MyCallback)callback;

/*
 查询地区/区县
 */
+(void)GetSquare:(NSString *)city_code view:(UIView *)view callback:(MyCallback)callback;
@end
