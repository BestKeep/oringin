//
//  UserInfoModel.m
//  BESTKEEP
//
//  Created by dcj on 15/8/27.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "UserInfoModel.h"


NSString * const strPicture = @"http://cdn1.utouu.com";//图片
NSString * const str_userphoto = @"/picture/userphoto/";//用户头像



@implementation UserInfoModel

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super initWithDictionary:dict]) {
        self.photo = [NSString stringWithFormat:@"%@%@%@_M.jpg",strPicture,str_userphoto, [dict objectForKey:@"photo"]];
    }
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];

}

-(void)setUnKonwnValueKeyWithDict:(NSDictionary *)unKonwnDict{


}


@end
