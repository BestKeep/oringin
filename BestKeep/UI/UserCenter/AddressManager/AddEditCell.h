//
//  AddEditCell.h
//  BESTKEEP
//
//  Created by cunny on 15/8/27.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTLabel.h"
@interface AddEditCell : UITableViewCell
@property(nonatomic,strong)BTLabel *messageLabel;
@property(nonatomic,strong)UITextField *messageText;
@property (nonatomic) NSInteger text_tag;
@end
