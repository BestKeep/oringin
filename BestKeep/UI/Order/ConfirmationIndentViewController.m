//
//  ConfirmationIndentViewController.m
//  BESTKEEP
//
//  Created by UTOUU on 15/8/19.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "ConfirmationIndentViewController.h"
#import "ConfirmationIndentCell.h"
#import "HeaderView.h"
#import "FooterView.h"
#import "CashierDeskController.h"
#import "HLCell.h"
#import "OrderModel.h"
#import "ShopingAddressController.h"
#import "Result.h"
#import "AddressManagerController.h"
#import "SignIdentifierNum.h"
#import "UTMessageView.h"
#import "ShoppingCarCommon.h"
#import "OneViewController.h"
#import "BKNavigationController.h"
#import "Userinfo.h"
#import "LoadingView.h"

#import "ConfirmOrderModel.h"
#import "OrderInfo.h"
#import "GoodsModel.h"
#import "ConfirmOrderHeaderView.h"

#define RgbColor(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define SCREENHIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width

@interface ConfirmationIndentViewController (){
    Result *result;
    NSString *deliver_id;
    HeaderView *headerView;
    FooterView *footerView;
    NSMutableArray *_cityArray;
    NSArray *array1;
    OrderModel *OM;
    
    NSMutableArray *OM2_array;
    NSMutableArray *total_OM2_array;
    NSArray *temp;
    NSMutableArray *order_no_Array;
    
    NSString *str_name;
    NSString *str_ident;
    
    UITextField *nameTextField;
    UITextField *identTextField;
    
    BOOL isEnough;//库存
    BOOL isPreorder;//预购
    BOOL isSpotgoods;//现货
    NSString *notEnough_shopping;//库存不足的商品名
    BOOL isFirst;
}




@property (nonatomic , strong)UITableView* indentTableView;
@property (nonatomic , strong)NSArray* sourceArray;
@property (nonatomic,strong) NSString *guide_str ;
@property (nonatomic,assign) BOOL isConfirmOrder;
@property (nonatomic,assign) BOOL isJumpCard;

@property (nonatomic,strong) ConfirmOrderModel * confirmModel;



@end

@implementation ConfirmationIndentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"确认订单";
    self.navigationController.navigationBar.backgroundColor = RgbColor(23, 169, 134);
    self.view.backgroundColor = [UIColor whiteColor];
    _cityArray = [NSMutableArray new];
    total_OM2_array = [NSMutableArray new];
    order_no_Array = [NSMutableArray new];
    isEnough = YES;
    isPreorder = NO;
    isSpotgoods = NO;
    isFirst = YES;
    [self createView];
    [self getDefaultAddress];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
   
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.view = nil;
}

-(void)getData{
    
    NSMutableDictionary *param_dic = [NSMutableDictionary dictionary];
    [param_dic setObject:self.sc_array forKey:@"goods_info"];
    [param_dic setObject:deliver_id forKey:@"deliver_id"];
    NSString *jsonstr = [Common dictionaryToJson:param_dic];
    self.guide_str = @"";
    
    [LoadingView showLoadViewToView:self.view];
    __weak typeof(self)wSelf = self;
    
    [BKService OrderInfoConfirm:jsonstr view:nil callback:^(id obj,NSError* error) {
        if(error) {
            UTMessageView * messageView = [UTMessageView showEmptyMsgViewTo:self.view logoLabelText:@"" emptyText:@"加载失败！！" buttonTitle:@"重新加载" animationed:YES];
            [messageView setRetryBlock:^{
                [wSelf getData];
            }];
            
        }else{
            wSelf.confirmModel = obj;
            [wSelf.indentTableView reloadData];
        }
        [LoadingView hideLoadViewToView:wSelf.view];
    }];
}

-(void)setConfirmModel:(ConfirmOrderModel *)confirmModel{
    _confirmModel = confirmModel;
    [self updateFooterView];
}

-(void)updateFooterView{
    footerView.orderModel = _confirmModel;

}


