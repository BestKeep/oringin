
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

@interface AllOrderController ()
{
    
    NSMutableArray *_statusnameArray;
    NSMutableArray *_statusArray;
    NSMutableArray *_cityArray;
    NSMutableArray * _rowArray;
    NSArray *array1;
    OrderModel *OM;
    
    NSMutableArray *OM2_array;
    NSMutableArray *total_OM2_array;
    NSString *strStatus;
    
    UITextField *reason_textField;
   
}
@property (nonatomic,assign) NSInteger page_no;
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
    
    
    [BKService GetUserOrderdata:type pagesize:@"10" pageno:[NSString stringWithFormat:@"%ld",(long)self.page_no] view:self.view callback:^(id obj) {
        
        OM = (OrderModel*)obj;
        if (OM.success)
        {
            NSArray *temp1_array = OM.row_array;//用来存放表头和表尾数据
            if (!temp1_array)
            {
                //[ShowMessage showMessage:@"暂无订单数据"];
                
             }
            else{
                for (OrderModel1 *OM1 in temp1_array) {
                    [_cityArray addObject:OM1.deliver];
                    [_statusnameArray addObject:OM1.status_name];
                    [_statusArray addObject:OM1.status];
                    [_rowArray addObject:OM1];
                }
                array1 = OM.item_array;//分组
                for (NSArray *temp1_array in array1) {
                    OM2_array = [NSMutableArray new];
                    for (OrderModel2 *OM2 in temp1_array) {
                        [OM2_array addObject:OM2];
                    }
                    [total_OM2_array addObject:OM2_array];
                }
                if ([_rowArray count] == 0) {
                    switch (self.type) {
                        case OrderStatuViewTypeAllOrder:
                            [self picture:@"\U0000e60f" text:@"暂无订单数据"];
                            break;
                        case OrderStatuViewTypePaid:
                            [self picture:@"\U0000e60d" text:@"暂无订单数据"];
                            break;
                        case OrderStatuViewTypeUnPay:
                            [self picture:@"\U0000e60e" text:@"暂无订单数据"];
                            break;
                        case OrderStatuViewTypeWaitReceive:
                            [self picture:@"\U0000e60c" text:@"暂无订单数据"];
                            break;
                        default:
                            break;
                    }
                }
                else{
                    self.page_no = self.page_no + 1;
                    [_orderTableView reloadData];

                }
                
            }
        }
        else{
            [ShowMessage showMessage:OM.msg];
        }
        
    }];
}
-(void)picture:(NSString*)picture text:(NSString*)text{
    
    UTMessageView * messageView = [UTMessageView showEmptyMsgViewTo:self.view logoLabelText:picture emptyText:text buttonTitle:nil animationed:YES];

}
-(void)viewWillAppear:(BOOL)animated{
    
    _rowArray = [[NSMutableArray alloc] init];
    _cityArray = [NSMutableArray new];
    _statusnameArray = [NSMutableArray new];
    _statusArray = [NSMutableArray new];
    total_OM2_array = [NSMutableArray new];
    
    self.page_no = 1;
    
    [self getOrderDataWithPageNo:self.page_no];
    
    //    if (_orderTableView == nil) {
    _orderTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _orderTableView.delegate = self;
    _orderTableView.dataSource = self;
    _orderTableView.backgroundColor = [UIColor whiteColor];
    _orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self.view addSubview:_orderTableView];
    [_orderTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.top.mas_equalTo(self.view.mas_top);
    }];
    [_orderTableView reloadData];
    
    [self setTableViewRefresshView];
    [self setupRefresh];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部订单";
    self.view.backgroundColor = COLOR_03;
    
}

-(void)setupRefresh{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_orderTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_orderTableView addFooterWithTarget:self action:@selector(footerRereshinginHome)];
}

-(void)headerRereshing{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self refreshData];
        [_orderTableView reloadData];
        [_orderTableView headerEndRefreshing];
    });

}
-(void)footerRereshinginHome{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self updateData];
        [_orderTableView reloadData];
        [_orderTableView footerEndRefreshing];
        
    });

}

-(void)setTableViewRefresshView{

    
}


