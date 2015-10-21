//
//  FirstPageListDetailViewController.h
//  
//
//  Created by UTOUU on 15/9/18.
//
//

#import <UIKit/UIKit.h>
#import "ListDetailBuyView.h"
#import "ListDetailBuyDetail.h"
#import "ListDetialBuyFooterView.h"
#import "ListDetailPriceViewBuyEarth.h"

typedef NS_ENUM(NSUInteger, GoodsImageType) {
   goodsShowImage,
   goodsDetailImage,
   goodsIMAGE
};

typedef NS_ENUM(NSUInteger, ButtonTag) {
    ADDBUYCAR = 100,
    ATONCEBUY ,
};


@interface FirstPageListDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,selectButtonEVent>{
     NSArray *data_array;
}
@property(nonatomic) NSUInteger buttontag;
@property(nonatomic,copy) NSString *readyBuy;
@property(nonatomic,strong) NSString *goods_no;
@property(nonatomic,strong) NSString *ids;
@property(nonatomic,strong) NSMutableDictionary *select_dic;
@property(nonatomic,strong) NSMutableDictionary *result_dic;
@property(nonatomic,strong) ReserveList *reserveListModel;
@property(nonatomic,strong) NSMutableDictionary *orderInfo_dic;
@property(nonatomic,strong) NSMutableArray *param_array;
@property(nonatomic,strong) NSMutableArray *image1_array;
@property(nonatomic,strong) NSMutableArray *image2_array;
@property(nonatomic,strong) NSMutableArray *image3_array;
@property(nonatomic,strong) NSMutableArray *proname_arry;
@property(nonatomic,strong) UIButton *btn;
//@property(nonatomic,strong) NSMutableArray * mut_array1;
//@property(nonatomic,strong) NSMutableArray * mut_array;

@property(nonatomic,strong) UIImage *image3;
@property(nonatomic,copy) NSString *saveCount;
@property(nonatomic) BOOL isSelect;
@property(nonatomic) BOOL isx;
@property(nonatomic,copy) NSString *strpay;
@property(nonatomic) BOOL isCount;
@end
