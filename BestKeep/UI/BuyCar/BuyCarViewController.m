 //
//  BuyCarViewController.m
//  BESTKEEP
//
//  Created by UTOUU on 15/8/20.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "BuyCarViewController.h"
#import "ConfirmationIndentViewController.h"
#import "Masonry.h"
#import "BKService.h"
#import "ShoppingCarList.h"
#import "UTMessageView.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "ShoppingCarCommon.h"
#import "UTMessageView.h"
#import "LoadingView.h"

#define RgbColor(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]


@interface BuyCarViewController ()<BuyCarSectionDelegate,FooterAccountViewDelegate>

@property (nonatomic,strong) NSMutableArray * dataSource;

@property (nonatomic,strong) NSMutableArray * sectionHeaderViewArray;

@end

@implementation BuyCarViewController
{

    NSMutableArray* addBtnArry;   //加号按钮的控件数组
    NSMutableArray* reduceBtnArry; //减号按钮的控件数组
    NSMutableArray* lineArray;
    
    superShopping *superSH;
    
     NSMutableArray *global_Array;
    int  jiesuan;
    UIButton  *leftButton;
}

-(void)viewDidDisappear:(BOOL)animated{
    self.view = nil;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"购物车";
    [self setCancelButton];
    self.view.backgroundColor = RgbColor(223, 223, 223);
    
    }
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.dataSource = [[NSMutableArray alloc] init];
    
   [[AFHTTPRequestOperationManager manager].operationQueue cancelAllOperations];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    if (app.isLogin) {
        [self getDataWithRequest];
        [self shoopCartList];
        [self initView];
        [_buyCarTableView reloadData];

    }
    else{
//        LoginController *loginVC = [[LoginController alloc]init];
//        BKNavigationController *nv = [[BKNavigationController  alloc] initWithRootViewController:loginVC];
//        [self presentViewController:nv animated:YES completion:nil];
    }
}
#pragma mark -- 请求相关
- (void)getDataWithRequest
{
    [LoadingView showLoadViewToView:self.view];
    __weak typeof(self)wSelf = self;
    [BKService GetShoppingCartAmontOfgoods:^(id obj,NSError* error) {
        if (error) {
            UTMessageView * messageView = [UTMessageView showEmptyMsgViewTo:self.view logoLabelText:@"" emptyText:@"加载失败！！" buttonTitle:@"重新加载" animationed:YES];
            [messageView setRetryBlock:^{
                [wSelf getDataWithRequest];
            }];
            
        }else{
        NSString* dataString = obj;
        if ([[NSString stringWithFormat:@"%@",dataString] intValue] > 0) {
            wSelf.title = [NSString stringWithFormat:@"购物车(%@)",dataString];
            leftButton.hidden = NO;
        }else{
            self.title = @"购物车";
            leftButton.hidden = YES;
        }
        }
    [LoadingView hideAllLoadViewForView:wSelf.view animated:YES];
   } view:nil];
    
}
-(void)shoopCartList{
    [LoadingView showLoadViewToView:self.view];
    __weak typeof(self)wSelf = self;
    [BKService GetShoppingCartList:^(id obj,NSError* error){
        if (error) {
            UTMessageView * messageView = [UTMessageView showEmptyMsgViewTo:self.view logoLabelText:@"" emptyText:@"加载失败！！" buttonTitle:@"重新加载" animationed:YES];
            [messageView setRetryBlock:^{
                [wSelf getDataWithRequest];
            }];
            
        }else{
        self.dataSource = [[NSMutableArray alloc] initWithArray:obj];
        if (self.dataSource.count == 0) {
            UTMessageView * messageView = [UTMessageView showEmptyMsgViewTo:self.view logoLabelText:@"\U0000e614" emptyText:@"购物车还是空的哦~" buttonTitle:@"去购物" animationed:YES];
            [messageView setRetryBlock:^{
                if (wSelf.tabBarController.tabBar.hidden == NO) {
                    wSelf.tabBarController.selectedIndex = 0;
                }else{
                    [wSelf.navigationController popViewControllerAnimated:YES];
                    //[wSelf.navigationController popToRootViewControllerAnimated:YES];
                    
                }
                
            }];
            
        }else{
            _footerAccountView.hidden = NO;
        }
        [self createHeaderView];
        [_buyCarTableView reloadData];
    }
     [LoadingView hideLoadViewToView:wSelf.view];
    } view:nil];
}
//修改订单
-(void)changeOrderWithArray:(NSMutableArray *)orderArr{
    NSMutableArray * dictArr = [[NSMutableArray alloc] init];
    [orderArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ShoppingCarList * shopCarModel = (ShoppingCarList *)obj;
        NSMutableDictionary * tempDict = [[NSMutableDictionary alloc] init];
        [tempDict setObject:shopCarModel.record_id forKey:@"id"];
        [tempDict setObject:shopCarModel.amount forKey:@"amount"];
        [dictArr addObject:tempDict];
    
    }];
    NSString * paramsStr = [Common arrayToJson:dictArr];
   // NSDictionary * data = @{paramsStr:@"data"};
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:paramsStr,@"data", nil];
    [BKService editShoppingCartGoods:nil data:data callback:^(id obj,NSError* error) {
    
    }];

}
#pragma mark - 删除购物车商品
-(void)deleteToSaveWuthOrderArr:(NSArray *)orderArr showMessage:(BOOL)show{
    NSMutableArray * orderArray = [[NSMutableArray alloc] init];
    for (ShoppingCarList * model in orderArr) {
        [orderArray addObject:model.record_id];
    }
    if (orderArray.count > 0) {
        NSString * orderStr = [orderArray componentsJoinedByString:@","];
        NSLog(@"/////////////%@",orderStr);
        __weak typeof(self)wSelf = self;
        [BKService deleteShoppingCartGoods:^(id obj,NSError* error) {
            ShoppingCarCommon *sh = (ShoppingCarCommon*)obj;
            if (sh.success) {
                [wSelf update];
            }
            if (show) {
                [ShowMessage showMessage:sh.msg];
            }
            
        } ids:orderStr view:nil];
    }
}
// 移到收藏夹
-(void)moveToSaveWithOrderArr:(NSArray *)orderArr{
    NSMutableArray * orderArray = [[NSMutableArray alloc] init];
    for (ShoppingCarList * model in orderArr) {
        [orderArray addObject:model.good_id];
    }
    
    if (orderArray.count > 0) {
        NSString * orderStr = [orderArray componentsJoinedByString:@","];
        __weak typeof(self)wSelf = self;
        [BKService addGoodsToCollect:orderStr view:nil callback:^(id obj,NSError* error) {
            ShoppingCarCommon * common = (ShoppingCarCommon *)obj;
            [wSelf deleteToSaveWuthOrderArr:orderArr showMessage:NO];
//            [wSelf update];
            [ShowMessage showMessage:common.msg];
        }];
    }
}
// 刷新数据
-(void)update{

    [self shoopCartList];
    [self getDataWithRequest];
}

