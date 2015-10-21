//
//  HomeViewController.m
//  BestKeep
//
//  Created by 魏鹏 on 15/8/18.
//  Copyright (c) 2015年 utouu. All rights reserved.
//

#import "HomeViewController.h"
#import "BKNavigationController.h"
#import "AppDelegate.h"
#import "LoginController.h"

@implementation HomeViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"BestKeep";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    [self setupSubviews];
}

-(void)setupSubviews{
    oneVC = [[OneViewController alloc] init];
    twoVC = [[TwoViewController alloc] init];
    confVC = [[ConfirmationIndentViewController alloc]init];
    userCenterVC = [[UserCenterViewController alloc] init];
    buyVC = [[BuyCarViewController alloc] init];
    firstVC = [[FirstPageViewController alloc] init];
    BKNavigationController *nav1 = [[BKNavigationController alloc] initWithRootViewController:firstVC];
    BKNavigationController *nav2 = [[BKNavigationController alloc] initWithRootViewController:twoVC];
    BKNavigationController *nav3 = [[BKNavigationController alloc] initWithRootViewController:buyVC];
    BKNavigationController *nav4 = [[BKNavigationController alloc] initWithRootViewController:userCenterVC];
    
    [Common setTabbarItem:nav1 title:@"首页" image:@"home" selectedImage:@"homefill" index:0];
    [Common setTabbarItem:nav2 title:@"U7" image:@"uphone" selectedImage:@"uphonefill" index:1];
    [Common setTabbarItem:nav3 title:@"购物车" image:@"cart" selectedImage:@"cartfill" index:2];
    [Common setTabbarItem:nav4 title:@"我的" image:@"iconfont-my" selectedImage:@"myfill" index:3];
    self.viewControllers = @[nav1,nav2,nav3,nav4];
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    switch (item.tag) {
        case 0:{
          
        }
            break;
        case 1:{
            
        }
            break;
        case 2:{
            if (![self isLogin]) {
                LoginController *loginVC = [[LoginController alloc] init];;
                BKNavigationController *bkVC = [[BKNavigationController alloc] initWithRootViewController:loginVC];
                [self presentViewController:bkVC animated:YES completion:nil];
            }
        }
            break;
        case 3:{
            
        }
        default:
            break;
    }
}
-(BOOL)isLogin{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    return app.isLogin;
}

@end
