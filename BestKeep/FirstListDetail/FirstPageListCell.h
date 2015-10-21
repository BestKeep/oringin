//
//  FirstPageListCell.h
//  UTOUU_TEST
//
//  Created by UTOUU on 15/9/7.
//  Copyright (c) 2015年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSpaceCell.h"

@class FirstPageListCell;
@class GoodsModel;

typedef NS_ENUM(NSUInteger, FirstPageListCellAction) {
    FirstPageListCellActionShare,
};


@protocol GoodsListCellAction <NSObject>

-(void)firstPageListCell:(FirstPageListCell *)cell action:(FirstPageListCellAction)action;

@end


@interface FirstPageListCell : BaseSpaceCell

@property (nonatomic,strong) GoodsModel * goodsModel;
@property (nonatomic,weak)id<GoodsListCellAction>delegate;



-(CGFloat)cellHeightWithModel:(GoodsModel *)model;

@end
