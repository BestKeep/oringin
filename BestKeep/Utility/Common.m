//
//  Common.m
//  UTOUU
//
//  Created by 魏鹏 on 15/3/17.
//  Copyright (c) 2015年 utouu. All rights reserved.
//

#import "Common.h"
//#import "NavigationViewController.h"
#import "MBProgressHUD.h"
#import "UIColor+CJCategory.h"
#import "NSString+CJCategory.h"
#import "HCRKeyChain.h"
#import "LoginController.h"
#import "Reachability.h"
#import "PrefixHeader.pch"
#import "Userinfo.h"
#import "AppDelegate.h"

#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )

//颜色
//#define COLOR_01 [UIColor fromHexValue:0xE5E5E5] // 白色
//#define COLOR_02 [UIColor fromHexValue:0x333333] // 黑色
//#define COLOR_03 [UIColor fromHexValue:0x666666] // 灰色
//#define COLOR_06 [UIColor fromHexValue:0xE4E4E4] // 浅灰
//#define COLOR_04 [UIColor fromHexValue:0x990033] // 紫红色
//#define COLOR_05 [UIColor fromHexValue:0xFF3366] // 浅红色
//#define COLOR_07 [UIColor fromHexValue:0x009966] // 绿色
//#define COLOR_08 [UIColor fromHexValue:0x999999] // 中灰
//#define COLOR_09 [UIColor fromHexValue:0xcccccc]
//
//#define COLOR_10 [UIColor fromHexValue:0xFF9800];
//#define COLOR_11 [UIColor fromHexValue:0x9833FF];
//#define COLOR_12 [UIColor fromHexValue:0x66CBCB];
//#define COLOR_13 [UIColor fromHexValue:0xCC0099];


@implementation Common

//毫秒数转换为日期字符串
+(NSString *)longToDateString:(NSString *)longString{
    NSDateFormatter *dateFormatter;
    dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *d = [[[NSDate alloc]initWithTimeIntervalSince1970:[longString longLongValue]/1000.0] autorelease];
    NSString *str = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:d]];
     return str ;

}

+ (void)setTabbarItem:(UIViewController *)viewCtr title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName index:(NSInteger)index{
    UIImage *image = [UIImage imageNamed:imageName];
    if (SysVer >= 7.0) {
        UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewCtr.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectedImage];
        viewCtr.tabBarItem.tag = index;
        
    } else {
        viewCtr.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image tag:index];
    }
    if (SysVer >= 5.0) {
        [viewCtr.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLOR_04, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    }

    
}
//+ (void)setTabbarItem:(UIViewController *)viewCtr title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName index:(NSInteger)index {
//    UIImage *image = [UIImage imageNamed:imageName];
//    if (SysVer >= 7.0) {
//        UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
//        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        viewCtr.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectedImage];
//        viewCtr.tabBarItem.tag = index;
//        
//    } else {
//        viewCtr.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image tag:index];
//    }
//    if (SysVer >= 5.0) {
//        [viewCtr.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
//    }
//}
+(void)SetSubViewExternNone:(UIViewController *)viewController
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ( IOS7_OR_LATER )
    {
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
        viewController.extendedLayoutIncludesOpaqueBars = NO;
        viewController.modalPresentationCapturesStatusBarAppearance = NO;
        viewController.navigationController.navigationBar.translucent = NO;
    }
#endif  // #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
}

//保存用户头像文件
+(void)saveUserImage:(NSString*)strlogo{
    NSURL* url = [NSURL URLWithString:[strlogo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];//网络图片url
    NSData* data = [NSData dataWithContentsOfURL:url];//获取网络图片数据
    UIImage *user_image = [UIImage imageWithData:data];
    NSData *imageData = UIImagePNGRepresentation(user_image); //PNG格式
    [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"userImage"];
    
}

//+(void)DDMenuController:(DDMenuController*)menuController UIViewController:(UIViewController*)viewController{
//    @autoreleasepool {
//        NavigationViewController  *navController = [[NavigationViewController alloc] initWithRootViewController:viewController];
//        [menuController setRootController:navController animated:YES];
//    }
//}

//弹出提示框
+(void)AlertViewTitle:(NSString*)title message:(NSString*)message delegate:(id)delegate cancelButtonTitle:(NSString*)canceltitle otherButtonTitles:(NSString*)othertitle{
    @autoreleasepool {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:title
                                                         message:message
                                                        delegate:delegate
                                               cancelButtonTitle:canceltitle
                                               otherButtonTitles:othertitle,nil] autorelease];
        [alert show];
 
    }
}

