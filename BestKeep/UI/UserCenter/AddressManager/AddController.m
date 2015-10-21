//
//  AddController.m
//  BESTKEEP
//
//  Created by YISHANG on 15/8/29.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "AddController.h"
#import "AddTextCell.h"
#import "AddEditCell.h"
#import "BKService.h"
#import "Area.h"
#import "ShowMessage.h"
#import "Result.h"
#import "AreaService.h"
#import "DeliverAddressServer.h"
#import "ShopingAddressController.h"
#import "AddSet.h"

@interface AddController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate,UIActionSheetDelegate>
@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic,strong) UIActionSheet * areaSheet;
@property (nonatomic,strong) UIActionSheet * citySheet;
@property (nonatomic,strong) UIActionSheet * squareSheet;


@end

@implementation AddController{
    ShopingAddressController *shoepv;
    NSString *nameInput;
    NSString *mobileInput;
    NSString *phoneInput;
    NSString *zipCodeInput;
    NSString *addressInput;
    UIAlertController *alertVC;
    UIAlertController *alertVC2;
    UIAlertController *alertVC3;
    UIPickerView *areaPicker;
    UIPickerView *cityPicker;
    UIPickerView *squarePicker;
    UILabel *chooseLabel1;
    UILabel *chooseLabel2;
    UILabel *chooseLabel3;
    NSString *areaInput;
    NSString *cityInput;
    NSString *squareInput;
    UISwitch *switchBut;
    UIButton *submitBut;
    NSMutableArray *province_code_array;
    NSMutableArray *province_name_array;
    NSMutableArray *city_code_array;
    NSMutableArray *city_name_array;
    NSMutableArray *country_name_array;
    NSMutableArray *country_code_array;
    NSString *province_code;
    NSString *city_code;
    NSString *country_code;
    NSString * addressid;
    id deliver_array;
    BOOL isFlag;
    UITextView *tv;
}

//-(void)setAddress:(DeliverAddress *)address{
//    _address = [address mutableCopy];
//}

