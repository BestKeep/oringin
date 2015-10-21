//
//  ShopingAddressController.m
//  BESTKEEP
//
//  Created by 魏鹏 on 15/8/24.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "ShopingAddressController.h"
#import "AddAddressController.h"
#import "DeliverAddressServer.h"
#import "DeliverAddress.h"
#import "Result.h"
#import "AddSet.h"


@interface ShopingAddressController (){
    
    UIButton *leftButton;
    NSMutableArray *addressid_array;
    NSMutableDictionary *address_dic;
    NSString *addressId;
    NSData *jasonData;
    DeliverAddress *_deliver;
    NSString *isdefull;
    BOOL duef;
    NSMutableSet *cell_set;
    NSArray *cell_array;
    BOOL isFirst;
    NSMutableArray *data_array;
}
@property (nonatomic,strong) AddController * advc;
@property (nonatomic,strong) ShopingAddressController *pvc;
@end

@implementation ShopingAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    cell_set = [[NSMutableSet alloc]init];
    cell_array = [[NSArray alloc]init];
    [self deliverAddressList];
    data_array = [NSMutableArray new];
    addressid_array = [NSMutableArray new];
//    deliver =[[DeliverAddress alloc]init];
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     addressid_array = [NSMutableArray new];
}
-(void)viewDidAppear:(BOOL)animated{
    isFirst = YES;
    [self deliverAddressList];
    [_ShopingTableView  reloadData];

}
#pragma make 收货地址
-(void)deliverAddressList{
    [DeliverAddressServer getDeliverAddress:^(id obj) {
        Result *addressResult =(Result *)obj;
        
        if (addressResult.success) {
            
            self.orderList =(NSMutableArray *)addressResult.data;
            if ([self.orderList count]!=0) {
                [_ShopingTableView reloadData];
            }
            else{
                [ShowMessage showMessage:@"暂无收货地址"];
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
    
    [leftButton setTitle:@"添加" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    [leftButton addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
}
-(void)addAddress{
    AddAddressController *addVC = [[AddAddressController alloc]init];
    [self.navigationController pushViewController:addVC animated:YES];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     DeliverAddress * deliver = self.orderList[indexPath.section];
     AddressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"orderReturnCell"];
     if (cell  == nil) {
        cell = [[AddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderReturnCell" delegate:self tag:indexPath.section];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.adddelegate =self;
    }
    [AddSet setAddIsDefaulit:deliver.deliverIsDefault];
   
    cell.tagLabel.text = deliver.deliverIsDefault;
    if (isFirst) {
        if ([deliver.deliverIsDefault isEqualToString:@"1"]) {
            cell.tagLabel.text =@"默认地址";
            cell.radiobutton.selected = YES;
            
        }else{
            cell.tagLabel.text =@"";
            cell.radiobutton.selected = NO;
        }
    }
    [cell updateCellContentWithAddress:deliver];
    
    [AddSet setAddID:deliver.deliverId];
    [AddSet setAddName:deliver.deliverName];
    [AddSet setAddProvinceName:deliver.deliverProvinceName];
    [AddSet setAddCityName:deliver.deliverCityName];
    [AddSet setAddCountyName:deliver.deliverCountyName];
    [AddSet setAddAddress:deliver.deliverAddress];
    [AddSet setAddPostCode:deliver.deliverPostCode];
    [AddSet setAddIsDefaulit:deliver.deliverIsDefault];
    [AddSet setAddTelephone:deliver.deliverTelephone];
    
    
    if (indexPath.row == 0) {
        [addressid_array addObject:deliver.deliverId];//存储地址id,设置判断，防止地址重复
    }
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

-(void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId{
    NSLog(@"设置默认地址");
    
//    [self setDefaultAddress:radio.tag];
 
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 122;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.selected = NO;
}

#pragma mark -- cell代理
-(void)newAddressCell:(AddressCell *)cell selectedButton:(UIButton *)selectedButton{
    [self setSingilessleSeleteModleWithModle:cell.datas];
    if (cell.datas.isDefaultAddress) {
        [self setDefaultAddress:cell.datas];
    }
    
}
-(void)setSingilessleSeleteModleWithModle:(DeliverAddress *)address{
    [self.orderList removeObject:address];
    [self.orderList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        DeliverAddress * tempAddress =(DeliverAddress *)obj;
        tempAddress.isDefaultAddress =NO;
    }];
    [self.orderList insertObject:address atIndex:0];
}
-(void)clickEditButton:(UIButton *)editButton addressModel:(DeliverAddress *)address{
    NSLog(@"编辑收获地址");
    
    AddController *addVC = [[AddController alloc]init];
    
    addVC.address = address;
    
    [self.navigationController pushViewController:addVC animated:YES];
    
}
-(void)clickDelegateButton:(NSInteger)index{
    NSLog(@"删除收获地址");
    [self setDelete:index];
}
//-(void)setDefaultaddress:(DeliverAddress *)address{
//    NSLog(@"默认");
//    NSDictionary *body_dic = [NSDictionary dictionaryWithObjectsAndKeys:address.deliverId,@"deliver_id", nil];
//}
-(void)setDefaultAddress:(DeliverAddress *)address{
    NSString *deliver_id = address.deliverId;
    NSDictionary *body_dic = [NSDictionary dictionaryWithObjectsAndKeys:deliver_id,@"deliver_id", nil];
    [DeliverAddressServer getDeliverAddress:body_dic :^(id obj) {
        //Result *result = (Result *)obj;
        DeliverAddress *deliver =[[DeliverAddress alloc]init];
        
        [AddSet setAddID:deliver.deliverId];
        [AddSet setAddName:deliver.deliverName];
        [AddSet setAddProvinceName:deliver.deliverProvinceName];
        [AddSet setAddCityName:deliver.deliverCityName];
        [AddSet setAddCountyName:deliver.deliverCountyName];
        [AddSet setAddAddress:deliver.deliverAddress];
        [AddSet setAddPostCode:deliver.deliverPostCode];
        [AddSet setAddIsDefaulit:deliver.deliverIsDefault];
        [AddSet setAddTelephone:deliver.deliverTelephone];
        [self.ShopingTableView reloadData];
    }];
}

-(void)setDelete:(NSInteger)index{
    if ([addressid_array count] == 1) {
        [ShowMessage showMessage:@"最后一个地址不允许删除"];
    }
    else{
        NSString *deliver_id = [addressid_array objectAtIndex:index];
        NSDictionary *body_dic = [NSDictionary dictionaryWithObjectsAndKeys:deliver_id,@"deliver_id", nil];
        [DeliverAddressServer getDleiverDelete:body_dic :^(id obj) {
        Result *deleteResult = (Result *)obj;
        if (deleteResult.success) {
                [self deliverAddressList];
            }
        }];
      }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