#pragma mark -- 创建控件相关
-(void)createHeaderView{
    self.sectionHeaderViewArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<self.dataSource.count; i++) {
        BuyCarSectionView * sectionView =[[BuyCarSectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
        sectionView.sectionImageView.hidden = YES;
        sectionView.sectionDelegate = self;
        [self.sectionHeaderViewArray addObject:sectionView];
    }
}

- (void)initView
{
    _buyCarTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _buyCarTableView.delegate = self;
    _buyCarTableView.dataSource = self;
    _buyCarTableView.allowsSelection = NO;
    _buyCarTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _buyCarSectionView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_buyCarTableView];
    
    _footerAccountView = [[footerAccountView alloc] init];
    _footerAccountView.footerDelegate = self;
    [self.view addSubview:_footerAccountView];
    _footerAccountView.hidden = YES;
    
    [_footerAccountView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_footerAccountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(0);
        make.height.mas_equalTo(@(46));
    }];
    
    [_buyCarTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top);
        make.bottom.mas_equalTo(_footerAccountView.mas_top).offset(0);
    }];
   
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    NSLog(@"---------------%f----------------",self.view.bounds.size.height);
//}
-(void)setCancelButton{
    
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 80, 45);
    
    [leftButton setTitle:@"全部编辑" forState:UIControlStateNormal];
    [leftButton setTitle:@"完成" forState:UIControlStateSelected];
    leftButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    [leftButton addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)editAction:(UIButton *)testButton{
    
    testButton.selected = !testButton.selected;
    if (!testButton.selected) {
        NSMutableArray * allChangeOrdeArr = [self getAllOrderIsChangeOrder];
        [self changeOrderWithArray:allChangeOrdeArr];
        
        for (BuyCarSectionView * sectionView in self.sectionHeaderViewArray) {
            sectionView.sectionEdit.hidden = NO;
            sectionView.sectionLine.hidden = NO;
        }
        
    }else{
        for (BuyCarSectionView * sectionView in self.sectionHeaderViewArray) {
            sectionView.sectionEdit.hidden = YES;
            sectionView.sectionLine.hidden = YES;
        }
        
    }
    [self setAllEditStatus:testButton.selected];
    [self.footerAccountView updateFooterAccountView:[self isHaveEditStatu]];
    [self.buyCarTableView reloadData];
}

