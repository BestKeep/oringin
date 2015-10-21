//
//  CashDeskBasicInfoCell.h
//  BESTKEEP
//
//  Created by dcj on 15/8/25.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CashDeskBasicInfoCell : UITableViewCell


-(void)updateCellWithOrderCount:(NSString *)orderCount andTotalMoney:(NSString *)totalMoney;

@end