+ (NSString*)md5HexDigest:(NSString*)str{
    const char* cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (NSInteger i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x", result[i]];
    }
    return ret;
}
#pragma mark - 获取UDID

+ (NSString *)createUDID{
    NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[HCRKeyChain load:KEY_USERNAME_PASSWORD];
    NSString *UniqueId = [usernamepasswordKVPairs objectForKey:KEY_USERNAME];
    NSString *sUDID;
    if ([UniqueId length] <= 0)
    { //写入
        UIDevice *ud = [UIDevice currentDevice];
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0){
            CFUUIDRef uuid = CFUUIDCreate(NULL);
            CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
            NSString *uuidString = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidStr));
            CFRelease(uuidStr);
            CFRelease(uuid);
            UniqueId = uuidString;
        }
        else{
            UniqueId = [[ud identifierForVendor] UUIDString];
        }
        NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
        [usernamepasswordKVPairs setObject:UniqueId forKey:KEY_USERNAME];
        [HCRKeyChain save:KEY_USERNAME_PASSWORD data:usernamepasswordKVPairs];
        return UniqueId;
    }
    else{
        sUDID = UniqueId;
    }
    return UniqueId;
}

+(void)LoginController{
       
    UIWindow *keywindow = [[UIApplication sharedApplication].delegate window];
    [Userinfo setUserTGT:@""];
    [Userinfo setLoginSatuts:@"0"];
    [Userinfo setST:@"UTOUU-ST-INVALID"];
    LoginController *loginVC = [[LoginController alloc] init];
   BKNavigationController * navc = [[BKNavigationController alloc] initWithRootViewController:loginVC];
   [keywindow.rootViewController presentViewController:navc animated:YES completion:nil];


}

+ (void)showAlertViewWith:(NSString *)title message:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}
+ (NSString*)getAppVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
     NSString *app_Version = [NSString stringWithFormat:@"%@.%@",[infoDictionary objectForKey:@"CFBundleShortVersionString"],[infoDictionary objectForKey:@"CFBundleVersion"]];
    return app_Version;

}
#pragma mark -  字典转json
+ (NSString*)dictionaryToJson:(NSDictionary *)dic{
    NSError *parseError = nil;
    NSData *jsonData = nil;
    if (dic == nil) {
        return nil;
    }
    else{
        jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
        NSString *str = [[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] autorelease];
        return str;
     }
}
+(NSString *)arrayToJson:(NSArray *)arr{
    NSError *parseError = nil;
    NSData *jsonData = nil;
    if (arr == nil) {
        return nil;
    }
    else{
        jsonData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&parseError];
        NSString *str = [[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] autorelease];
        return str;
    }
    
}
#pragma mark -  json转字典
+ (NSDictionary*)JsonTodictionary:(NSString *)jsonstr;{
    
    if (jsonstr == nil) {
        return nil;
    }
    else{
        NSDictionary *dic = [jsonstr JSONValue];
        return dic;
    }
}
+(BOOL)checkNetWorkStatus;{
    if ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable) {
        
        return YES;
    }
    else if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable) {
        
        return YES;
    }
    else{
        return NO;
    }
}
+ (CGSize) boundingRectWithSize:(NSString*)string Font:(UIFont*) font Size:(CGSize) size
{
    CGSize _size;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine |
    
    NSStringDrawingUsesLineFragmentOrigin |
    
    NSStringDrawingUsesFontLeading;
    
    _size = [string boundingRectWithSize:size options: options attributes:attribute context:nil].size;
    
#else
    
    _size = [string sizeWithFont:font constrainedToSize:size];
    
#endif
    
    _size.height += 10;
    _size.width += 10;
    return _size;
    
}


+(BOOL)isLogin{
    AppDelegate * appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
      return appdelegate.isLogin;
}

@end