//-(void)getData{
//    
//    NSMutableDictionary *param_dic = [NSMutableDictionary dictionary];
//    [param_dic setObject:self.sc_array forKey:@"goods_info"];
//    [param_dic setObject:deliver_id forKey:@"deliver_id"];
//    NSString *jsonstr = [Common dictionaryToJson:param_dic];
//    self.guide_str = @"";
//    
//     [LoadingView showLoadViewToView:self.view];
//    __weak typeof(self)wSelf = self;
//    
//    [BKService OrderInfoConfirm:jsonstr view:nil callback:^(id obj,NSError* error) {
//        if(error) {
//            UTMessageView * messageView = [UTMessageView showEmptyMsgViewTo:self.view logoLabelText:@"" emptyText:@"加载失败！！" buttonTitle:@"重新加载" animationed:YES];
//            [messageView setRetryBlock:^{
//                [wSelf getData];
//            }];
//            
//        }
//        else{
//        OM = (OrderModel*)obj;
//        if (OM.success) {
//            NSArray *temp1_array = OM.row_array;//用来存放表头和表尾数据
//            temp = OM.row_array;
//            float  sh_guide = 0.00 ;
//            for (OrderModel1 *OM1 in temp1_array) {
//                [_cityArray addObject:OM1.deliver];
//                footerView.label1.text = [NSString stringWithFormat:@"%@%@%@",@"共",@"1",@"笔订单,"];
//                footerView.label2.text = @"总金额";
//                footerView.label3.text = OM1.order_amount;
//                footerView.label4.text = @"元";
//                footerView.guide_label.text = @"元";
//                footerView.guide_textlabel.text = @",产生导购金:";
//                UILabel *linkBut = [[UILabel alloc]initWithFrame:CGRectZero];
//                linkBut.textColor = [UIColor blueColor];
//                linkBut.font = [UIFont boldSystemFontOfSize:14];
//                NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:@"无会员卡"];
//                NSRange contentRange = {0, [content length]};
//                [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
//                
//                linkBut.attributedText = content;
//                linkBut.userInteractionEnabled = YES;
//                UITapGestureRecognizer *pans = [[UITapGestureRecognizer alloc]initWithTarget:wSelf action:@selector(gotoMyCard)];
//                [linkBut addGestureRecognizer:pans];
//                
//                [footerView addSubview:linkBut];
//                [linkBut mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.top.equalTo(footerView.guide_textlabel.mas_top);
//                    make.right.equalTo(footerView.guide_textlabel.mas_left);
//                    make.height.equalTo(footerView.guide_textlabel.mas_height);
//                }];
//                
//                sh_guide += [OM1.shopping_guide_amount floatValue];
//                footerView.guide_cashlabel.text = [NSString stringWithFormat:@"%.2f",sh_guide];
//                if (sh_guide == 0) {
//                    linkBut.hidden = YES;
//                    footerView.guide_label.hidden = YES;
//                    footerView.guide_textlabel.hidden = YES;
//                    footerView.guide_cashlabel.hidden = YES;
//                    
//                }
//            }
//            array1 = OM.item_array;//分组
//            //遍历分组  temp1_array 每一个分组内的元素
//            for (NSArray *temp1_array in array1) {
//                OM2_array = [NSMutableArray new];
//                for (OrderModel2 *OM2 in temp1_array) {
//                    [OM2_array addObject:OM2];
//                }
//                [total_OM2_array addObject:OM2_array];
//                
//            }
//            [_indentTableView reloadData];
//            
//        }
//        else{
//            [ShowMessage showMessage:OM.msg];
//        }
//    }
//        [LoadingView hideLoadViewToView:wSelf.view];
//    }];
//}
//

#pragma mark - 前往我的会员卡