-(void)updateData{
    [self getOrderDataWithPageNo:self.page_no];
}
-(void)refreshData{
    self.page_no = 1;
    [self clearInfo];
    [self getOrderDataWithPageNo:self.page_no];

}
-(void)clearInfo{
    [_rowArray removeAllObjects];
    [_cityArray removeAllObjects];
    [_statusnameArray removeAllObjects];
    [_statusArray removeAllObjects];
    [total_OM2_array removeAllObjects];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AllOrderCell *cell =[tableView dequeueReusableCellWithIdentifier:@"orderCell"];
    OneCell *cell1 =[tableView dequeueReusableCellWithIdentifier:@"onecell"];
   TwoCell *cell2 =[tableView dequeueReusableCellWithIdentifier:@"twocell"];
    ThreeCell *cell3 =[tableView dequeueReusableCellWithIdentifier:@"threecell"];
    cell.backgroundColor = [UIColor clearColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell1.selectionStyle =UITableViewCellSelectionStyleNone;
    cell2.selectionStyle =UITableViewCellSelectionStyleNone;
    cell3.selectionStyle =UITableViewCellSelectionStyleNone;
    
//    if ([_rowArray count]!=0 && [total_OM2_array count]!=0) {
    OrderModel1 *OM1;
    if (_rowArray.count) {
        OM1 = [_rowArray objectAtIndex:indexPath.section];
    }
    
        NSArray *ch_array ;
    
    if (total_OM2_array.count) {
        ch_array = [total_OM2_array objectAtIndex:indexPath.section];
    }
    
        if (indexPath.row == 0) {
            if (cell ==nil) {
                cell = [[AllOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderCell"];
            }
            cell.addressLabel.text = [_cityArray objectAtIndex:indexPath.section];
            cell.orderStatusLabel.text = [_statusnameArray objectAtIndex:indexPath.section];
            cell.order_no.text = [NSString stringWithFormat:@"%@%@",@"No.",OM1.order_no];
            return cell;
        }
        else if (indexPath.row == ([ch_array count]+3-2)){
            if (cell2 == nil) {
                cell2 = [[TwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"twocell"];
            }
            
            NSString *str = [NSString stringWithFormat:@"%@%@%@",@"共",OM1.total_order_amount,@"件商品,合计:"];
            [cell2.titleLabel setText:str];
            cell2.numLabel.text = [NSString stringWithFormat:@"%@%@",@"¥",OM1.order_amount];
            
            NSString *str1 = @"";
            if ([OM1.channel_type isEqual:@"02"]) {
                str1 = [NSString stringWithFormat:@"%@%@%@%@%@",@"含运费:¥",OM1.express_amount,@",",@"海关税:¥",OM1.customs_tax_amount_total];
            }
            else{
                str1 = [NSString stringWithFormat:@"%@%@",@"含运费:¥",OM1.express_amount];
            }
            cell2.tax_label1.text = str1;
            return cell2;
        }
        else if (indexPath.row == ([ch_array count]+3-1)){
            
            cell3 = [[ThreeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"threecell"];
            cell3.delegate = self;
            cell3.button1.tag = indexPath.section;
            cell3.button2.tag = indexPath.section;
            if ([_statusArray count]) {
                if ([[_statusArray objectAtIndex:indexPath.section] isEqualToString:@"01"]){
                    cell3.button1.hidden = YES;
                    [cell3.button2 mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.width.equalTo(@(90));
                    }];

                }
                else if ([[_statusArray objectAtIndex:indexPath.section] isEqualToString:@"02"]){
                    cell3.button2.hidden = YES;
                    [cell3.button2 mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.width.equalTo(@(0));
                    }];

                }
                else{
                    cell3.button1.hidden = YES;
                    cell3.button2.hidden = YES;
                    
                }
            }
            return cell3;
            
        }
        else{
            cell1= [[OneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"onecell"];
            OrderModel2 *OM2 = [ch_array objectAtIndex:indexPath.row-1];
            [cell1.proImageView sd_setImageWithURL:[NSURL URLWithString:OM2.goods_img] placeholderImage:[UIImage imageNamed:@"default"]];//设置商品图片
            [cell1.nameLabel setText:OM2.goods_name];
            [cell1.sizeLabel setText:OM2.sale_property];
            [cell1.priceLabel1 setText:@"有糖价:"];
            [cell1.priceLabel2 setText:@"实付款:"];
            cell1.numLabel1.text = [NSString stringWithFormat:@"¥%@",OM2.member_price];
            cell1.numLabel2.text = [NSString stringWithFormat:@"¥%@",OM2.total_amount];
            NSString *total_amount = [NSString stringWithFormat:@"%@%@",@"X ",OM2.amount];
            [cell1.amountLabel setText:total_amount];
            return cell1;
        }
}
#pragma tableViewDelegate事件
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *ch_array;
//    if (isSection) {
        ch_array = [total_OM2_array objectAtIndex:section];
//    }
//    else{
//        ch_array = [total_OM2_array objectAtIndex:section+1];
//    }
//    isSection = NO;
    return [ch_array count]==0 ? 0:[ch_array count]+3;
   
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return   total_OM2_array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.00001;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   NSArray *ch_array = [total_OM2_array objectAtIndex:indexPath.section];
    if (indexPath.row == 0 ) {
        return 30;
    }
    else if (indexPath.row == [ch_array count]+1){
        return 50;
    }
    else if (indexPath.row == [ch_array count]+3-1){
        NSString *str = [_statusArray objectAtIndex:indexPath.section];
        if ([str isEqualToString:@"01"] || [str isEqualToString:@"02"]) {
            return 50;
        }
        else{
             return 0;
        }
       
    }
    else{
        return 133;
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

#pragma delegate
//付款
-(void)clickPayOrder:(NSInteger)index{
    
    OrderModel1 *OM1 = [_rowArray objectAtIndex:index];//获取订单号的对象
    CashierDeskController *cashVC = [[CashierDeskController alloc] init];
    cashVC.orderArr = [NSArray arrayWithObject:OM1.order_no];
    [self.navigationController pushViewController:cashVC animated:YES];
}
-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
}
//取消订单
-(void)clickCanelOrder:(NSInteger)index{
   
    OrderModel1 *OM1 = [_rowArray objectAtIndex:index];//获取订单号的对象
    self.order_no = OM1.order_id;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"您确认取消此订单?"
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
    reason_textField = [alert textFieldAtIndex:0];
    reason_textField.placeholder = @"请输入取消理由(必填)";

    }
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            return;
            break;
        case 1:{
            if ([reason_textField.text isEqualToString:@""]) {
                [reason_textField resignFirstResponder];
                [ShowMessage showMessage:@"请输入取消订单理由"];
            }
            else{
                [reason_textField resignFirstResponder];
                [BKService cancelOrder:self.order_no reason:reason_textField.text view:self.view callback:^(id obj) {
                    
                    ShoppingCarCommon *scc = (ShoppingCarCommon*)obj;
                    if (scc.success) {
                        [self refreshData];
                    }
                    [ShowMessage showMessage:scc.msg];
                }];
            }

            }
        break;
        default:
            break;
    }
}

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


@end
