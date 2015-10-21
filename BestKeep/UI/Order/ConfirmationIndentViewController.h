//
//  ConfirmationIndentViewController.h
//  BESTKEEP
//
//  Created by UTOUU on 15/8/19.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FooterView.h"
#import "HeaderView.h"
#import "ShoppingCarList.h"

@interface ConfirmationIndentViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,ClickOrderButton,headViewDelegate,UIAlertViewDelegate>
@property(nonatomic,retain) NSMutableArray *sc_array;
@property(nonatomic,copy) NSString *str_global;
@property(nonatomic,strong)NSString *formDetail;
@end
    