-(void)viewDidLayoutSubviews{
    
    
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    deliver_array = [AddSet getaddobj];
    [self code];
    self.title = @"编辑收货地址";
    self.view.backgroundColor = [UIColor colorWithString:@"#eeeeee"];
    isFlag = self.address.isDefaultAddress;
    
    province_code_array = [NSMutableArray array];
    province_name_array = [NSMutableArray array];
    city_code_array = [NSMutableArray array];
    city_name_array = [NSMutableArray array];
    country_name_array = [NSMutableArray array];
    country_code_array = [NSMutableArray array];
    [province_name_array addObject:@"省份读取中..."];
    [AreaService GetArea:self.view callback:^(id obj,NSError* error) {
        [province_name_array removeAllObjects];
        NSArray *result_array = [[NSArray alloc]init];
        result_array = obj;
        for (int i =0; i < result_array.count; i++) {
            Area *area_data = [[Area alloc]init];
            area_data = result_array[i];
            [province_code_array addObject:area_data.AreaCode];
            [province_name_array addObject:area_data.AreaName];
        }
        [areaPicker reloadAllComponents];
        [cityPicker reloadAllComponents];
        [squarePicker reloadAllComponents];
        
        
    }];
    //    area_array =@[@"中国",@"美国"];
    [city_name_array addObject:@"请先选择省份"];
    [country_name_array addObject:@"请先选择城市"];
    
    chooseLabel1 = [[UILabel alloc]init];
    chooseLabel2 = [[UILabel alloc]init];
    chooseLabel3 = [[UILabel alloc]init];
    switchBut = [[UISwitch alloc]init];
    submitBut = [[UIButton alloc]initWithFrame:CGRectZero];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero];
    
    //    self.tableView.frame = self.view.frame;
    
    self.tableView.backgroundColor=[UIColor whiteColor];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate=self;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
}
//tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 14;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (indexPath.row == 1 || indexPath.row == 4 || indexPath.row == 8 || indexPath.row ==11) {
        NSString *ident = [NSString stringWithFormat:@"Cell%d%d", indexPath.section, indexPath.row];
        AddTextCell *cell=[self.tableView dequeueReusableCellWithIdentifier:ident];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (cell==nil) {
            cell=[[AddTextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row ==1) {
            cell.messageLabel.text = @"长度不超过25个字符";
            
        }else if (indexPath.row == 4){
            cell.messageLabel.text = @"请输入正确的手机号码\n区号-电话号码-分机号";
            
            
        }else if(indexPath.row == 8){
            
            
        }else if (indexPath.row == 11){
            
            cell.messageLabel.text = @"如不清楚邮递区号,请填写000000\n填写详细收货地址,例如:街道名称,门牌号码,楼层和房间号等信息";
            
            
        }
        return cell;
    }else if (indexPath.row == 0 ||indexPath.row == 2 ||indexPath.row == 3 ||indexPath.row == 9 ||indexPath.row == 10){
        
        NSString *ident = [NSString stringWithFormat:@"Cell%lu%lu", indexPath.section, indexPath.row];
        AddEditCell *cell=[self.tableView dequeueReusableCellWithIdentifier:ident];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (cell==nil) {
            cell=[[AddEditCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.messageText.keyboardType = UIKeyboardTypeDefault;
        if (indexPath.row == 0) {
            cell.text_tag = indexPath.row;
            cell.messageLabel.text = @"收货人姓名";
            cell.messageText.placeholder = @"请输入姓名";
            if ([nameInput isEqualToString:@""] || nameInput == nil) {
                //nameInput = [AddSet getAddName];
                nameInput=_address.deliverName;
            }
            cell.messageText.text = nameInput;
            cell.messageText.delegate = self;
            cell.messageText.tag = indexPath.row;
            
            
        }else if (indexPath.row == 2){
            cell.text_tag = indexPath.row;
            cell.messageLabel.text = @"手机号码";
            cell.messageText.keyboardType = UIKeyboardTypePhonePad;

            cell.messageText.placeholder = @"请输入手机";
            if ([mobileInput isEqualToString:@""] || mobileInput == nil) {
                //mobileInput = [AddSet getAddTelephone];
                mobileInput = _address.deliverTelephone;
            }
            cell.messageText.text = mobileInput;
            //[cell.messageText setKeyboardType:UIKeyboardTypeNumberPad];
            
            cell.messageText.delegate = self;
            cell.messageText.tag = indexPath.row;
        }else if (indexPath.row == 3){
            cell.text_tag =indexPath.row;
            cell.messageLabel.text = @"电话号码";
            cell.messageText.keyboardType = UIKeyboardTypePhonePad;
            cell.messageText.placeholder = @"请输入电话";
            if ([phoneInput isEqualToString:@""] || phoneInput == nil) {
                // phoneInput = [AddSet getAddFixedTelephone];
                phoneInput = _address.deliverFixedTelephone;
            }
            cell.messageText.text = phoneInput;
            cell.messageText.delegate = self;
            cell.messageText.tag = indexPath.row;
        }else if (indexPath.row == 9){
            cell.text_tag =indexPath.row;
            cell.messageLabel.text = @"邮政编码";
            cell.messageText.placeholder = @"请输入邮编";
            if ([zipCodeInput isEqualToString:@""] || zipCodeInput == nil) {
                //zipCodeInput = [AddSet getAddPostCode];
                zipCodeInput = _address.deliverPostCode;
            }
            cell.messageText.text = zipCodeInput;
            cell.messageText.delegate = self;
            cell.messageText.tag = indexPath.row;
            
        }else if (indexPath.row == 10){
            cell.text_tag = indexPath.row;
            cell.messageLabel.text = @"详细地址";
            cell.messageLabel.verticalAlignment = BTVerticalAlignmentTop;
            cell.messageText.hidden =YES;
            
            tv = [[UITextView alloc]initWithFrame:CGRectZero];
            tv.font = [UIFont boldSystemFontOfSize:16];
            tv.textColor = COLOR_05;
            tv.delegate = self;
            [cell.contentView addSubview:tv];
            tv.tag = indexPath.row;
            
            
            if ([addressInput isEqualToString:@""] || addressInput == nil) {
                //addressInput = [AddSet getAddAddress];
                tv.textAlignment = NSTextAlignmentLeft;
                addressInput = _address.deliverAddress;
            }
            cell.messageText.text = addressInput;
            cell.messageText.delegate = self;
            cell.messageText.tag = indexPath.row;
            tv.text = addressInput;
            [tv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.contentView.mas_right).mas_offset(-10);
                make.left.equalTo(cell.contentView.mas_left).mas_offset(14);
                make.top.equalTo(cell.contentView.mas_top).mas_offset(50);
                make.bottom.equalTo(cell.contentView.mas_bottom).mas_offset(-10);
            }];
            
        }
        
        
        return cell;
    }
    
    else {
        NSString *ident = [NSString stringWithFormat:@"Cell%d%d", indexPath.section, indexPath.row];
        UITableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:ident];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
        }
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
        cell.textLabel.textColor = COLOR_05;
        if(indexPath.row ==5){
            
            cell.textLabel.text = @"所在地区";
            cell.tag = indexPath.row;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            if ([areaInput isEqualToString:@""] || areaInput ==nil) {
                //chooseLabel1.text = @"请选择";
                //chooseLabel1.text = [AddSet getAddProvinceName];
                chooseLabel1.text = _address.deliverProvinceName;
                areaInput = chooseLabel1.text;
                chooseLabel1.textColor = COLOR_05;
                //chooseLabel1.textColor = [UIColor colorWithString:@"#999999"];
            }else{
                
                chooseLabel1.text = areaInput;
                chooseLabel1.textColor = COLOR_05;
            }
            [chooseLabel1 removeFromSuperview];
            [cell.contentView addSubview:chooseLabel1];
            chooseLabel1.textAlignment = NSTextAlignmentRight;
            chooseLabel1.font = [UIFont boldSystemFontOfSize:16];
            [chooseLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.contentView.mas_right).mas_offset(0);
                make.centerY.equalTo(cell.contentView.mas_centerY);
                make.width.equalTo(@(250));
                
            }];
            
        }else if (indexPath.row ==6){
            
            cell.textLabel.text = @"所在市";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            if ([cityInput isEqualToString:@""] || cityInput ==nil) {
                // chooseLabel2.text = @"请选择";
                //chooseLabel2.text = [AddSet getAddCityName];
                chooseLabel2.text = _address.deliverCityName;
                chooseLabel2.textColor = COLOR_05;
                cityInput = chooseLabel2.text;
                // chooseLabel2.textColor = [UIColor colorWithString:@"#999999"];
            }else{
                // chooseLabel2.text = [AddSet getAddCityName];
                chooseLabel2.text = cityInput;
                chooseLabel2.textColor = COLOR_05;
            }
            [cell.contentView addSubview:chooseLabel2];
            chooseLabel2.font = [UIFont boldSystemFontOfSize:16];
            chooseLabel2.textAlignment = NSTextAlignmentRight;
            [chooseLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.contentView.mas_right).mas_offset(0);
                make.centerY.equalTo(cell.contentView.mas_centerY);
                make.width.equalTo(@(250));
                
            }];
        }else if (indexPath.row ==7){
            
            cell.textLabel.text = @"区/县";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
            
            if ([squareInput isEqualToString:@""] || squareInput ==nil) {
                //                chooseLabel3.text = @"请选择";
                //                chooseLabel3.textColor = [UIColor colorWithString:@"#999999"];
                //chooseLabel3.text = [AddSet getAddCountyName];
                chooseLabel3.text = _address.deliverCountyName;
                squareInput = chooseLabel3.text;
                chooseLabel3.textColor = COLOR_05;
            }else{
                //chooseLabel3.text = [AddSet getAddCountyName];
                chooseLabel3.text = squareInput;
                chooseLabel3.textColor = COLOR_05;
                
            }
            
            [cell.contentView addSubview:chooseLabel3];
            chooseLabel3.font = [UIFont boldSystemFontOfSize:16];
            chooseLabel3.textAlignment = NSTextAlignmentRight;
            [chooseLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.contentView.mas_right).mas_offset(0);
                make.centerY.equalTo(cell.contentView.mas_centerY);
                make.width.equalTo(@(250));
                
            }];
        }else if(indexPath.row ==12){
            
            cell.textLabel.text = @"设置为默认收货地址";
            cell.textLabel.textColor = COLOR_05;
            cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
            cell.backgroundColor = [UIColor whiteColor];

            [switchBut setOn:isFlag];
            
            //            if ([_address.deliverIsDefault isEqualToString:@"1"]) {
//                [switchBut setOn:YES];
//            }else{
//                [switchBut setOn:NO];
//            }
            
            [switchBut addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            [cell.contentView addSubview:switchBut];
            [switchBut mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.contentView.mas_right).mas_offset(-30);
                make.centerY.equalTo(cell.contentView.mas_centerY);
                
            }];
        }else{
            cell.backgroundColor = [UIColor colorWithString:@"#eeeeee"];
            submitBut.backgroundColor = [UIColor colorWithRed:25/255.0f green:180/255.0f blue:142/255.0f alpha:1];
            [submitBut setTitle:@"保存地址" forState:UIControlStateNormal];
            submitBut.titleLabel.font = [UIFont boldSystemFontOfSize:16];
            [submitBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            submitBut.layer.cornerRadius = 5;
            [submitBut addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:submitBut];
            [submitBut mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView.mas_left).mas_offset(15);
                make.right.equalTo(cell.contentView.mas_right).mas_offset(-15);
                make.top.equalTo(cell.contentView.mas_top).mas_offset(15);
                make.bottom.equalTo(cell.contentView.mas_bottom).mas_offset(-15);
                
            }];
            
        }
        return cell;
    }
    //    return cell;
}


