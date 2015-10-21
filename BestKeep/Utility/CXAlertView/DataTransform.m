//
//  DataTransform.m
//  MobileUU
//
//  Created by YISHANG on 15/6/3.
//  Copyright (c) 2015年 Shanghai Pecker Network Technology. All rights reserved.
//

#import "DataTransform.h"

@implementation DataTransform
//国家:被选中的用户ID
NSString * selectedUserID;
+(void)setSelectedUnitUserID:(NSString *)user_ID{
    selectedUserID = user_ID;
}

+(NSString *)getSelectedUnitUserID{
    
    return selectedUserID;
}

//用户名昵称
NSString * name_user;
+(void)setSelectedNameUser:(NSString *)NameUser{
    name_user = NameUser;
}
+(NSString *)getSelectedNameUser{
    return name_user;
}
NSObject * real_nameInfo;
+(void)setRealNameInfo:(NSObject *)realnameInfo{
    real_nameInfo = realnameInfo;
}
+(NSObject *)getRealNameInfo{

    return real_nameInfo;

}


NSString * c_but;
+(void)setClickBut:(NSString *)cBut{
    c_but = cBut;
}
+(NSString *)getClickBut{
    return c_but;
}
@end