-(void)setAllEditStatus:(BOOL)isEdit{
    for (int i = 0; i<self.dataSource.count; i++) {
        [self setAllEditStatuWithSection:i edit:isEdit];
    }
}

#pragma mark TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataSource.count == 0) {
        return 0;
    }
    superShopping* shopList1 = [self.dataSource objectAtIndex:section];

    return shopList1.shopList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 6.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 104.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.sectionHeaderViewArray.count) {
        
    }else{
        return nil;
    }
    
    BuyCarSectionView * sectionView = [self.sectionHeaderViewArray objectAtIndex:section];
    superShopping* shopList1 = [self.dataSource objectAtIndex:section];
    if (shopList1.global_status1 == 1) {
        sectionView.sectionImageView.hidden = NO;
        sectionView.sectionImageView.image = [UIImage imageNamed:@"全球购.png"];
    }
    sectionView.sectionLabel.text = [NSString stringWithFormat:@"%@发货",shopList1.address];
    sectionView.index = section;
    sectionView.sectionButton.selected = [self getSectionSelectedStatu:shopList1];
    sectionView.sectionEdit.selected = [self getEditSatus:shopList1];
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BuyCarDetailCell *cell = [[BuyCarDetailCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"111"];
    if (cell) {
    cell.cellBtnDetegate = self;
    cell.addView.hidden = YES;
    
    superShopping* shopList1 = [self.dataSource objectAtIndex:indexPath.section];
    if (shopList1) {
        ShoppingCarList* cellList = shopList1.shopList[indexPath.row];
    
//    [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:cellList.goods_img] placeholderImage:[UIImage imageNamed:@"default_head.png"]];                                                          //物品图片
    cell.addView.label1.text = cellList.amount;                                                  //编辑状态下得View  有加减号
    if (cellList.sale_property) {
        cell.addView.label2.text = cellList.sale_property;      //颜色Label
    }
    
    cell.detailView.label1.text = cellList.goods_name;            //物品详情介绍
        if (cellList.sale_property) {                             //颜色
    cell.detailView.colorLabel.text = cellList.sale_property;
        }
    cell.detailView.label3.text = [NSString stringWithFormat:@"￥%@",cellList.member_price];          //会员价  价格
    cell.detailView.label5.text = [NSString stringWithFormat:@"￥%@",cellList.tax_amount];            //糖赋   税额
    cell.detailView.label6.text = [NSString stringWithFormat:@"x%@",cellList.amount];                 //多少件

    cellList.indexPahh  = indexPath;
    [cell updateCellWithModel:cellList];
    [self.footerAccountView updateAllSelectedButtonSelected:[self getAllSelectedStatus]];
    NSArray * selectedOrder = [self getSelectedOrder];
    [self.footerAccountView.button2 setTitle:[NSString stringWithFormat:@"结算(%ld)",(long)selectedOrder.count] forState:UIControlStateNormal];
    cell.button1.selected = cellList.isCellBtnSelect;
    }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}



#pragma mark -- cell代理
- (void)updataCellButtonModel:(ShoppingCarList*)sender tableViewCell:(BuyCarDetailCell *)cell
{
    
//    id sh = [self.dataSource objectAtIndex:sender.indexPahh.section];
//    [self getSectionSelectedStatu:sh];
    [self setButtonTitle:_footerAccountView.button2 withPriceLabel:_footerAccountView.label3];
    [self getSelectedOrder];
    
    [self.buyCarTableView reloadData];
}

-(void)updataCellContentData:(ShoppingCarList *)shoppingCarList tableViewCell:(BuyCarDetailCell *)cell{
    if ([shoppingCarList.amount integerValue] == 0) {
        superShopping * superShopping = [self.dataSource objectAtIndex:shoppingCarList.indexPahh.section];
        if ([superShopping.shopList containsObject:shoppingCarList]) {
            [superShopping.shopList removeObject:shoppingCarList];

        }
    }
    [self.buyCarTableView reloadData];
}

#pragma mark -- 设置model的编辑或者选中状态
-(void)setAllEditStatuWithSection:(NSInteger)section edit:(BOOL)edited{
    if (self.dataSource.count) {
        superShopping * sectionArray = [self.dataSource objectAtIndex:section];
//        int i = 0;
        if (sectionArray.shopList.count) {
            for (ShoppingCarList * shopCarModel in sectionArray.shopList) {
                shopCarModel.isEdit = edited;
//                i++;
            }
//            if (i == sectionArray.shopList.count ) {
//                leftButton.selected = YES;
//            }
//            if (i != sectionArray.shopList.count ) {
//                leftButton.selected = NO;
//            }
        }
    }
   
}
-(void)setAllSelectedStatuWithSection:(NSInteger)section selected:(BOOL)selected{
    if (self.dataSource.count) {
        superShopping * sectionArray = [self.dataSource objectAtIndex:section];
        if (sectionArray.shopList.count) {
            for (ShoppingCarList * shopCarModel in sectionArray.shopList) {
                shopCarModel.isCellBtnSelect = selected;
            }
        }

    }
}

#pragma mark -- 获得每组已经改变的order
//获得所有已经改变的订单
-(NSMutableArray *)getAllOrderIsChangeOrder{
    NSMutableArray * allIsChangedOrderArr = [[NSMutableArray alloc] init];
    [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSMutableArray * tempArr = [self getIsChangeedOrderWithSection:idx];
        [allIsChangedOrderArr addObjectsFromArray:tempArr];
    }];
    
    return allIsChangedOrderArr;
}
//获得每组已经改变的订单
-(NSMutableArray *)getIsChangeedOrderWithSection:(NSInteger)section{
    NSMutableArray * isChangeedOrderArr = [[NSMutableArray alloc] init];
    superShopping * superModel = [self.dataSource objectAtIndex:section];
    for (ShoppingCarList * tempModel in superModel.shopList) {
        if ([tempModel isOrderChanged]) {
            [isChangeedOrderArr addObject:tempModel];
        }
    }

    return isChangeedOrderArr;
}


