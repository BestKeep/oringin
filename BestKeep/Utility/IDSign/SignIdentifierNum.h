//
//  SignIdentifierNum.h
//  MobileUU
//
//  Created by 魏鹏 on 15/7/22.
//  Copyright (c) 2015年 Shanghai Pecker Network Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignIdentifierNum : NSObject
+ (BOOL)validateIDCardNumber:(NSString *)value;
@end