-(void)switchAction:(id)sender{
    UISwitch *switchButton = (UISwitch*)sender;
    
    if (self.address.isDefaultAddress) {
        if (!switchButton.on) {
            switchButton.on = YES;
            [ShowMessage showMessage:@"不可以取消默认地址" withCenter:self.view.center];
            return;
        }
    }
    
    isFlag = switchButton.on;
//    if ([[AddSet getAddIsDefaulit]isEqualToString:@"1" ]) {
//        isFlag = YES;
//        NSLog(@"默认");
//    }else {
//        isFlag =NO;
//        NSLog(@"非默认");
//    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 5) {
        [chooseLabel2 removeFromSuperview];
        [chooseLabel3 removeFromSuperview];
        cityInput =@"请选择";
        squareInput =@"请选择";
        if(alertVC == nil){
            alertVC= [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n" message:@" "preferredStyle:UIAlertControllerStyleActionSheet];
            
            areaPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(alertVC.view.frame.origin.x, alertVC.view.frame.origin.y, alertVC.view.frame.size.width/24*23, 180)];
            areaPicker.delegate = self;
            areaPicker.dataSource =self;
            
            UIAlertAction *ok =[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                if (province_code == nil||[province_code isEqualToString:@""]) {
                    
                }else{
                    [AreaService GetCity:province_code view:self.view callback:^(id obj,NSError* error) {
                        [city_name_array removeAllObjects];
                        [city_code_array removeAllObjects];
                        NSArray *result_array = [[NSArray alloc]init];
                        result_array = obj;
                        for (int i =0; i < result_array.count; i++) {
                            Area *area_data = [[Area alloc]init];
                            area_data = result_array[i];
                            [city_code_array addObject:area_data.AreaCode];
                            [city_name_array addObject:area_data.AreaName];
                        }
                        [areaPicker reloadAllComponents];
                        [cityPicker reloadAllComponents];
                        [squarePicker reloadAllComponents];
                        
                    }];
                    
                }
                
                
            }];
            
            
            UIAlertAction *no =[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                if (province_code == nil||[province_code isEqualToString:@""]) {
                    
                }else{
                    [AreaService GetCity:province_code view:self.view callback:^(id obj,NSError* error) {
                        [city_name_array removeAllObjects];
                        [city_code_array removeAllObjects];
                        NSArray *result_array = [[NSArray alloc]init];
                        result_array = obj;
                        for (int i =0; i < result_array.count; i++) {
                            Area *area_data = [[Area alloc]init];
                            area_data = result_array[i];
                            [city_code_array addObject:area_data.AreaCode];
                            [city_name_array addObject:area_data.AreaName];
                        }
                        [areaPicker reloadAllComponents];
                        [cityPicker reloadAllComponents];
                        [squarePicker reloadAllComponents];
                        
                    }];
                    
                }
                
                
            }];
            
            [alertVC.view addSubview:areaPicker];
            [alertVC addAction:ok];
            [alertVC addAction:no];
            
        }
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
            [self.view.window.rootViewController presentViewController:alertVC animated:YES completion:nil];
        }
        else{
            UIActionSheet *ast =[[UIActionSheet alloc]initWithTitle:@"\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定",nil];
            [ast setActionSheetStyle:UIActionSheetStyleDefault];
            ast.userInteractionEnabled=YES;
            areaPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0,ast.frame.origin.y,SCREEN_WIDTH ,150)];
            [areaPicker sizeToFit];
            areaPicker.delegate = self;
            areaPicker.dataSource =self;
            areaPicker.showsSelectionIndicator =YES;
            [ast addSubview:areaPicker];
            self.areaSheet = ast;
            
            [ast setBackgroundColor:[UIColor whiteColor]];
            [ast showInView:[UIApplication sharedApplication].keyWindow];
            //            //[alertVC presentedViewController];
        }
        
    }else if (indexPath.row == 6){
        [chooseLabel3 removeFromSuperview];
        squareInput =@"请选择";
        if(alertVC2 == nil){
            alertVC2= [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n" message:@" "preferredStyle:UIAlertControllerStyleActionSheet];
            
            cityPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(alertVC2.view.frame.origin.x, alertVC2.view.frame.origin.y, alertVC2.view.frame.size.width/24*23, 180)];
            cityPicker.delegate = self;
            cityPicker.dataSource =self;
            //UIAlertAction *ok =[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                
                
                if (city_code == nil||[city_code isEqualToString:@""]) {
                    
                }else{
                    [AreaService GetSquare:city_code view:self.view callback:^(id obj,NSError* error) {
                        [country_name_array removeAllObjects];
                        [country_code_array removeAllObjects];
                        NSArray *result_array = [[NSArray alloc]init];
                        result_array = obj;
                        for (int i =0; i < result_array.count; i++) {
                            Area *area_data = [[Area alloc]init];
                            area_data = result_array[i];
                            [country_code_array addObject:area_data.AreaCode];
                            [country_name_array addObject:area_data.AreaName];
                            
                        }
                        [areaPicker reloadAllComponents];
                        [cityPicker reloadAllComponents];
                        [squarePicker reloadAllComponents];
                    }];
                }
                
                
            }];
            UIAlertAction *no =[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                
                
                if (city_code == nil||[city_code isEqualToString:@""]) {
                    
                }else{
                    [AreaService GetSquare:city_code view:self.view callback:^(id obj,NSError* error) {
                        [country_name_array removeAllObjects];
                        [country_code_array removeAllObjects];
                        NSArray *result_array = [[NSArray alloc]init];
                        result_array = obj;
                        for (int i =0; i < result_array.count; i++) {
                            Area *area_data = [[Area alloc]init];
                            area_data = result_array[i];
                            [country_code_array addObject:area_data.AreaCode];
                            [country_name_array addObject:area_data.AreaName];
                            
                        }
                        [areaPicker reloadAllComponents];
                        [cityPicker reloadAllComponents];
                        [squarePicker reloadAllComponents];
                    }];
                }
                
                
            }];
            
            [alertVC2.view addSubview:cityPicker];
            [alertVC2 addAction:ok];
            [alertVC2 addAction:no];
            
        }
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
            [self.view.window.rootViewController presentViewController:alertVC2 animated:YES completion:nil];
        }
        else{
            UIActionSheet *ast =[[UIActionSheet alloc]initWithTitle:@"\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定",nil];
            [ast setActionSheetStyle:UIActionSheetStyleDefault];
            ast.userInteractionEnabled=YES;
            cityPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0,ast.frame.origin.y,SCREEN_WIDTH ,150)];
            [cityPicker sizeToFit];
            cityPicker.delegate = self;
            cityPicker.dataSource =self;
            cityPicker.showsSelectionIndicator =YES;
            self.citySheet = ast;
            [ast addSubview:cityPicker];
            
            [ast setBackgroundColor:[UIColor whiteColor]];
            [ast showInView:[UIApplication sharedApplication].keyWindow];
        }
    }else if (indexPath.row == 7){
        
        if(alertVC3 == nil){
            alertVC3= [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n" message:@" "preferredStyle:UIAlertControllerStyleActionSheet];
            
            squarePicker = [[UIPickerView alloc]initWithFrame:CGRectMake(alertVC3.view.frame.origin.x, alertVC3.view.frame.origin.y, alertVC2.view.frame.size.width/24*23, 180)];
            squarePicker.delegate = self;
            squarePicker.dataSource =self;
            //UIAlertAction *ok =[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                
            }];
            UIAlertAction *no =[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:nil];
            
            [alertVC3.view addSubview:squarePicker];
            [alertVC3 addAction:ok];
            [alertVC3 addAction:no];
            
        }
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
            [self.view.window.rootViewController presentViewController:alertVC3 animated:YES completion:nil];
        }
        else{
            UIActionSheet *ast =[[UIActionSheet alloc]initWithTitle:@"\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定",nil];
            [ast setActionSheetStyle:UIActionSheetStyleDefault];
            ast.userInteractionEnabled=YES;
            squarePicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0,ast.frame.origin.y,SCREEN_WIDTH ,150)];
            [squarePicker sizeToFit];
            squarePicker.delegate = self;
            squarePicker.dataSource =self;
            squarePicker.showsSelectionIndicator =YES;
            [ast addSubview:squarePicker];
            self.squareSheet = ast;
            
            [ast setBackgroundColor:[UIColor whiteColor]];
            [ast showInView:[UIApplication sharedApplication].keyWindow];
        }
    }
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}
- (void)leaveEditMode {
    [tv resignFirstResponder];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView == areaPicker) {
        return province_name_array.count;
        
    }else if (pickerView == cityPicker){
        
        return city_name_array.count;
    }else if (pickerView == squarePicker)
        return country_name_array.count;
    else{
        return 0;
    }
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    if (pickerView == areaPicker) {
        if (row == 0) {
            chooseLabel1.text = province_name_array[row];
            areaInput = chooseLabel1.text;
            if (province_code_array.count>0) {
                province_code = province_code_array[row];
            }else{
                province_code = @"";
            }
            
           [self.tableView reloadData];
            
            
        }
        [label setText:province_name_array[row]];
    }else if (pickerView == cityPicker){
        if (row == 0) {
            chooseLabel2.text = city_name_array[row];
            cityInput = chooseLabel2.text;
            if (city_code_array.count>0) {
                city_code = city_code_array[row];
            }else{
                city_code = @"";
            }
            
           [self.tableView reloadData];
            
        }
        [label setText:city_name_array[row]];
    }else if (pickerView == squarePicker){
        if (row == 0) {
            chooseLabel3.text = country_name_array[row];
            squareInput = chooseLabel3.text;
            if (country_code_array.count>0) {
                country_code = country_code_array[row];
            }else{
                country_code = @"";
            }
          [self.tableView reloadData];
            
        }
        [label setText:country_name_array[row]];
    }
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (pickerView == areaPicker) {
        chooseLabel1.text = province_name_array[row];
        if (province_code_array.count>0) {
            province_code = province_code_array[row];
        }else{
            province_code = @"";
        }
        areaInput = chooseLabel1.text;
       [self.tableView reloadData];
    }else if (pickerView == cityPicker) {
        chooseLabel2.text = city_name_array[row];
        if (city_code_array.count>0) {
            city_code = city_code_array[row];
        }else{
            city_code = @"";
        }
        cityInput = chooseLabel2.text;
        [self.tableView reloadData];
    }else if (pickerView == squarePicker) {
        chooseLabel3.text = country_name_array[row];
        if (country_code_array.count>0) {
            country_code = country_code_array[row];
        }else{
            country_code = @"";
        }
        squareInput = chooseLabel3.text;
        [self.tableView reloadData];
    }
}




