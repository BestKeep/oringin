//
//  AddressManagerController.m
//  BESTKEEP
//
//  Created by cunny on 15/8/28.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "AddressManagerController.h"
#import "AddAddressController.h"
#import "DeliverAddressServer.h"
#import "DeliverAddress.h"
#import "Result.h"
#import "ShopingAddressController.h"
#import  "AddSet.h"
#import "Userinfo.h"
#import "LoginController.h"

@interface AddressManagerController (){
    
    UIButton *leftButton;
    NSMutableArray *addressid_array;
    NSMutableSet *cell_set;
    NSArray *cell_array;
    BOOL isFirst;
    NSString *feel;
    NSString *feid;
    
}


@end

@implementation AddressManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[Userinfo getST]isEqualToString:@""]) {
        LoginController *logdv= [[LoginController alloc]init];
        [self.navigationController popToViewController:logdv animated:YES];
    }
    cell_set = [[NSMutableSet alloc]init];
    cell_array = [[NSArray alloc]init];
    [self deliverAddressList];
    addressid_array = [NSMutableArray new];
    self.view.backgroundColor = [UIColor colorWithString:@"#eeeeee"];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.title = @"收货地址";
    [self setAddButton];
    if (_ShopingTableView == nil) {
        _ShopingTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _ShopingTableView.backgroundColor = [UIColor clearColor];
        _ShopingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _ShopingTableView.delegate = self;
        _ShopingTableView.dataSource = self;
    }
    
    [self.view addSubview:_ShopingTableView];
    [_ShopingTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
     
    
}

//-(void)backButtonClick{
//    self.SelectedAddressCompeletion?self.SelectedAddressCompeletion(nil):nil;
//    [super backButtonClick];
//
//}

-(void)viewDidAppear:(BOOL)animated{
    isFirst = YES;
    [self deliverAddressList];
    [_ShopingTableView reloadData];
}
#pragma make 收货地址
-(void)deliverAddressList{
    [DeliverAddressServer getDeliverAddress:^(id obj,NSError* error) {
        Result *addressResult =(Result *)obj;
        
        if (addressResult.success) {
           
            self.orderList =(NSMutableArray *)addressResult.data;
            if ([self.orderList count] == 0) {
                [ShowMessage showMessage:@"暂无收货地址"];
            }
            else{
                 [_ShopingTableView reloadData];
            }
        }
        else{
            self.addressmsg=addressResult.msg;
        }
    } ];
}
-(void)setAddButton{
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(self.view.frame.size.width-50, 0, 40, 45);
    
    [leftButton setTitle:@"管理" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    [leftButton addTarget:self action:@selector(AddressManager) forControlEvents:UIControlEventTouchUpInside];
}
-(void)AddressManager{
    ShopingAddressController *addVC = [[ShopingAddressController alloc]init];
    [self.navigationController pushViewController:addVC animated:YES];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DeliverAddress *deliver = self.orderList[indexPath.section];
    NewAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"orderReturnCell"];
    
    if (cell  == nil) {
        cell = [[NewAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderReturnCell" delegate:self tag:indexPath.section];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.addressCellDelegate =self;
    }
    [AddSet setAddIsDefaulit:deliver.deliverIsDefault];

    [cell updateCellContentWithAddress:deliver];
    [addressid_array addObject:deliver.deliverId];
    [cell_set addObject:cell];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.orderList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 86;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    DeliverAddress *deliver = self.orderList[indexPath.section];
    self.SelectedAddressCompeletion?self.SelectedAddressCompeletion(deliver):nil;
    [self.navigationController popViewControllerAnimated:YES];
    
    cell.selected = NO;
}

#pragma mark -- addressCell delegate

-(void)newAddressCell:(NewAddressCell *)cell selectedButton:(UIButton *)selectedButton{
//    [self setSingileSeletedModleWithModle:cell.address];
//    if (cell.address.isDefaultAddress) {
//        [self setDefaultAddress:cell.address];
//    }
    self.SelectedAddressCompeletion (cell.address);
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)setSingileSeletedModleWithModle:(DeliverAddress *)address{
    [self.orderList removeObject:address];
    [self.orderList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        DeliverAddress * tempAddress = (DeliverAddress *)obj;
        tempAddress.isDefaultAddress = NO;
    }];
    [self.orderList insertObject:address atIndex:0];
}

//-(void)setDefaultAddress:(DeliverAddress *)address{
//    NSLog(@"默认");
////    NSString *deliver_id = [addressid_array objectAtIndex:tag];
//    NSDictionary *body_dic = [NSDictionary dictionaryWithObjectsAndKeys:address.deliverId,@"deliver_id", nil];
//    [DeliverAddressServer getDeliverAddress:body_dic :^(id obj) {
//        [self deliverAddressList];
//    }];
//  
//}
//-(void)setDelete:(NSInteger)index{
//    NSString *deliver_id = [addressid_array objectAtIndex:index];
//    NSDictionary *body_dic = [NSDictionary dictionaryWithObjectsAndKeys:deliver_id,@"deliver_id", nil];
//    [DeliverAddressServer getDleiverDelete:body_dic :^(id obj) {
//        Result *deleteResult = (Result *)obj;
//        if (deleteResult.success) {
//            [self deliverAddressList];
//            
//        }
//    }];
//
    
    
    
    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

