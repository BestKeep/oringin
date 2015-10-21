//
//  AppDelegate.m
//  BestKeep
//
//  Created by 魏鹏 on 15/8/18.
//  Copyright (c) 2015年 utouu. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "LoginController.h"
#import "CacheFile.h"
#import "Userinfo.h"
#import "PassportService.h"
#import "Result.h"
#import "ManagerSetting.h"
#import <TestinAgent/TestinAgent.h>
#import <AlipaySDK/AlipaySDK.h>
#import "Harpy.h"
#import "UMSocialQQHandler.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

-(BOOL)isLogin{
    NSString * ststus = [Userinfo getLoginSatuts];
    return [ststus isEqualToString:@"1"];
}
-(UserInfoModel *)userInfo{
    NSDictionary * dcit = [CacheFile loadLocalUserFile];
    return [[UserInfoModel alloc] initWithDictionary:dcit];
}
-(void)loadLocalData{
    NSDictionary * dict = [CacheFile loadLocalUserFile];
    if (dict) {
        self.userInfo = [[UserInfoModel alloc] initWithDictionary:dict];
    }else{
        self.userInfo = nil;
    }

}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
       //LoginController *home = [[LoginController alloc]init];
    [self loadLocalData];
    HomeViewController *home = [[HomeViewController alloc] init];
    //nav = [[BKNavigationController alloc] initWithRootViewController:home];
    self.window.rootViewController = home;
    [self.window makeKeyAndVisible];
    //[Harpy checkVersion];
    [self registerUMSocial];
   
    return YES;
}
-(void)registerUMSocial{
    [UMSocialData setAppKey:@"55d42806e0f55a92f0003530"];
    [UMSocialQQHandler setSupportWebView:YES];
    [TestinAgent init:@"aec7911873af48c6f4d00b323353039a" channel:@"" config:[TestinConfig defaultConfig]];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    //跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"result = %@",resultDic);
    }];
    
    return YES;
}




@end
