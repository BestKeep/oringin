
//
//  AllOrderController.m
//  BESTKEEP
//
//  Created by 魏鹏 on 15/8/25.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "AllOrderController.h"
#import "CashierDeskController.h"
#import "OneCell.h"
#import "TwoCell.h"
#import "ThreeCell.h"
#import "OrderModel.h"
#import "ShowMessage.h"
#import "ShoppingCarCommon.h"
#import "CashierDeskController.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "UIView+Position.h"
#import "UTMessageView.h"
#import "Userinfo.h"
#import "OneViewController.h"
#import "OrderInfo.h"
#import "GoodsModel.h"
#import "AllOrderFooterView.h"
#import "AllOrderHeaderView.h"

#import "LoadingView.h"
#define CANCLE_ALERT_TAG     10000

@interface AllOrderController ()<AllOrderFooterProtocol>
{

    
    UITextField *reason_textField;
   
}
@property (nonatomic,assign) NSInteger page_no;

@property (nonatomic,strong) NSMutableArray * orderList;

@property (nonatomic,retain) NSString *order_no;
@end

@implementation AllOrderController

- (void)getOrderDataWithPageNo:(NSInteger)page_no{
    NSString * type;
    switch (self.type) {
        case OrderStatuViewTypeAllOrder:
            type = @"";
            self.title = @"全部订单";
            break;
        case OrderStatuViewTypePaid:
            type = @"02";
            self.title = @"待发货订单";
            break;
        case OrderStatuViewTypeUnPay:
            type = @"01";
            self.title = @"待付款订单";
            break;
        case OrderStatuViewTypeWaitReceive:
            type = @"03";
            self.title = @"待收货订单";
            break;
        default:
            break;
    }
    if (self.orderList.count>0) {
        
    }else{
        [LoadingView showLoadViewToView:self.view];
    }
    
//    [LoadingView showLoadViewToView:self.view];
    __weak typeof(self)wSelf = self;
    
    [BKService GetUserOrderdata:type pagesize:@"10" pageno:[NSString stringWithFormat:@"%ld",(long)wSelf.page_no] view:wSelf.view callback:^(id obj,NSError* error) {
        if(error) {
            UTMessageView * messageView = [UTMessageView showEmptyMsgViewTo:self.view logoLabelText:@"" emptyText:@"加载失败！！" buttonTitle:@"重新加载" animationed:YES];
            [messageView setRetryBlock:^{
                [wSelf getOrderDataWithPageNo:wSelf.page_no];
            }];
            
        }else{
        if (obj) {
            wSelf.page_no = wSelf.page_no + 1;
        }
        for (OrderInfo * order in obj) {
            [wSelf.orderList addObject:order];
        }
        
        if (self.orderList.count) {
            [wSelf.orderTableView reloadData];
        }else{
            switch (wSelf.type) {
                case OrderStatuViewTypeAllOrder:
                    [wSelf picture:@"\U0000e60f" text:@"暂无订单数据"];
                    break;
                case OrderStatuViewTypePaid:
                    [wSelf picture:@"\U0000e60e" text:@"暂无订单数据"];
                    break;
                case OrderStatuViewTypeUnPay:
                    [wSelf picture:@"\U0000e60d" text:@"暂无订单数据"];
                    break;
                case OrderStatuViewTypeWaitReceive:
                    [wSelf picture:@"\U0000e60c" text:@"暂无订单数据"];
                    break;
                default:
                    break;
            }
            
        }
        [wSelf.orderTableView footerEndRefreshing];
        [wSelf.orderTableView headerEndRefreshing];
        }
         [LoadingView hideLoadViewToView:wSelf.view];
    }];
}
-(void)picture:(NSString*)picture text:(NSString*)text{
    
     [UTMessageView showEmptyMsgViewTo:self.view logoLabelText:picture emptyText:text buttonTitle:nil animationed:YES];

}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部订单";
    self.view.backgroundColor = COLOR_03;
    
    self.page_no = 1;
    
    self.orderList = [[NSMutableArray alloc] init];
    
    _orderTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _orderTableView.delegate = self;
    _orderTableView.dataSource = self;
    _orderTableView.backgroundColor = [UIColor clearColor];
    _orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self.view addSubview:_orderTableView];
    [_orderTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(10);
        make.top.mas_equalTo(self.view.mas_top);
    }];
    [_orderTableView reloadData];
    
    [self setupRefresh];
    [self getOrderDataWithPageNo:self.page_no];

    
}
-(void)setupRefresh{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_orderTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_orderTableView addFooterWithTarget:self action:@selector(footerRereshinginHome)];
}

-(void)headerRereshing{
    
    self.page_no = 1;
    [self clearInfo];
    [self getOrderDataWithPageNo:self.page_no];
}
-(void)footerRereshinginHome{
    [self getOrderDataWithPageNo:self.page_no];
}

