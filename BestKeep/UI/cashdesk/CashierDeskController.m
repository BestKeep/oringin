//
//  CashierDeskController.m
//  BESTKEEP
//
//  Created by dcj on 15/8/25.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "CashierDeskController.h"
#import "PayTypeCell.h"
#import "UIView+Position.h"
#import "CashDeskBasicInfoCell.h"
#import "CashDeskService.h"
#import "AllOrderController.h"
#import "ShoppingCarCommon.h"
#import "BKNavigationController.h"
#import "BuyCarViewController.h"
#import "RechargeController.h"

#import "UTMessageView.h"
#import "LoadingView.h"
@interface CashierDeskController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UILabel *leftButton;
    UILabel *yuanLabel;
    UILabel *banlanceLabel;
    UILabel *linkLabel;
    
}
@property(nonatomic,strong)    NSArray *order_list_array;


@property (nonatomic,strong) UITableView * cashierDeskTableView;
@property (nonatomic,strong) UIButton * confirmButton;
@property (nonatomic,strong) NSMutableArray * accountArr;
@property (nonatomic,copy) NSString * accountTotal;
@property (nonatomic,strong)AccountInfoModel * selectedModel;
@property (nonatomic,strong) NSString * banlances;


@end

@implementation CashierDeskController

#pragma mark -提交订单接口 获取订单列表号

-(void)GetOrderIDList{
    
}

#pragma mark - 订单总金额计算
#pragma mark - 取消左边按钮
-(void)setCancelButton{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 25, 25);
    UILabel *deleteLabel = [[UILabel alloc] initWithFrame:rightButton.frame];
    deleteLabel.font=[UIFont fontWithName:@"iconfont" size:20];
    deleteLabel.textColor = [UIColor whiteColor];
    deleteLabel.text = @"\U0000e623";
    [rightButton addSubview:deleteLabel];
    [rightButton addTarget:self action:@selector(cancelallchange) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}
-(void)cancelallchange{
    [self.navigationController popToRootViewControllerAnimated:YES ];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self GetOrderIDList];
    
    self.view.backgroundColor = COLOR_03;
    [self.view addSubview:self.cashierDeskTableView];
    [self.view addSubview:self.confirmButton];
    self.title = @"收银台";
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cashierDeskTableView.mas_bottom);
        make.height.equalTo(@(49));
        make.left.equalTo(self.view.mas_left).mas_offset(10);
        make.right.equalTo(self.view.mas_right).mas_offset(-10);
    }];
    
    [self requestTotalOrderMoney];
    [self requestAccountInfo];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCancelButton];
}
#pragma mark -- 请求账户信息
-(void)requestAccountInfo{
    [LoadingView showLoadViewToView:self.view];
    __weak typeof(self)wSelf = self;
    [CashDeskService getAvailableMoenyCompeletion:^(id obj, NSError *error) {
        if (error) {
            UTMessageView * messageView = [UTMessageView showEmptyMsgViewTo:self.view logoLabelText:@"" emptyText:@"加载失败！！" buttonTitle:@"重新加载" animationed:YES];
            [messageView setRetryBlock:^{
                [wSelf requestAccountInfo];
            }];
            
        }else{
            wSelf.accountArr = obj;
            float banlance =0;
            for (int i = 0; i < wSelf.accountArr.count; i++) {
                AccountInfoModel *ainfo = wSelf.accountArr[i];
                //                NSDictionary *money_dic = wSelf.accountArr[i];
                float money = [ainfo.banlance floatValue];
                banlance = banlance+money;
            }
            self.banlances = [NSString stringWithFormat:@"%.2f",banlance];
        }
        [wSelf.cashierDeskTableView reloadData];
         [LoadingView hideLoadViewToView:wSelf.view];
    }];
    
}

#pragma mark - 计算总金额
-(void)requestTotalOrderMoney{
    __weak typeof(self) wSelf = self;
    
    
    [CashDeskService calculateOrdersMoneyWithOrders:self.orderArr requestCompeletion:^(id obj, NSError *error) {
        NSDictionary * dict = obj;
        NSString * totalMoney = [[dict objectForKey:@"total_amount"] stringValue];
        [wSelf updateTotalCountWith:totalMoney];
        [wSelf.cashierDeskTableView reloadData];
    }];
}
-(void)updateTotalCountWith:(NSString *)totalCount{
    self.accountTotal = totalCount;
    
}

-(UIButton *)confirmButton{
    if (_confirmButton == nil) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_confirmButton setBackgroundColor:[UIColor colorWithString:@"#03b598"]];
        [_confirmButton setTitle:@"确认付款" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _confirmButton.layer.cornerRadius = 4;
        _confirmButton.clipsToBounds = YES;
    }
    return _confirmButton;
}

#pragma mark- 确认付款
-(void)confirmButtonClick:(UIButton *)confirmButton{
    NSString *strjson = [self.orderArr  componentsJoinedByString:@","];
if ([self.accountTotal floatValue]> [self.banlances floatValue]) {
    if (self.accountTotal > self.banlances) {
        [ShowMessage showMessage:@"您的余额不足，请充值后再付款"];
    }else{
        [BKService orderpay:strjson account_type:self.selectedModel.account_type view:self.view callback:^(id obj,NSError* error) {
            ShoppingCarCommon *sc = obj;
            if (sc.success) {
                [self.navigationController popToRootViewControllerAnimated:YES ];
                
            }
            else{
                
            }
            [ShowMessage showMessage:sc.msg];
        }];
    }
}
}

