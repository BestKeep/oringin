//
//  ALiPayResultModel.h
//  BESTKEEP
//
//  Created by dcj on 15/9/15.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "BaseObject.h"

@interface ALiPayResult : BaseObject

@property (nonatomic,strong) NSError* error;
@property (nonatomic,copy) NSString * message;
@property (nonatomic,copy) NSString * result;
@property (nonatomic,copy) NSString * memo;
@property (nonatomic,copy) NSString * resultStatus;

@end
