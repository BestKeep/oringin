//
//  PropertyList.h
//  BESTKEEP
//
//  Created by 魏鹏 on 15/10/9.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PropertyReList;

@interface PropertyList : NSObject

@property(nonatomic,copy) NSString *code;
@property(nonatomic,copy) NSString *createDate;
@property(nonatomic,copy) NSString *createDateStr;
@property(nonatomic,copy) NSString *goods_id;
@property(nonatomic,copy) NSString *imgFlag;
@property(nonatomic,copy) NSString *imgFlagStr;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *updatedDate;
@property(nonatomic,copy) NSString *updateDateStr;
@property(nonatomic,strong) NSArray *propertyRelList;

@end