-(UITableView *)cashierDeskTableView{
    if (_cashierDeskTableView == nil) {
        _cashierDeskTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _cashierDeskTableView.delegate = self;
        _cashierDeskTableView.dataSource = self;
        _cashierDeskTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _cashierDeskTableView.backgroundColor = [UIColor clearColor];
        _cashierDeskTableView.height = self.view.height - 128;
        
    }
    return _cashierDeskTableView;
}
-(NSMutableArray *)accountArr{
    if (_accountArr == nil) {
        _accountArr = [[NSMutableArray alloc] init];
    }
    return _accountArr;
}

-(UIView *)getSecitionHeaderView{
    UIView * sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.cashierDeskTableView.width, 34)];
    sectionHeaderView.backgroundColor = [UIColor whiteColor];
    UILabel * payTypeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    payTypeLabel.font = [UIFont boldSystemFontOfSize:16];
    payTypeLabel.textColor = [UIColor colorWithString:@"#5F646E"];
    //    [sectionHeaderView addSubview:payTypeLabel];
    //    payTypeLabel.text = @"支付方式:";
    //    [payTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(sectionHeaderView.mas_left).mas_offset(15);
    //        make.centerY.equalTo(sectionHeaderView.mas_centerY);
    //    }];
    //
    //    UILabel * explainLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    //    [sectionHeaderView addSubview:explainLabel];
    //    explainLabel.text = @"(目前仅支持有糖账户付款方式)";
    //    explainLabel.textColor = [UIColor colorWithString:@"#999999"];
    //    explainLabel.font = [UIFont boldSystemFontOfSize:14];
    //    [explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(payTypeLabel.mas_right).mas_offset(5);
    //        make.centerY.equalTo(payTypeLabel.mas_centerY);
    //    }];
    return sectionHeaderView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return CashierDeskSectionTypePayType + 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == CashierDeskSectionTypeBasicInfo) {
        return 1;
    }else if (section == CashierDeskSectionTypePayType){
        return 1;
    }else{
        return 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == CashierDeskSectionTypeBasicInfo) {
        CashDeskBasicInfoCell * basicInfoCell = [tableView dequeueReusableCellWithIdentifier:@"basicInfo"];
        if (basicInfoCell == nil) {
            basicInfoCell = [[CashDeskBasicInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"basicInfo"];
        }
        
        [basicInfoCell updateCellWithOrderCount:[NSString stringWithFormat:@"%ld",(long)self.orderArr.count] andTotalMoney:self.accountTotal];
        return basicInfoCell;
    }else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"orderType"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderType"];
            cell.backgroundColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text = @"当前余额";
        [cell.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView.mas_left).mas_offset(5);
            //            make.width.equalTo(@(70));
            make.centerY.equalTo(cell.contentView.mas_centerY);
        }];
        cell.font = [UIFont boldSystemFontOfSize:16];
        cell.textLabel.textColor  = [UIColor colorWithString:@"#5F646E"];
        
        banlanceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        banlanceLabel.textColor = COLOR_06;
        // banlanceLabel.backgroundColor =[UIColor yellowColor];
        banlanceLabel.text = self.banlances;
        //            banlanceLabel.text = @"99.00";
        [cell.contentView addSubview:banlanceLabel];
        [banlanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.textLabel.mas_right).mas_offset(5);
            make.centerY.equalTo(cell.textLabel.mas_centerY);
        }];
        
        
        if (linkLabel == nil) {
            linkLabel = [[UILabel alloc]initWithFrame:CGRectZero];
            linkLabel.text = @"充值";
            linkLabel.textColor = [UIColor blueColor];
            linkLabel.font = [UIFont boldSystemFontOfSize:14];
            linkLabel.userInteractionEnabled = YES;
            UITapGestureRecognizer *pans = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoRecharge)];
            [linkLabel addGestureRecognizer:pans];
            
            [cell.contentView addSubview:linkLabel];
            [linkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.mas_right).mas_offset(-20);
                make.centerY.equalTo(cell.textLabel.mas_centerY);
            }];
            
        }
        
        if (yuanLabel == nil) {
            yuanLabel = [[UILabel alloc]initWithFrame:CGRectZero];
            yuanLabel.textColor = [UIColor colorWithString:@"#5F646E"];
            yuanLabel.text = @"元";
            yuanLabel.font = [UIFont boldSystemFontOfSize:12];
            [cell.contentView addSubview:yuanLabel];
        }
        [yuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(banlanceLabel.mas_right).mas_offset(5);
            make.centerY.equalTo(banlanceLabel.mas_centerY);
            //                make.width.equalTo(@(20));
            //                make.height.equalTo(banlanceLabel.mas_height);
        }];
        
        
        
        
        //        [cell updateAccountInfoWithModel:[self.accountArr objectAtIndex:indexPath.row] andMoney:self.accountTotal];
        return cell;
        
    }
}



-(void)gotoRecharge{
    
    RechargeController *rVC = [[RechargeController alloc]init];
    [self.navigationController pushViewController:rVC animated:YES];
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != CashierDeskSectionTypeBasicInfo) {
        AccountInfoModel * selectedModel = [self.accountArr objectAtIndex:indexPath.row];
        self.selectedModel = selectedModel;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == CashierDeskSectionTypeBasicInfo) {
        return 70;
    }else if (indexPath.section == CashierDeskSectionTypePayType){
        return 50;
    }else{
        return 0;
    }
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (section == CashierDeskSectionTypePayType) {
//        return [self getSecitionHeaderView];
//    }
//    return nil;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == CashierDeskSectionTypePayType) {
        return 0;
    }
    return 0.000000001;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
