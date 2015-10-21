//
//  CollectionList.h
//  BESTKEEP
//
//  Created by 魏鹏 on 15/8/27.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionList : NSObject
@property(nonatomic)BOOL success;
@property(nonatomic,copy) NSString *msg;
@property(nonatomic,copy) NSString *code;
@property(nonatomic,copy) NSString *pageno;
@property(nonatomic,copy) NSString *total;
@property(nonatomic,copy) NSString *collect_id;
@property(nonatomic,copy) NSString *goods_no;
@property(nonatomic,copy) NSString *goods_img_small;
@property(nonatomic,copy) NSString *goods_img_big;
@property(nonatomic,copy) NSString *goods_name;
@property(nonatomic,copy) NSString *market_price;
@property(nonatomic,copy) NSString *member_price;

@property(nonatomic,retain) NSMutableArray *listArray;

@end