//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    NSLog(@"selectedArow");
//
//
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 1){
        
        return 50;
    }else if (indexPath.row == 4){
        
        return 70;
    }else if (indexPath.row == 8){
        return 15;
        
    }else if (indexPath.row == 11){
        return 100;
        
    }else if(indexPath.row == 13){
        
        
        return 80;
    }else if (indexPath.row ==10){
        
        return 150;
    }
    else{
        return 50;
    }
}


//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { //隐藏键盘
//    [tv resignFirstResponder];
//}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
        
    }
    
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    
    
    
    self.address.deliverAddress =textView.text;
    addressInput = textView.text;
    self.navigationItem.rightBarButtonItem = nil;
    
    
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    UIButton *done = [UIButton buttonWithType:UIButtonTypeCustom];
    done.frame = CGRectMake(0, 0, 40, 40);
    
    [done setTitle:@"完成" forState:UIControlStateNormal];
    [done setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:done];
    [done addTarget:self action:@selector(leaveEditMode) forControlEvents:UIControlEventTouchUpInside];
}

#pragma 点击textField 的响应事件
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 0) {
        nameInput = textField.text;
        self.address.deliverName = textField.text;
    }else if (textField.tag == 2){
        self.address.deliverTelephone = textField.text;
        mobileInput = textField.text;
    }else if (textField.tag ==3){
        self.address.deliverFixedTelephone =textField.text;
        phoneInput = textField.text;
    }else if (textField.tag ==9){
        self.address.deliverPostCode = textField.text;
        zipCodeInput = textField.text;
    }else if (textField.tag ==10){
        self.address.deliverAddress =textField.text;
        addressInput = textField.text;
        
    }
    
}