-(void)clearInfo{
    [self.orderList removeAllObjects];
    
}

#pragma mark --tableViewDelegate事件
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OneCell * oneCell = [tableView dequeueReusableCellWithIdentifier:@"oneCell"];
    if (oneCell == nil) {
        oneCell = [[OneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"oneCell"];
    }
    if(self.orderList.count){
        OrderInfo * orderInfo = [self.orderList objectAtIndex:indexPath.section];
        GoodsModel * goodsInfo = [orderInfo.goodslist objectAtIndex:indexPath.row];
        oneCell.goodsInfo = goodsInfo;
    }
    
    return oneCell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    OrderInfo * orderInfo = [self.orderList objectAtIndex:section];
    return orderInfo.goodslist.count;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return   self.orderList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    AllOrderFooterView * tableFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerView"];
    if (tableFooterView == nil) {
        tableFooterView = [[AllOrderFooterView alloc] initWithReuseIdentifier:@"footerView"];
        tableFooterView.footerDelegate = self;
    }

    OrderInfo * tempOrder = [self.orderList objectAtIndex:section];
//    if ([tempOrder.status isEqualToString:@"05"]) {
//        return 50;
//    }else{
//        return 100;
//    }
    return [tableFooterView getFooterHeightWithOrder:tempOrder];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    AllOrderFooterView * tableFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerView"];
    if (tableFooterView == nil) {
        tableFooterView = [[AllOrderFooterView alloc] initWithReuseIdentifier:@"footerView"];
        tableFooterView.footerDelegate = self;
    }
    if (self.orderList.count) {
        tableFooterView.order = [self.orderList objectAtIndex:section];
    }
    
    return tableFooterView;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AllOrderHeaderView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    if (headerView == nil) {
        headerView = [[AllOrderHeaderView alloc] initWithReuseIdentifier:@"headerView"];
    }
    if (self.orderList.count) {
        headerView.orderInfo = [self.orderList objectAtIndex:section];

    }
    return headerView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    selectedCell.selected = NO;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 133;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

#pragma delegate
//付款
-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            return;
            break;
        case 1:{
            if (alertView.tag == CANCLE_ALERT_TAG) {
                if ([reason_textField.text isEqualToString:@""]) {
                    [reason_textField resignFirstResponder];
                    [ShowMessage showMessage:@"请输入取消订单理由"];
                }
                else{
                    [reason_textField resignFirstResponder];
                    [BKService cancelOrder:self.order_no reason:reason_textField.text view:self.view callback:^(id obj,NSError* error) {
                        
                        ShoppingCarCommon *scc = (ShoppingCarCommon*)obj;
                        if (scc.success) {
                            [self headerRereshing];
                        }
                        [ShowMessage showMessage:scc.msg];
                    }];
                }

            }
        }
        break;
        default:
            break;
    }
}
//确认收货

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.orderTableView = nil;
    self.order_no_array = nil;
    self.isglobal_array = nil;
}
-(void)allOrderView:(AllOrderFooterView *)footerView actionType:(AllOrderFooterActionType)type order:(OrderInfo *)order{
    
    if (type == AllOrderFooterActionTypePay) {
        [self payOrder:order];
    }else if(type == AllOrderFooterActionTypeCancle){
        [self cancleOrder:order];
    }else if(type == AllOrderFooterActionTypeConfirm){
        [self confirmOrder:order];
    }else{
        return;
    }
    
}

-(void)confirmOrder:(OrderInfo *)order{
    self.order_no = order.order_id;
    [BKService confirmReceive:self.order_no view:self.view callback:^(id obj,NSError* error) {
        ShoppingCarCommon *scc = (ShoppingCarCommon*)obj;
        if (scc.success) {
            [self headerRereshing];
        }
        [ShowMessage showMessage:scc.msg];
    }];

}

-(void)cancleOrder:(OrderInfo *)order{
    self.order_no = order.order_id;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"您确认取消此订单?"
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag = CANCLE_ALERT_TAG;
    [alert show];
    reason_textField = [alert textFieldAtIndex:0];
    reason_textField.placeholder = @"请输入取消理由(必填)";
    
}
-(void)payOrder:(OrderInfo *)order{
    
    NSString *order_string = order.order_no;
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
    __weak typeof(self)wSelf = self;
    [manager POST:strurl parameters:dic
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              
              NSString *st = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
              OneViewController *oVC = [[OneViewController alloc]init];
              oVC.oneRequest = [NSString stringWithFormat:@"%@%@%@%@",strUTOUUWeb,url_string,@"&ticket=",st];
              oVC.myTitle = @"收银台 ";
              oVC.url_strings = order_string;
              [oVC setBackAction:^{
                  [wSelf headerRereshing];
              }];
              [self.navigationController pushViewController:oVC animated:YES];
              
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              NSLog(@"Error: %@", error);
          }];
    
}


@end
