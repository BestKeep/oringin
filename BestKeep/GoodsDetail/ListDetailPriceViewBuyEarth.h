//
//  ListDetailPriceViewBuyEarth.h
//  
//
//  Created by UTOUU on 15/10/16.
//
//

#import <UIKit/UIKit.h>

@interface ListDetailPriceViewBuyEarth : UITableViewCell

@property (nonatomic , strong) UILabel* headLabel;

@property (nonatomic , strong) UILabel* line1;

@property (nonatomic , strong) UILabel* VIPLabel;

@property (nonatomic , strong) UILabel* VIPPrice;

@property (nonatomic , strong) UILabel* marketLabel;

@property (nonatomic , strong) UILabel* marketPrice;

@property (nonatomic , strong) UILabel* line2;

@property (nonatomic , strong) UILabel* tangLabel; //糖赋

@property (nonatomic , strong) UILabel* haiguan; //海关赋

@property (nonatomic , strong) UILabel* mianLabel; //免

@property (nonatomic , strong) UILabel* mianzheng; //免征

@property (nonatomic , strong) UILabel* adressLabel; //发货地

@property (nonatomic , strong) UILabel* redLabel; //红色展示Label

@property (nonatomic , strong) UILabel* detailLabel; // 全球购说明LABEL

@property (nonatomic , strong) UIView* footerView;

@property (nonatomic , strong) UILabel* jiangImage;

@property (nonatomic , strong) UILabel* dataLabel;

@property (nonatomic , strong) UILabel* gongxianzhiLabel;

@property(nonatomic,strong) GoodsDataModel *goodsModel;


@end