#pragma mark -- section 代理
//这里面需要做的有改变是否编辑的状态 判断是否有订单被修改 修改订单
-(void)sectionView:(BuyCarSectionView *)sectionView editButtonClick:(UIButton *)editButton{
    [self setAllEditStatuWithSection:sectionView.index edit:editButton.selected];
    
    NSMutableArray * orderArr = [self getIsChangeedOrderWithSection:sectionView.index];
    if (orderArr.count>0) {
        [self changeOrderWithArray:orderArr];
    }
    
    if ([self getAllSelectedEditStatus]) {
        leftButton.selected = YES;
    }else{
        leftButton.selected = NO;
    }
    
    [self.buyCarTableView reloadData];
    
    [_footerAccountView updateFooterAccountView:[self isHaveEditStatu]];
}
//delegate
-(void)sectionView:(BuyCarSectionView *)sectionView sectionButtonClick:(UIButton *)sectionButton{
    [self setAllSelectedStatuWithSection:sectionView.index selected:sectionButton.selected];
    [self setButtonTitle:_footerAccountView.button2 withPriceLabel:_footerAccountView.label3];
    [self.buyCarTableView reloadData];
}


-(void)setButtonTitle:(UIButton *)sectionButton withPriceLabel:(UILabel*)priceLabel{
    NSArray * seletedOrderArr = [self getSelectedOrder];
    [sectionButton setTitle:[NSString stringWithFormat:@"结算(%ld)",(long)seletedOrderArr.count] forState:UIControlStateNormal];
    
    float i = 0.0;
    for (ShoppingCarList * tempModel in seletedOrderArr) {
        float amount = [[NSString stringWithFormat:@"%@",tempModel.amount] floatValue];
        i += [NSString stringWithFormat:@"%@",tempModel.member_price].floatValue * amount + [NSString stringWithFormat:@"%@",tempModel.tax_amount].floatValue * amount;
    }
    
    [priceLabel setText:[NSString stringWithFormat:@"￥%.2f",i]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.buyCarTableView = nil;
   self. footerAccountView = nil;   //结算
    self.buyCarSectionView = nil;  //每一组的头部
    
    self.sectionSourceArray = nil;   //头部按钮选中状态数组
    self.cellSourceArray = nil;       //cell按钮选中状态数组
    
    self.sectionBtnArray = nil;    //每一组 头部 按钮的控件数组
    self. cellBtnArray = nil;        //每一组 cell 按钮的控件数组
    self.editBtnArray = nil;       //
    if ([self.view window] == nil) {
        self.view = nil;
    }

}
#pragma mark 获得每组sectionbutton 状态
-(BOOL)getAllSelectedStatus{
    for (int i = 0; i<self.dataSource.count; i++) {
        if (![self getSectionSelectedStatu:[self.dataSource objectAtIndex:i]]) {
            return NO;
        }
    }
    return YES;
}

-(BOOL)getSectionSelectedStatu:(superShopping *)section{
    if (section.shopList.count) {
        for (ShoppingCarList * model in section.shopList) {
            if (!model.isCellBtnSelect) {
                return NO;
            }
        }
        return YES;
    }
    return NO;
}
-(BOOL)getAllSelectedEditStatus{
    for (int i = 0; i<self.dataSource.count; i++) {
        if (![self getSectionEditBtnSelectedStatu:[self.dataSource objectAtIndex:i]]) {
            return NO;
        }
    }
    return YES;
}
-(BOOL)getSectionEditBtnSelectedStatu:(superShopping *)section{
    if (section.shopList.count) {
        for (ShoppingCarList * model in section.shopList) {
            if (!model.isEdit) {
                return NO;
            }
        }
        return YES;
    }
    return NO;
}
-(BOOL)getAllEditSatus{
    for (int i = 0; i<self.dataSource.count; i++) {
        if (![self getEditSatus:[self.dataSource objectAtIndex:i]]) {
            return NO;
        }
    }
    return YES;
}

-(BOOL)getEditSatus:(superShopping *)section{
    if (section.shopList.count) {
        for (ShoppingCarList * shopIngModel in section.shopList) {
            if (shopIngModel.isEdit) {
                return YES;
            }
        }
        return NO;
    }
    return NO;
}
-(BOOL)isHaveEditStatu{
    for (int i = 0; i<self.dataSource.count; i++) {
        if([self getEditSatus:[self.dataSource objectAtIndex:i]]){
            return YES;
        }
    }
    return NO;
}
-(NSMutableArray *)getSelectedOrder{
    NSMutableArray  * selectedOrderArray = [[NSMutableArray alloc] init];
    [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSArray * sectionArray = [(superShopping *)obj shopList];
        for (ShoppingCarList * tempModel in sectionArray) {
            if (tempModel.isCellBtnSelect) {
                [selectedOrderArray addObject:tempModel];
            }
        }
    }];
    return selectedOrderArray;
}


