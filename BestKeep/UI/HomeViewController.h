//
//  HomeViewController.h
//  BestKeep
//
//  Created by 魏鹏 on 15/8/18.
//  Copyright (c) 2015年 utouu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneViewController.h"
#import "TwoViewController.h"
#import "UserCenterViewController.h"
#import "BuyCarViewController.h"
#import "ConfirmationIndentViewController.h"
#import "FirstPageViewController.h"
@interface HomeViewController : UITabBarController<UITabBarControllerDelegate>{
    OneViewController *oneVC;
    TwoViewController *twoVC;
    UserCenterViewController *userCenterVC;
    // PhoneViewController *phoneVC;
    ConfirmationIndentViewController *confVC;
    BuyCarViewController *buyVC;
    FirstPageViewController *firstVC;
}

@end
