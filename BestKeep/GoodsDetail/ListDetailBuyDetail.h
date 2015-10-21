//
//  ListDetailBuyDetail.h
//  
//
//  Created by UTOUU on 15/9/22.
//
//

#import <UIKit/UIKit.h>
@protocol selectButtonEVent <NSObject>
@optional
-(void)selectGoodsProperty:(PropertyReList*)propertyReList;

@end


@interface ListDetailBuyDetail : UITableViewCell{
    NSArray *data_array;
}

- (void)createdBtnSelectViewWithTitle:(NSMutableArray*)titleSource andBtn:(NSMutableArray*)btnSource;
- (CGSize) boundingRectWithSize:(NSString*)string Font:(UIFont*) font Size:(CGSize) size;
@property (nonatomic,strong) NSMutableArray* btnArray;
@property (nonatomic,strong) id<selectButtonEVent> delegate;
@property (nonatomic,strong) PropertyReList *propRlist;
@property (nonatomic,strong) UIButton *btn;
@property (nonatomic,strong) GoodsDataModel *goodsModel;

@end