-(void)gotoMyCard{
    
    if (self.isJumpCard) {
        return;
    }
    self.isJumpCard = YES;
    NSString *url = [strPassport stringByAppendingString:strst];
    NSString *strurl = [NSString stringWithFormat:@"%@/%@",url,[Userinfo getUserTGT]];
    NSString *value = [strBKWeb stringByAppendingString:@"profile/vip"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:value,@"service", nil];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
    NSMutableDictionary *headDic = [AppControlManager getSTHeadDictionary:dic strurl:strurl];
    //        NSMutableDictionary * headDic = [AppControlManager getSTHeadDictionary:dic];
    
    for (NSString *key in [headDic allKeys]) {
        NSString *value = [headDic objectForKey:key];
        [manager.requestSerializer setValue:value forHTTPHeaderField:key];
    }
    
    
    NSLog(@"\n--------------------->>> headParameters : %@\n", manager.requestSerializer.HTTPRequestHeaders);
    BOOL isNet = [Common checkNetWorkStatus];
    if (!isNet) {
        [ShowMessage showMessage:@"亲,您的手机网络不太顺畅"];
    }
    __weak typeof(self) wSelf = self;
    [manager POST:strurl parameters:dic
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *st = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
              OneViewController *oVC = [[OneViewController alloc]init];
              
              oVC.oneRequest = [NSString stringWithFormat:@"%@%@%@",strBKWeb,@"profile/vip?ticket=",st];
              oVC.myTitle = @"我的会员卡";
              
              wSelf.isJumpCard = NO;
              [self.navigationController pushViewController:oVC animated:YES];
               
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              wSelf.isJumpCard = NO;
              NSLog(@"Error: %@", error);
          }];
}
#pragma mark - 获取默认地址
-(void)getDefaultAddress{
    
    [DeliverAddressServer getDefaultAddress:nil callback:^(id obj,NSError* error) {
        
        result = (Result*)obj;
        if (result.success) {
            if (result.data == nil) {
                
            }
            else{
                NSDictionary *data_dic =  (NSDictionary*)result.data;
                
                if ([data_dic count] != 0) {
                    headerView.nameLabel.text = [data_dic objectForKey:@"deliver_name"];
                    headerView.cellphoneLabel.text = [data_dic objectForKey:@"deliver_mobile"];
                    headerView.addressLabel.text = [data_dic objectForKey:@"deliver_address"];
                    deliver_id = [data_dic objectForKey:@"deliver_id"];
                    [self.view addSubview:headerView];
                    [self getData];
                    footerView.hidden = NO;
                }
                else{
                    UILabel *label = [UILabel new];
                    label.text = @"请选择收货地址";
                    label.textColor = COLOR_07;
                    label.font = [UIFont systemFontOfSize:14];
                    [headerView addSubview:label];
                    [label mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(headerView.mas_centerX);
                        make.centerY.equalTo(headerView.mas_centerY);
                    }];
                    
                    footerView.hidden = YES;
                    headerView.posLabel.hidden = YES;
                    //[UTMessageView showEmptyMsgViewTo:self.view logoLabelText:@"\U0000e601" emptyText:@"暂无收藏商品" buttonTitle:nil animationed:YES];
                }
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createView
{
    //第一部分
    headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 75)];
    headerView.delegate = self;
    [self.view addSubview:headerView];
    
    
    //第三部分
    footerView = [[FooterView alloc] initWithFrame:CGRectZero];
    footerView.delegate =self;
    footerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:footerView];
    [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).mas_offset(0);
        make.left.equalTo(self.view.mas_left).mas_offset(0);
        make.bottom.equalTo(self.view.mas_bottom).mas_offset(0);
        make.height.equalTo(@(44));
    }];
    
    
    _indentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _indentTableView.delegate = self;
    _indentTableView.dataSource = self;
    _indentTableView.sectionHeaderHeight = 0;
    _indentTableView.sectionFooterHeight = 10;
    _indentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_indentTableView];
    
    [_indentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).mas_offset(0);
        make.left.equalTo(self.view.mas_left).mas_offset(0);
        make.bottom.equalTo(footerView.mas_top).mas_offset(0);
        make.top.equalTo(headerView.mas_bottom).mas_offset(0);
    }];
}
#pragma mark TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.confirmModel.orderList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSArray *ch_array;
    OrderInfo * order = [self.confirmModel.orderList objectAtIndex:section];
    return order.goodslist.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ConfirmOrderHeaderView * orderHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ConfirmOrderHeaderView"];
    if (orderHeaderView == nil) {
        orderHeaderView = [[ConfirmOrderHeaderView alloc] initWithReuseIdentifier:@"ConfirmOrderHeaderView"];
    }
    orderHeaderView.orderInfo = [self.confirmModel.orderList objectAtIndex:section];
    return orderHeaderView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    HLCell * orderFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerView"];
    if (orderFooterView == nil) {
        orderFooterView = [[HLCell alloc] initWithReuseIdentifier:@"footerView"];
    }
    orderFooterView.orderInfo = [self.confirmModel.orderList objectAtIndex:section];
    return orderFooterView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    HLCell * orderFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerView"];
    if (orderFooterView == nil) {
        orderFooterView = [[HLCell alloc] initWithReuseIdentifier:@"footerView"];
    }
    OrderInfo * orderInfo = [self.confirmModel.orderList objectAtIndex:section];
    return [orderFooterView cellHeightWithModel:orderInfo];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 163;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier1 = @"kCell1";

        ConfirmationIndentCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier1];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        if (cell1 == nil) {
            cell1 = [[ConfirmationIndentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
        }
    OrderInfo * order = [self.confirmModel.orderList objectAtIndex:indexPath.section];
    GoodsModel * goodsInfo = [order.goodslist objectAtIndex:indexPath.row];
    cell1.goodsInfo = goodsInfo;
        return cell1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - 设备

-(void)footerView:(FooterView *)footerView tapgesture:(UITapGestureRecognizer *)tapgesture{
    [self gotoMyCard];
}
-(void)ClickButtonEvent{
    if (self.isConfirmOrder) {
        return;
    }
    self.isConfirmOrder = YES;
    if (self.isConfirmOrder) {
        for (int i = 0; i <total_OM2_array.count; i++) {
            NSArray *om2_check_array = [[NSArray alloc]init];
            om2_check_array = total_OM2_array[i];
            for (int j = 0; j <om2_check_array.count; j++) {
                OrderModel2 *om2_check = [[OrderModel2 alloc]init];
                om2_check = om2_check_array[j];
                if ([om2_check.reserveFlag isEqualToString:@"0"]) {
                    isEnough = NO;
                    notEnough_shopping = om2_check.goods_name;
                }else{
                    if ([om2_check.reserveType isEqualToString:@"0"]) {
                        isPreorder = YES;
                    }else if ([om2_check.reserveType isEqualToString:@"1"]){
                        isSpotgoods = YES;
                        
                    }
                    
                }
            }
        }
#pragma mark    条件判断
        if (!isEnough) {
            NSString *msg = [NSString stringWithFormat:@"%@%@%@",@"您订购的",notEnough_shopping,@"库存不足"];
            [ShowMessage showMessage:msg withCenter:self.view.center];
            self.isConfirmOrder = NO;
        }else{
//            if (isPreorder&&isSpotgoods){
//                
//                [ShowMessage showMessage:@"预购和现货订单不能同时订购"];
//            }else
            if (isPreorder && !isSpotgoods){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"您选择的商品为预购商品，需等待全部到货后才能发货，确认订购吗?"
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles:@"确定", nil];
                alert.tag = 200;
                [alert show];
                
            }else{
                [self checkOrder];
                
            }
        }
        //    }else if (isPreorder&&!isSpotgoods){
        //
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
        //                                                        message:@"您现在所订是预购单"
        //                                                       delegate:self
        //                                              cancelButtonTitle:@"取消"
        //                                              otherButtonTitles:@"确定", nil];
        //    }

    }
   
    
    
}

-(void)checkOrder{
    
    NSString *strtag = self.str_global;
    if ([strtag isEqualToString:@"1"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请输入实名信息"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
        alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        alert.tag = 100;
        nameTextField = [alert textFieldAtIndex:0];
        identTextField = [alert textFieldAtIndex:1];
        identTextField.secureTextEntry = NO;
        identTextField.placeholder = @"请输入身份证号码";
//        identTextField.keyboardType = UIKeyboardTypeNumberPad;
        nameTextField.placeholder = @"请输入姓名";
        [alert show];
    }
    else{
        NSDictionary *param_dic = [self param:@"" identifier:@""];
        [self GetOrderIDList:param_dic];
        
    }

}
-(void)GetOrderIDList:(NSDictionary*)Json{
    
    NSString *strJson = [Common dictionaryToJson:Json];
    [BKService submitOrder:strJson view:nil callback:^(id obj,NSError* error) {
//        self.isConfirmOrder = NO;
        ShoppingCarCommon *scc = (ShoppingCarCommon*)obj;
        if (scc.success) {
             isFirst = NO;
        
            NSArray * order_list = [scc.data objectForKey:@"order_list"];
            if (order_list.count >0) {
                NSString *order_string;
                for (int i = 0; i<order_list.count; i++) {
                    if (i==0) {
                        order_string = [NSString stringWithFormat:@"%@",order_list[i]];
                    }else{
                        order_string = [NSString stringWithFormat:@"%@,%@",order_string,order_list[i]];
                        
                    }
                }
                NSString *url = [strPassport stringByAppendingString:strst];
                NSString *strurl = [NSString stringWithFormat:@"%@/%@",url,[Userinfo getUserTGT]];
                NSString *values = [strUTOUUWeb stringByAppendingString:@"pay/order?platform=app&order_no="];
                NSString *value = [values stringByAppendingString:order_string];
                NSString *url_string = [@"pay/order?platform=app&order_no=" stringByAppendingString:order_string];
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:value,@"service", nil];
                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                manager.securityPolicy.allowInvalidCertificates = YES;
                NSMutableDictionary *headDic = [AppControlManager getSTHeadDictionary:dic strurl:strurl];
                //        NSMutableDictionary * headDic = [AppControlManager getSTHeadDictionary:dic];
                
                for (NSString *key in [headDic allKeys]) {
                    NSString *value = [headDic objectForKey:key];
                    [manager.requestSerializer setValue:value forHTTPHeaderField:key];
                }
                
                
                NSLog(@"\n--------------------->>> headParameters : %@\n", manager.requestSerializer.HTTPRequestHeaders);
                BOOL isNet = [Common checkNetWorkStatus];
                if (!isNet) {
                    [ShowMessage showMessage:@"亲,您的手机网络不太顺畅"];
                }
                __weak typeof(self) wSelf = self;
                [manager POST:strurl parameters:dic
                      success:^(AFHTTPRequestOperation *operation,id responseObject) {
                          NSString *st = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                          wSelf.isConfirmOrder = NO;
                          OneViewController *oVC = [[OneViewController alloc]init];
                          oVC.oneRequest = [NSString stringWithFormat:@"%@%@%@%@",strUTOUUWeb,url_string,@"&ticket=",st];
                          
                          if ([self.formDetail isEqualToString:@"1"]) {
                              oVC.myTitle = @"收银台";
                              
                          }else if ([self.formDetail isEqualToString:@"2"]){
                              oVC.myTitle = @" 收银台";
                          }
                          else{
                              oVC.myTitle = @"收银台 ";
                          }
                          oVC.url_strings = order_string;
                          [wSelf.navigationController pushViewController:oVC animated:YES];
                          
                      }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                          wSelf.isConfirmOrder = NO;
                          NSLog(@"Error: %@", error);
                      }];
                
            }else{
                self.isConfirmOrder = NO;
                [ShowMessage showMessage:@"您没有选择有效的商品"];
             }
            
             //            CashierDeskController *cashVC = [[CashierDeskController alloc] init];
            //            cashVC.orderArr = [scc.data objectForKey:@"order_list"];
            //            [self.navigationController pushViewController:cashVC animated:YES];
            
        }
        else{
            self.isConfirmOrder = NO;
            [ShowMessage showMessage:scc.msg];
        }
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        switch (buttonIndex) {
            case 0:
                self.isConfirmOrder = NO;
                return;
                break;
            case 1:{
                [identTextField resignFirstResponder];
                if ([identTextField.text isEqualToString:@""]||[nameTextField.text isEqualToString:@""]) {
                    [ShowMessage showMessage:@"请输入实名信息"];
                    self.isConfirmOrder = NO;
                }else if (![SignIdentifierNum validateIDCardNumber:identTextField.text]){
                    [ShowMessage showMessage:@"请输入正确的身份证号码"];
                    self.isConfirmOrder = NO;
                }
                else{
                    NSDictionary *param_dic = [self param:nameTextField.text identifier:identTextField.text];
                    [self GetOrderIDList:param_dic];
                    
                }
            }
            default:
                break;
                
        }
    }else if (alertView.tag == 200){
        switch (buttonIndex) {
            case 0:
                self.isConfirmOrder = NO;
                return;
                break;
            case 1:{
                NSDictionary *param_dic = [self param:@"" identifier:@""];
                [self GetOrderIDList:param_dic];
                
            }
            default:
                break;
        }
    }
}
-(void)tapHeaderViewEvent{
    AddressManagerController *shopAddress = [[AddressManagerController alloc] init];

    [shopAddress setSelectedAddressCompeletion:^(DeliverAddress *selectedAddress) {
        if (selectedAddress) {
            deliver_id = selectedAddress.deliverId;
             [headerView updateHeaderViewWithModel:selectedAddress];
        }else{
            return ;
        }
    }];
    [self.navigationController pushViewController:shopAddress animated:YES];
}
#pragma mark - 提交订单字典参数
-(NSDictionary*)param:(NSString*)name identifier:(NSString*)stridentifier{
    //    NSMutableArray *goods_info_array = [NSMutableArray new];
    NSMutableArray *orders_info_array = [NSMutableArray new];
    //    for (OrderModel2 *OM2 in OM2_array) {
    //
    //    }
    //    for (OrderModel1 *OM1 in OM.row_array) {
    //
    //    }
    
    for (int i = 0; i<OM.row_array.count; i++) {
        OrderModel1 * OM1 = [OM.row_array objectAtIndex:i];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        NSMutableArray * goodsInfoArr = [[NSMutableArray alloc] init];
        for (OrderModel2 * OM2 in [OM.item_array objectAtIndex:i]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:OM2.goods_id forKey:@"goods_id"];
            [dic setObject:OM2.amount forKey:@"amount"];
            [dic setObject:OM2.goods_reserve_id forKey:@"goods_reserve_id"];
            [goodsInfoArr addObject:dic];
        }
        
        [dic setObject:goodsInfoArr forKey:@"goods_info"];
        [dic setObject:OM1.deliver_code forKey:@"deliver_address"];
        [dic setObject:OM1.express_companyid forKey:@"express_companyid"];
        [orders_info_array addObject:dic];
    }
    
    NSMutableDictionary *total_dic = [NSMutableDictionary dictionary];
    [total_dic setObject:orders_info_array forKey:@"orders_info"];
    NSString *s = checkNull(deliver_id);
    [total_dic setObject:s forKey:@"deliver_id"];
    [total_dic setObject:@"3" forKey:@"source_code"];
    [total_dic setObject:name forKey:@"identitycardname"];//身份证姓名
    [total_dic setObject:stridentifier forKey:@"identitycardno"];//身份证号码
    return total_dic;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [nameTextField resignFirstResponder];
    [identTextField resignFirstResponder];
    
}
@end
