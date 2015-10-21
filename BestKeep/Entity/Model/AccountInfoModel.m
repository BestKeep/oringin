//
//  AccountInfoModel.m
//  BESTKEEP
//
//  Created by dcj on 15/8/28.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "AccountInfoModel.h"

@implementation AccountInfoModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"banlance"]) {
        self.banlance = [value stringValue];
    }

}
@end
