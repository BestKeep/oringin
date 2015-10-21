//
//  DataTransform.h
//  MobileUU
//
//  Created by YISHANG on 15/6/3.
//  Copyright (c) 2015年 Shanghai Pecker Network Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTransform : NSObject
//国家:被选中的用户ID
+(void)setSelectedUnitUserID:(NSString *)user_ID;

+(NSString *)getSelectedUnitUserID;

//国家 管理者 类型
//+(void)setSelectedUnitMngr_type:(NSString *)UnitMngr_type;
//+(NSString *)getSelectedUnitMngr_type;

//用户昵称
+(void)setSelectedNameUser:(NSString *)NameUser;
+(NSString *)getSelectedNameUser;

//实名认证信息
+(void)setRealNameInfo:(NSObject *)realnameInfo;
+(NSObject *)getRealNameInfo;
//记录点击人口管理按钮
+(void)setClickBut:(NSString *)cBut;
+(NSString *)getClickBut;
@end
