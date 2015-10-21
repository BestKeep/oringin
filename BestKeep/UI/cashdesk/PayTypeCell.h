//
//  PayTypeCell.h
//  BESTKEEP
//
//  Created by dcj on 15/8/25.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountInfoModel.h"

@interface PayTypeCell : UITableViewCell


-(void)updateAccountInfoWithModel:(AccountInfoModel *)mdoel andMoney:(NSString *)totalMoney;

@end

@interface PayMoneyLabel : UIView

-(void)updateMoneyWith:(NSString *)money;

@end
