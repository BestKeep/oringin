//
//  ConfirmOrderHeaderView.m
//  BESTKEEP
//
//  Created by dcj on 15/10/21.
//  Copyright © 2015年 YISHANG. All rights reserved.
//

#import "ConfirmOrderHeaderView.h"

@implementation ConfirmOrderHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.orderStatusLabel.hidden = YES;
        self.order_no.hidden = YES;
        self.singleLine.hidden = YES;
    }
    return self;
}



@end
