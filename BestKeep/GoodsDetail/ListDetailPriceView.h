//
//  ListDetailPriceView.h
//  
//
//  Created by UTOUU on 15/9/21.
//
//

#import <UIKit/UIKit.h>

@interface ListDetailPriceView : UITableViewCell

@property (nonatomic , strong) UILabel* headLabel;

@property (nonatomic , strong) UILabel* line1;

@property (nonatomic , strong) UILabel* VIPLabel;

@property (nonatomic , strong) UILabel* VIPPrice;

@property (nonatomic , strong) UILabel* marketLabel;

@property (nonatomic , strong) UILabel* marketPrice;

@property (nonatomic , strong) UILabel* line2;

@property (nonatomic , strong) UILabel* tangLabel;

@property (nonatomic , strong) UILabel* adressLabel;

@property (nonatomic , strong) UIView* footerView;

@property (nonatomic , strong) UILabel* jiangImage;

@property (nonatomic , strong) UILabel* dataLabel;

@property (nonatomic , strong) UILabel* gongxianzhiLabel;
@property(nonatomic,strong) GoodsDataModel *goodsModel;

@end
