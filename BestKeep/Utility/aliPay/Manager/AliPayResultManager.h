//
//  AliPayResultManager.h
//  BESTKEEP
//
//  Created by dcj on 15/9/15.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "BaseObject.h"
#import "ALiPayResult.h"

@interface AliPayResultManager : BaseObject

+(instancetype)sharedInstance;

-(ALiPayResult *)analyzeResultDict:(NSDictionary *)resultDict;

@end
