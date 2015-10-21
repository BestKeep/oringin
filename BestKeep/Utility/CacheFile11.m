//
//  CacheFile.m
//  MobileUU
//=========================
//1.0 UDID写入缓存                  万黎君
//1.1 将TGT存入写到字典的最后         万黎君
//1.2讲USERID雪如缓存                万黎君
//=========================
//  Created by 王義傑 on 14-5-31.
//  Copyright (c) 2014年 Shanghai Pecker Network Technology Co., Ltd. All rights reserved.
//

#import "CacheFile.h"
#import "InterfaceURLs.h"
#import "Userinfo.h"

@implementation CacheFile

+(void) WriteToFileWithDict:(NSDictionary *)dict
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"usercache.plist"];
    NSLog(@"%@",plistPath);

    
    //判断是否以创建文件
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        /*
         注意：此方法更新和写入是共用的
         */
        NSString *st;
        if ([Userinfo getST]==nil) {
            st = @"";
        }else{
            st = [Userinfo getST];
        }
        
        NSMutableDictionary *data = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                              
                              [Userinfo getCellPhone],@"account",
                              
                              [Userinfo getLoginSatuts],@"loginstatus",
                              st,@"st",
                              [Userinfo getUserTGT],@"tgt",
                              [Userinfo getUserid],@"userid",
                              

                              
                              nil];
        
        [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [data setObject:obj forKey:key];
        }];
        
        //写入文件
        
        NSFileManager *fm = [NSFileManager defaultManager];
        
        [fm createFileAtPath:plistPath contents:nil attributes:nil];
        
        [data writeToFile:plistPath atomically:YES];
        
        NSLog(@"文件已存在:%@",data);
    }
    else
    {
        //        NSString *photo = [NSString stringWithFormat:@"%@%@", strUtouu,[dicLogin objectForKey:@"pictureurl"]];
        //如果没有plist文件就自动创建
        
        
        NSString *st;
        if ([Userinfo getST]==nil) {
            st = @"";
        }else{
            st = [Userinfo getST];
        }
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                              
                              st,@"st",
                              [Userinfo getPWD],@"pwd",
                              
                              [Userinfo getCellPhone],@"account",
                              
                              [Userinfo getLoginSatuts],@"loginstatus",
                              
                              [Userinfo getUserTGT],@"tgt",
                              [Userinfo getUserid],@"userid",
                              

                              nil];
        
        //写入文件
        
        NSFileManager *fm = [NSFileManager defaultManager];
        
        [fm createFileAtPath:plistPath contents:nil attributes:nil];
        
        [data writeToFile:plistPath atomically:YES];
        NSLog(@"写入data:%@",data);
    }
}


+(NSDictionary *)loadLocalUserFile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"usercache.plist"];
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        
        [Userinfo setUserName:[dictionary objectForKey:@"username"]];
        
        [Userinfo setCellPhone:[dictionary objectForKey:@"loginName"]];
        
        [Userinfo setLoginSatuts:[dictionary objectForKey:@"loginstatus"]];
        
        [Userinfo setUserTGT:[dictionary objectForKey:@"tgt"]];
        
        [Userinfo setPWD:[dictionary objectForKey:@"pwd"]];
        
        [Userinfo setCellPhone:[dictionary objectForKey:@"account"]];
        
        [Userinfo setST:[dictionary objectForKey:@"st"]];
        [Userinfo setUserid:[dictionary objectForKey:@"userid"]];
        
        
        NSLog(@"读取data:%@",dictionary);
        return dictionary;
    }else{
        return nil;
    }
    
}


//+(BOOL)isOutDate{
//
//
//}


@end