#pragma mark -- footer 代理
-(void)setAllSelectedWithAllSelected:(BOOL)allSelected{
    __weak typeof(self)wSelf = self;
    [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [wSelf setAllSelectedStatuWithSection:idx selected:allSelected];
    }];
    
}
-(void)footerAccountView:(footerAccountView *)footerAccountView allSelectedButtonClicked:(UIButton *)allselectedButton{
    [self setAllSelectedWithAllSelected:allselectedButton.selected];
    [self setButtonTitle:_footerAccountView.button2 withPriceLabel:_footerAccountView.label3];
    [self.buyCarTableView reloadData];
    
}
-(void)footerAccountView:(footerAccountView *)footerAccountView moveToSaveButtonClicked:(UIButton *)moveToSaveButton{
    
    [self moveToSaveWithOrderArr:[self getSelectedOrder]];
    NSLog(@"移到收藏夹");
}
-(void)footerAccountView:(footerAccountView *)footerAccountView deleteButtonClicked:(UIButton *)deleteButton{
    [self deleteToSaveWuthOrderArr:[self getSelectedOrder] showMessage:YES];
    NSLog(@"删除");
}
-(void)footerAccountView:(footerAccountView *)footerAccountView calculateButtonClicked:(UIButton *)calculateButton{
    NSLog(@"结账");
    NSMutableArray * selectedOrder = [self getSelectedOrder];
    NSMutableArray *goodsinfo_array = [NSMutableArray new];
    global_Array = [NSMutableArray new];
    
    if (selectedOrder.count != 0) {
        
        for (ShoppingCarList *SC in selectedOrder) {
            NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
            [dic1 setObject:SC.good_id forKey:@"goods_id"];
            [dic1 setObject:SC.amount forKey:@"amount"];
            [dic1 setObject:SC.goods_reserve_id forKey:@"goods_reserve_id"];
                        [global_Array addObject:[NSString stringWithFormat:@"%d",SC.buyEarth]];
            [goodsinfo_array addObject:dic1];
        }
        //判断商品集合里面商品属性是否统一
        if (([global_Array indexOfObject:@"0"] != NSNotFound && [global_Array indexOfObject:@"1"] != NSNotFound)) {
            
            [ShowMessage showMessage:@"所选商品不能同时结算，请重新选择"];
        }
        else{
            ConfirmationIndentViewController *coVC = [[ConfirmationIndentViewController alloc] init];
            coVC.sc_array = goodsinfo_array;
            coVC.formDetail = @"2";
            coVC.str_global = [global_Array objectAtIndex:0];
            [self.navigationController pushViewController:coVC animated:YES];
        }
    }
    else{
        [ShowMessage showMessage:@"请选择商品"];
        
    }
}
@end