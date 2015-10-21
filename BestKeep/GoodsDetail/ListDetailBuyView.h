//
//  ListDetailBuyView.h
//  
//
//  Created by UTOUU on 15/9/21.
//
//

#import <UIKit/UIKit.h>

@interface ListDetailBuyView : UIView

@property (nonatomic , strong) UIView* bgView;
@property (nonatomic , strong) UILabel* line;
@property (nonatomic , strong) UIImageView* detailImageView;
@property (nonatomic , strong) UILabel* priceLabel;
@property (nonatomic , strong) UILabel* saveLabel;
@property (nonatomic , strong) UILabel* colorLabel;
@property (nonatomic , strong) UIButton* cancelBtn;
@property (nonatomic,retain) NSMutableArray *imgList_Array;
@property (nonatomic,retain) GoodsDataModel *goodsDataModel;
@property (nonatomic,copy) NSString *ready_buy;
@property (nonatomic,copy) NSString *reservice;


@end