- (BOOL)checkTel:(NSString *)str

{
    
    if ([str length] == 0) {
        
        //        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"data_null_prompt", nil) message:NSLocalizedString(@"tel_no_null", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //
        //        [alert show];
        
        
        return NO;
        
    }
    
    //1[0-9]{10}
    
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    
    //    NSString *regex = @"[0-9]{11}";
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        
        //        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //
        //        [alert show];
        
        
        return NO;
        
    }
    
    
    
    return YES;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}


-(void)submit{
    //判断输入框内容是否符合要求
    if (nameInput.length < 2 || nameInput.length > 12) {
        [ShowMessage showMessage:@"请正确输入姓名"];
    }else if([self checkTel:mobileInput]==NO||mobileInput.length < 11){
        [ShowMessage showMessage:@"输入的手机号码有误"];
    }else if(areaInput ==nil || [areaInput isEqualToString:@""]||[areaInput isEqualToString:@"请选择"]){
        [ShowMessage showMessage:@"请选择所在省份"];
    }else if (cityInput ==nil || [cityInput isEqualToString:@""]||[cityInput isEqualToString:@"请先选择省份"]||[cityInput isEqualToString:@"请选择"]){
        [ShowMessage showMessage:@"请选择所在城市"];
    }else if (squareInput ==nil || [squareInput isEqualToString:@""]||[squareInput isEqualToString:@"请先选择城市"]||[squareInput isEqualToString:@"请选择"]){
        [ShowMessage showMessage:@"请选择所在区县"];
    }else if (addressInput ==nil || [addressInput isEqualToString:@""]){
        [ShowMessage showMessage:@"请输入详细地址"];
        
    } else {
        
        NSString *isFlags;
        if (isFlag) {
            isFlags = @"1";
        }else{
            isFlags = @"0";
        }
        province_code = _address.deliverProvinceCode;
        city_code = _address.deliverCityCode;
        country_code = _address.deliverCountyCode;
        addressid = _address.deliverId;
        
        if (zipCodeInput == nil) {
            zipCodeInput = @"";
        }
        if (phoneInput ==nil) {
            phoneInput = @"";
        }
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:addressid forKey:@"id"];
        [dic setObject:nameInput forKey:@"deliver_name"];
        [dic setObject:areaInput forKey:@"province_name"];
        [dic setObject:cityInput forKey:@"city_name"];
        [dic setObject:squareInput forKey:@"county_name"];
        [dic setObject:addressInput forKey:@"address"];
        [dic setObject:zipCodeInput forKey:@"post_code"];
        [dic setObject:isFlags forKey:@"is_default"];
        [dic setObject:mobileInput forKey:@"telephone"];
        [dic setObject:phoneInput forKey:@"fixed_telephone"];
        [dic setObject:province_code forKey:@"province_code"];
        [dic setObject:city_code forKey:@"city_code"];
        [dic setObject:country_code forKey:@"county_code"];
        
        NSData *jsonData = [NSJSONSerialization
                            dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        
        NSDictionary *bodydic = [NSDictionary dictionaryWithObjectsAndKeys:jsonString,@"data", nil];
        [DeliverAddressServer getdeliveredit:bodydic :^(id obj,NSError* error) {
            Result *edit_Result = (Result*)obj;
            NSString *message = edit_Result.msg;
            
            if (edit_Result.success ==YES) {
                [self.navigationController popViewControllerAnimated:YES];
                [ShowMessage showMessage:message];
            }else{
                if ([edit_Result.code isEqualToString:@"020"]) {
                    [ShowMessage showMessage:@"保存失败"];
                }
                else{
                    [ShowMessage showMessage:message];
                }
            }
            
        }];
    }
    
    NSLog(@"just submiting");
    
}
-(void)code{
    
    [AreaService GetSquare:city_code view:self.view callback:^(id obj,NSError* error) {
        [country_name_array removeAllObjects];
        [country_code_array removeAllObjects];
        NSArray *result_array = [[NSArray alloc]init];
        result_array = obj;
        for (int i =0; i < result_array.count; i++) {
            Area *area_data = [[Area alloc]init];
            area_data = result_array[i];
            [country_code_array addObject:area_data.AreaCode];
            [country_name_array addObject:area_data.AreaName];
            
        }
        [areaPicker reloadAllComponents];
        [cityPicker reloadAllComponents];
        [squarePicker reloadAllComponents];
    }];
    
    [AreaService GetCity:province_code view:self.view callback:^(id obj,NSError* error) {
        [city_name_array removeAllObjects];
        [city_code_array removeAllObjects];
        NSArray *result_array = [[NSArray alloc]init];
        result_array = obj;
        for (int i =0; i < result_array.count; i++) {
            Area *area_data = [[Area alloc]init];
            area_data = result_array[i];
            [city_code_array addObject:area_data.AreaCode];
            [city_name_array addObject:area_data.AreaName];
        }
        [areaPicker reloadAllComponents];
        [cityPicker reloadAllComponents];
        [squarePicker reloadAllComponents];
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        if (actionSheet == self.areaSheet) {
            
            if (province_code == nil||[province_code isEqualToString:@""]) {
                
            }else{
                [AreaService GetCity:province_code view:self.view callback:^(id obj,NSError* error) {
                    [city_name_array removeAllObjects];
                    [city_code_array removeAllObjects];
                    NSArray *result_array = [[NSArray alloc]init];
                    result_array = obj;
                    for (int i =0; i < result_array.count; i++) {
                        Area *area_data = [[Area alloc]init];
                        area_data = result_array[i];
                        [city_code_array addObject:area_data.AreaCode];
                        [city_name_array addObject:area_data.AreaName];
                    }
                    [areaPicker reloadAllComponents];
                    [cityPicker reloadAllComponents];
                    [squarePicker reloadAllComponents];
                    
                }];
                
            }
            
            
        }else if (actionSheet == self.citySheet){
            
            if (city_code == nil||[city_code isEqualToString:@""]) {
                
            }else{
                [AreaService GetSquare:city_code view:self.view callback:^(id obj,NSError* error) {
                    [country_name_array removeAllObjects];
                    [country_code_array removeAllObjects];
                    NSArray *result_array = [[NSArray alloc]init];
                    result_array = obj;
                    for (int i =0; i < result_array.count; i++) {
                        Area *area_data = [[Area alloc]init];
                        area_data = result_array[i];
                        [country_code_array addObject:area_data.AreaCode];
                        [country_name_array addObject:area_data.AreaName];
                        
                    }
                    [areaPicker reloadAllComponents];
                    [cityPicker reloadAllComponents];
                    [squarePicker reloadAllComponents];
                }];
            }
            
           
        }else if (actionSheet == self.squareSheet){
            
            
        }
        
         [self.tableView reloadData];
    }
    
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
