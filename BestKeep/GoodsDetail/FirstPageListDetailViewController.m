//
//  FirstPageListDetailViewController.m
//  
//
//  Created by UTOUU on 15/9/18.
//
//

#import "FirstPageListDetailViewController.h"
#import "ListDetailImageView.h"
#import "ListDetailPriceView.h"
#import "ListDetailParameterView.h"
#import "ListDetailFooterView.h"
#import "Masonry.h"
#import "ConfirmationIndentViewController.h"
#import "TextCell.h"
#import "ImageCell.h"
#import "UMSocialSnsService.h"
#import "UMSocialQQHandler.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "Result.h"
#import "Userinfo.h"
#import "SelectCell.h"
#import "BuyCarViewController.h"

#import "UTMessageView.h"
#import "LoadingView.h"

#define RgbColor(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define HEADERVIEWTAG 1000

@interface FirstPageListDetailViewController ()

@property (nonatomic,strong) UITableView* detailTableView;
@property (nonatomic,strong) ListDetailImageView* listDetailImageView; // 详情页头部
@property (nonatomic,strong) ListDetailPriceView* listDetailPriceView;
@property (nonatomic,strong) ListDetailParameterView* listDetailParameterView;
@property (nonatomic,strong) ListDetailFooterView* listDetailFooterView;


@property (nonatomic,strong) ListDetailBuyView* listDetailBuyView;  //底部弹出视图头部
@property (nonatomic,strong) ListDetialBuyFooterView* listDetialBuyFooterView; // 尾部
@property (nonatomic,strong) UIView* popView;
@property (nonatomic,strong) UITableView* popTableView;
@property (nonatomic,strong) UIButton* trueBtn;
@property (nonatomic, strong) NSTimer *timer;  //定时器

@end

@implementation FirstPageListDetailViewController
{
    NSInteger currentPage; // 记录当前页
    NSMutableArray* titleData; //记录按钮标题
    NSMutableArray* btnData;
    
    ListDetailBuyDetail* listDetailBuyDetail;  //按钮选择视图  中部
    GoodsDataModel *goodsModel;//数据模型
    BOOL isSaved;
}

- (void)data{//goodsNo = "81118029"87944221
    [LoadingView showLoadViewToView:self.view];
    __weak typeof(self)wSelf = self;
    [BKService GoodsDetail:self.goods_no view:self.view CompeletionCallBack:^(id obj, NSError *error) {
        if(error){
            [LoadingView hideLoadViewToView:wSelf.view];
            UTMessageView * messageView = [UTMessageView showEmptyMsgViewTo:self.view logoLabelText:@"" emptyText:@"加载失败" buttonTitle:@"重新加载" animationed:YES];
            [messageView setRetryBlock:^{
                [wSelf data];
            }];
            
        }else{
            
        goodsModel = obj;
        for (PropertyList *temp_pList in goodsModel.goodsDetailDTO.propertyList) {
            [titleData addObject:temp_pList.name];
            [btnData addObject:temp_pList.propertyRelList];
        }
        
        for (ParamList *pl in goodsModel.paramList) {
            NSString *param = [NSString stringWithFormat:@"%@: %@",pl.name,pl.value];
            [self.param_array addObject:param];
        }
            
         _listDetailBuyView.goodsDataModel = goodsModel;//购买页面头部视图数据
       self.saveCount = _listDetailBuyView.reservice;
        
        [self getGoodsImage:goodsModel];
        [self getSaveBtnselect];
            
        [LoadingView hideLoadViewToView:wSelf.view];
//        [_popTableView reloadData];
//        [_detailTableView reloadData];
            [self initView];
        }
        
     }];
}
-(void)getGoodsImage:(GoodsDataModel*)goodModel{
    for (ImgList *temp_imglist in goodsModel.imgList) {
        switch ([temp_imglist.imageType integerValue]) {
            case 1:
                [self.image1_array addObject:temp_imglist.imageUrl];
                break;
            case 2:
                [self.image2_array addObject:temp_imglist.imageUrl];
                break;
            case 3:
                [self.image3_array addObject:temp_imglist.imageUrl];
                self.image3 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:temp_imglist.imageUrl]]];
                break;
            default:
                break;
            }
        }
    if (self.image3_array.count != 0) {
        self.image1_array = self.image3_array;
    }
    else if (self.image2_array != 0) {
        self.image1_array = self.image2_array;
    }else{
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 25, 25);
    [leftButton setImage:[UIImage imageNamed:@"iconfont-cartfill"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    [leftButton addTarget:self action:@selector(gotoShop) forControlEvents:UIControlEventTouchUpInside];
    if ([[Userinfo getbacktag] isEqualToString:@"1"]) {
        [self hiddenPopView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_03;
    self.isx = NO;
    self.isCount = NO;
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tabBarController.tabBar.hidden = YES;
    //[self detailHeaderView];
//    [self initView];
    titleData = [NSMutableArray new];
    btnData = [NSMutableArray new];
    self.param_array = [NSMutableArray new];
    self.image1_array = [NSMutableArray new];
    self.image2_array = [NSMutableArray new];
    self.image3_array = [NSMutableArray new];
    self.result_dic = [NSMutableDictionary dictionary];
    self.select_dic = [NSMutableDictionary dictionary];
    self.orderInfo_dic = [NSMutableDictionary dictionary];
    self.proname_arry = [NSMutableArray new];
    [self data];
    
}

- (ListDetailImageView*)detailHeaderView
{
    _listDetailImageView = [[ListDetailImageView alloc] initWithFrame:CGRectMake(0 , 0, SCREEN_WIDTH, 200)];
    _listDetailImageView.detailImageScroll.pagingEnabled = YES;
    _listDetailImageView.detailImageScroll.tag = HEADERVIEWTAG;
  
    [_listDetailImageView.detailImageScroll setContentOffset:CGPointMake(0, 0)];
    [_listDetailImageView.detailImageScroll setBounces:NO];
    [_listDetailImageView.detailImageScroll setShowsHorizontalScrollIndicator:NO];
    [_listDetailImageView.detailImageScroll setShowsVerticalScrollIndicator:NO];
    _listDetailImageView.detailImageScroll.delegate = self;
    
    
    _listDetailImageView.detailImagePageControl.currentPage = 0;
    _listDetailImageView.detailImagePageControl.userInteractionEnabled = NO;

    [_listDetailImageView.detailImageScroll setContentSize:CGSizeMake(SCREEN_WIDTH * (self.image1_array.count),0)];
    _listDetailImageView.detailImagePageControl.numberOfPages = self.image1_array.count;
    
    for (int i = 0; i < self.image1_array.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        CGFloat imageX = i * SCREEN_WIDTH;
        imageView.frame = CGRectMake(imageX, 0, SCREEN_WIDTH, 200);
        [imageView sd_setImageWithURL:[NSURL URLWithString:[self.image1_array objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"defult"]];
         [_listDetailImageView.detailImageScroll addSubview:imageView];
    }
    
    return _listDetailImageView;
}
- (void)initView
{
   [self addTimer];
    
    _detailTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _detailTableView.delegate = self;
    _detailTableView.dataSource = self;
    _detailTableView.backgroundColor = RgbColor(234, 234, 234);
    _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_detailTableView];
    
#pragma mark - 底部工具条按钮
    _listDetailFooterView = [[ListDetailFooterView alloc] init];  //底部工具条
    [_listDetailFooterView.shareButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_listDetailFooterView.saveButton addTarget:self action:@selector(saveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    switch ([self.readyBuy integerValue]) {
        case 0://下架
            _listDetailFooterView.buyButton.userInteractionEnabled = NO;
            _listDetailFooterView.buyButton.backgroundColor = [UIColor lightGrayColor];
            _listDetailFooterView.addButton.userInteractionEnabled = NO;
            _listDetailFooterView.addButton.backgroundColor = [UIColor grayColor];
            [_listDetailFooterView.buyButton setTitle:@"已下架" forState:UIControlStateNormal];

            break;
        case 3://预购
            [_listDetailFooterView.buyButton setTitle:@"预购" forState:UIControlStateNormal];
            break;
        case 1://现货
            break;
        case 2://售罄
            _listDetailFooterView.buyButton.userInteractionEnabled = NO;
            _listDetailFooterView.buyButton.backgroundColor = [UIColor lightGrayColor];
            _listDetailFooterView.addButton.userInteractionEnabled = NO;
            _listDetailFooterView.addButton.backgroundColor = [UIColor grayColor];
            [_listDetailFooterView.buyButton setTitle:@"售罄" forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }

    [_listDetailFooterView.addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_listDetailFooterView.buyButton addTarget:self action:@selector(buyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_listDetailFooterView];
    
#pragma mark - 购买确定按钮
    _trueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_trueBtn setTitle:@"预购" forState:UIControlStateNormal];
    [_trueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_trueBtn setBackgroundColor:COLOR_14];
    [_trueBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:20.0]];
    [_trueBtn addTarget:self action:@selector(comfireOrder) forControlEvents:UIControlEventTouchUpInside];

#pragma mark - 弹出视图
    _popTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _popTableView.delegate = self;
    _popTableView.dataSource = self;
    _popTableView.backgroundColor = [UIColor whiteColor];
    
    _popView = [[UIView alloc] init];
    _popView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    _popView.frame = CGRectMake(0, SCREEN_HEIGHT - 0.1, SCREEN_WIDTH, 0.1);
    [_popView addSubview:_popTableView];
    [_popView addSubview:_trueBtn];
    [self.view addSubview:_popView];
    _popView.hidden = YES;
    
    _listDetailBuyView = [[ListDetailBuyView  alloc] init];  //详情头部
    _listDetailBuyView.ready_buy = self.readyBuy;
    [_listDetailBuyView.cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _listDetailBuyView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [_popView addSubview:_listDetailBuyView];
    
    _listDetialBuyFooterView = [[ListDetialBuyFooterView  alloc] init]; //  详情尾部
    [_listDetialBuyFooterView.addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_listDetialBuyFooterView.reduceBtn addTarget:self action:@selector(reduceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_popView addSubview:_listDetialBuyFooterView];
    
    [_listDetailFooterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(@(50));
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
    }];
    
    [_detailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.bottom.mas_equalTo(_listDetailFooterView.mas_top).offset(0);
    }];
    
    [_popView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
    }];
    
    [_trueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_popView.mas_left);
        make.right.mas_equalTo(_popView.mas_right);
        make.bottom.mas_equalTo(_popView.mas_bottom);
        make.height.mas_equalTo(@(50));
    }];

    [_listDetailBuyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_popView.mas_left);
        make.right.mas_equalTo(_popView.mas_right);
        make.top.mas_equalTo(_popView.mas_top).offset(0);
        make.height.mas_equalTo(@(220));
    }];
    
    [_listDetialBuyFooterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_popView.mas_left);
        make.right.mas_equalTo(_popView.mas_right);
        make.bottom.mas_equalTo(_trueBtn.mas_top);
        make.height.mas_equalTo(@(50));
    }];
    
    [_popTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_popView.mas_left);
        make.right.mas_equalTo(_popView.mas_right);
        make.top.mas_equalTo(_listDetailBuyView.mas_bottom).offset(0);
        make.bottom.mas_equalTo(_listDetialBuyFooterView.mas_top).offset(0);
    }];
}
#pragma mark tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _popTableView) {
        return 1;
    }
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _popTableView) {
        listDetailBuyDetail = [[ListDetailBuyDetail  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ACell"];
        
            float heightY = [self createdBtnSelectViewWithTitle:[titleData objectAtIndex:indexPath.row] andBtn:[btnData objectAtIndex:indexPath.row]];
            return heightY;
    }
    else if (tableView == _detailTableView) {
        if (indexPath.section == 0) {
            if ([goodsModel.goodsDTO.channelId isEqualToString:@"1"]) {
                return 280;
            }
            return 170;
        }
        else if(indexPath.section == 1){
            return 44;
        }
        else if (indexPath.section == 2) {
            if (goodsModel.paramList.count == 0) {
                return 0;
            }else{
                _listDetailParameterView = [[ListDetailParameterView alloc] init];
                return [self createDetailLabel:self.param_array];
            }
        }
        else{
            if (indexPath.row == 0) {
                if (![goodsModel.goodsDTO.remark isEqualToString:@""] || goodsModel.goodsDTO.remark != nil) {
                    CGFloat height = [Common boundingRectWithSize:goodsModel.goodsDTO.remark Font:[UIFont systemFontOfSize:14] Size:CGSizeMake(SCREEN_WIDTH - 20, 2000)].height;
                    return height;
                }else{
                    return 0;
                }
            }else{
                if (self.image2_array.count != 0) {
                    return 200;
                }
                else{
                    return 0;
                }
            }
        }
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _popTableView) {
        return titleData.count;
    }else {
        if (section == 3) {
            if (([goodsModel.goodsDTO.remark isEqualToString:@""]||goodsModel.goodsDTO.remark == nil) && self.image2_array.count != 0) {
                return self.image2_array.count;
            }
            else if(![goodsModel.goodsDTO.remark isEqualToString:@""]&&self.image2_array.count != 0){
                return self.image2_array.count + 1;
            }
            else{
                return 0;
            }
        }
        else{
            return 1;
        }
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView == _popTableView) {
    return 0.1;
    }
    return 10.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == _detailTableView) {
        if (self.image1_array.count != 0) {
            if (section == 0) {
                return 180;
            }
        }
    }
    return 0.1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _popTableView) {
            
            //if (titleData.count != 0 && btnData.count != 0){
                listDetailBuyDetail = [[ListDetailBuyDetail  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ACell"];
                [listDetailBuyDetail createdBtnSelectViewWithTitle:[titleData objectAtIndex:indexPath.row] andBtn:[btnData objectAtIndex:indexPath.row]];
                listDetailBuyDetail.selectionStyle = UITableViewCellSelectionStyleNone;
                listDetailBuyDetail.delegate =self;
                return listDetailBuyDetail;//系列
       // }
        //return nil;
    }
    
    if (tableView == _detailTableView) {
        if (indexPath.section == 0 ) {
            if (![goodsModel.goodsDTO.channelId isEqualToString:@"1"]) {
                ListDetailPriceView* cell = [[ListDetailPriceView alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.tag = 1000;
                cell.goodsModel = goodsModel;
                switch ([self.readyBuy integerValue]) {
                    case 1:
                        if (![goodsModel.goodsDTO.deliverBeginDays isEqualToString:@"0"] && ![goodsModel.goodsDTO.deliverEndDays isEqualToString:@"0"]) {
                            cell.adressLabel.text = [NSString stringWithFormat:@"发货地: %@(%@~%@天发货)",goodsModel.goodsDTO.deliverAddressName,goodsModel.goodsDTO.deliverBeginDays,goodsModel.goodsDTO.deliverEndDays];
                        }else{
                            cell.adressLabel.text = [NSString stringWithFormat:@"发货地: %@",goodsModel.goodsDTO.deliverAddressName];
                        }
                        
                        break;
                    case 3:
                        if (![goodsModel.putawayTypeStr isEqualToString:@""]) {
                            cell.adressLabel.text = [NSString stringWithFormat:@"发货地: %@(%@)",goodsModel.goodsDTO.deliverAddressName,goodsModel.putawayTypeStr];
                        }
                        break;
                    default:
                       cell.adressLabel.text = [NSString stringWithFormat:@"发货地: %@",goodsModel.goodsDTO.deliverAddressName];
                        break;
                }
                
                return cell;

            }else{
                ListDetailPriceViewBuyEarth *cell = [[ListDetailPriceViewBuyEarth alloc] init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.tag = 2000;
                cell.goodsModel = goodsModel;
                switch ([self.readyBuy integerValue]) {
                    case 1:
                        cell.adressLabel.text = [NSString stringWithFormat:@"发货地: %@(预计%@~%@天发货)",goodsModel.goodsDTO.deliverAddressName,goodsModel.goodsDTO.deliverBeginDays,goodsModel.goodsDTO.deliverEndDays];
                        break;
                    case 3:
                        if (![goodsModel.putawayTypeStr isEqualToString:@""]) {
                            cell.adressLabel.text = [NSString stringWithFormat:@"发货地: %@ 预计%@",goodsModel.goodsDTO.deliverAddressName,goodsModel.putawayTypeStr];
                        }
                        break;
                    default:
                        cell.adressLabel.text = [NSString stringWithFormat:@"发货地: %@",goodsModel.goodsDTO.deliverAddressName];
                        break;
                }

                return cell;
            }
        }
        else if (indexPath.section == 1 ) {
            if ([self.readyBuy isEqualToString:@"3"]) {
                //if (![goodsModel.preSaleReserveAmount isEqualToString:@"0"]) {
                    SelectCell *cell = [[SelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectcell"];
                    cell.selectLabel.text = @"选择系列、尺码";
                    cell.tag = 3000;
                    return cell;
                //}
            }else if ([self.readyBuy isEqualToString:@"1"]){
                SelectCell *cell = [[SelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectcell"];
                cell.selectLabel.text = @"选择系列、尺码";
                cell.tag = 3000;
                return cell;
            }else if ([self.readyBuy isEqualToString:@"2"]){
                return [self selectCell:tableView cellForRowAtIndexPath:indexPath str:@"该商品已售罄,无法进行购买!"];
            }else{
                return [self selectCell:tableView cellForRowAtIndexPath:indexPath str:@"该商品已下架,无法进行购买!"];
            }
//            NSString *s = self.readyBuy;
//            return [self selectCell:tableView cellForRowAtIndexPath:indexPath str:@"该商品已下架,无法进行购买!"];
        }
       else if (indexPath.section == 2 ) {
            _listDetailParameterView = [[ListDetailParameterView alloc] init];
            _listDetailParameterView.selectionStyle = UITableViewCellSelectionStyleNone;
            [_listDetailParameterView createDetailLabel:self.param_array];
            return _listDetailParameterView;
       }else{
           if (indexPath.row == 0) {
              return   [self textCell:tableView cellForRowAtIndexPath:indexPath];
           }
           else{
               return [self imageCell:tableView cellForRowAtIndexPath:indexPath];
           }
       }
    }
    return nil;
}
- (UITableViewCell *)selectCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath str:(NSString*)str{
    
    UITableViewCell* selectCell = [tableView dequeueReusableCellWithIdentifier:@"selectcell"];
    if (selectCell == nil) {
       selectCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectcell"];
    }
    selectCell.selectionStyle = UITableViewCellSelectionStyleNone;
    selectCell.userInteractionEnabled = NO;
    UILabel *saleLabel = [self setLabel:CGRectMake(0, 0, SCREEN_WIDTH, selectCell.frame.size.height) describe:str];
    [selectCell addSubview:saleLabel];
    return selectCell;
}
- (UITableViewCell *)textCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TextCell *textCell = [tableView dequeueReusableCellWithIdentifier:@"textcell"];
    if (textCell == nil) {
        textCell = [[TextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"textcell"];
        textCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
   textCell.detailView.text = goodsModel.goodsDTO.remark;
    return textCell;
}
- (UITableViewCell *)imageCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ImageCell *imageCell = [tableView dequeueReusableCellWithIdentifier:@"imagecell"];
    if (imageCell == nil) {
        imageCell = [[ImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"imagecell"];
        imageCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [imageCell.detailImage sd_setImageWithURL:[NSURL URLWithString:[self.image2_array objectAtIndex:indexPath.row-1]] placeholderImage:[UIImage imageNamed:@"default"]];
    return imageCell;
}

-(UILabel*)setLabel:(CGRect)rect describe:(NSString*)describe{
    UILabel *saleLabel = [[UILabel alloc] initWithFrame:rect];
    saleLabel.text = describe;// @"该商品已售罄,无法进行购买!";
    saleLabel.font = [UIFont systemFontOfSize:14];
    saleLabel.textColor = COLOR_02;
    saleLabel.textAlignment = NSTextAlignmentCenter;
    return saleLabel;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == _detailTableView) {
        if (section == 0) {
            if (self.image1_array.count != 0) {
                return    [self detailHeaderView];
            }
       }
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (tableView == _popTableView) {
       
    }
    if (tableView == _detailTableView) {
        if (indexPath.section == 1) {
            NSLog(@"弹出视图");
            self.buttontag = ATONCEBUY;
            [_trueBtn setTitle:@"预购" forState:UIControlStateNormal];
            [self popViewWithDetail];
        }
    }
}
#pragma mark- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag != HEADERVIEWTAG) {
        return;
    }
    CGFloat scrollW = scrollView.frame.size.width;
    int page = (scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
    _listDetailImageView.detailImagePageControl.currentPage = page;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView.tag != HEADERVIEWTAG) {
        return;
    }
    [self removeTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.tag != HEADERVIEWTAG) {
        return;
    }
    [self addTimer];
}
- (void)addTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextImage
{
    long page = 0;
    if (_listDetailImageView.detailImagePageControl.currentPage == self.image1_array.count - 1) {
        page = 0;
    } else {
        page = _listDetailImageView.detailImagePageControl.currentPage + 1;
    }

    CGFloat offsetX = page * _listDetailImageView.detailImageScroll.frame.size.width;
    CGPoint offset = CGPointMake(offsetX, 0);
    [_listDetailImageView.detailImageScroll setContentOffset:offset animated:YES];
}
#pragma mark - selectButtonDelegate
-(void)selectGoodsProperty:(PropertyReList *)propertyReList{
    self.isx = YES;
    self.ids = @"";
    self.saveCount = @"1";
    [self.select_dic setObject:propertyReList forKey:propertyReList.proName];
#pragma mark 查找对应的分组下标  组成新的字典
    NSArray *pList_array = goodsModel.goodsDetailDTO.propertyList;
    NSArray *keys = [self.select_dic allKeys];
    for (NSString *temp_key in keys) {
        for (int position = 0; position < [pList_array count]; position++) {
            PropertyList *temp_list = [pList_array objectAtIndex:position];
            NSString *temp_name = temp_list.name;
            [self.proname_arry addObject:temp_name];
            if ([temp_key isEqualToString:temp_name]) {
                [self.result_dic setObject:[self.select_dic objectForKey:temp_name] forKey:[NSString stringWithFormat:@"%d",position]];
            }
        }
    }
    NSArray *allkeys = [self.result_dic allKeys];
    NSMutableArray *select_array = [[NSMutableArray alloc] init];
    self.result_dic =  [self sortedDic:allkeys];
    for (NSString *_position in self.result_dic) {
        PropertyReList *pr = [self.result_dic objectForKey:_position];
        self.ids = [self.ids stringByAppendingString:pr.id];
        [select_array addObject:pr.id];
    }
    //[self selectStringdata:self.ids];
    [self selectArraydata:select_array];
    [self changeProNameAndImage:propertyReList];
}
#pragma mark 比较字符串并查找相关数据 并赋值
-(void)selectArraydata:(NSArray*)arrayValue{
    NSArray *temp_array = goodsModel.goodsDetailDTO.reserveList;
    NSMutableDictionary *temp_dic = [NSMutableDictionary dictionary];
    BOOL isContains = false;
    for (ReserveList *temp_rList in temp_array) {
        NSString *goodsStr1 = temp_rList.goodsProRelIdStr;
        NSArray *id_array = [goodsStr1 componentsSeparatedByString:@","];
        NSMutableArray *temp1_array = [NSMutableArray new];
        for (NSString *str in id_array) {
            if (![str isEqualToString:@""]) {
                [temp1_array addObject:str];
            }
        }
        [temp_dic setObject:temp_rList forKey:temp1_array];
        if (arrayValue.count == temp1_array.count) {
            for (NSString *str in arrayValue) {
                if ([temp1_array indexOfObject:str]== NSNotFound) {
                    isContains = NO;
                    break;
                }else{
                    isContains = YES;
                }
            }
        }
        if (isContains) {
            self.reserveListModel = temp_rList;
            [self changeValue:temp_rList];
        }
    }
}
//-(void)selectStringdata:(NSString*)stringValue{
//    
//    NSMutableDictionary *temp_dic = [NSMutableDictionary dictionary];
//    NSArray *temp_array = goodsModel.goodsDetailDTO.reserveList;
//    for (ReserveList *temp_rList in temp_array) {
//        NSString *goodsStr1 = temp_rList.goodsProRelIdStr;
//        goodsStr1 = [goodsStr1 stringByReplacingOccurrencesOfString:@"," withString:@""];
//        if ([stringValue isEqualToString: goodsStr1]) {
//            [temp_dic setObject:temp_rList forKey:stringValue];
//            self.reserveListModel = temp_rList;
//            [self changeValue:temp_rList];
//            return;
//        }
//    }
//}

-(void)updateDetailTableViewData:(ReserveList*)reserveList{
    if ([goodsModel.goodsDTO.channelId isEqualToString:@"1"]) {
        //全球购
        ListDetailPriceViewBuyEarth *listcell = (ListDetailPriceViewBuyEarth*)[self.view viewWithTag:2000];
        listcell.marketPrice.text  = [NSString stringWithFormat:@"¥ %.2f",[reserveList.marketPrice doubleValue]];
        listcell.marketPrice.text = [NSString stringWithFormat:@"¥ %.2f",[reserveList.marketPrice doubleValue]];
        listcell.VIPPrice.text = [NSString stringWithFormat:@"¥ %.2f",[reserveList.price floatValue] - floor([reserveList.price floatValue]*[goodsModel.goodsDTO.shoppingGuideRatio doubleValue])];
        double tax =  floor(([reserveList.price doubleValue] - floor([reserveList.price floatValue]*[goodsModel.goodsDTO.shoppingGuideRatio doubleValue])) * [goodsModel.goodsDTO.taxRatio doubleValue]);
        listcell.tangLabel.text = [NSString stringWithFormat:@"糖赋: ¥ %@",[NSString stringWithFormat:@"%.2f",tax]];
        listcell.haiguan.text = [NSString stringWithFormat:@"海关税费:￥%.2f",[reserveList.price doubleValue] * [goodsModel.goodsDTO.linePostTaxRatio doubleValue]];
        NSString *gong = [NSString stringWithFormat:@"%.2f",tax/100];
        listcell.dataLabel.text = [NSString stringWithFormat:@"%@",gong];
    }else{
        //非全球购
        ListDetailPriceView *listcell = (ListDetailPriceView*)[self.view viewWithTag:1000];
        listcell.marketPrice.text = [NSString stringWithFormat:@"¥ %.2f",[reserveList.marketPrice doubleValue]];
        listcell.VIPPrice.text = [NSString stringWithFormat:@"¥ %.2f",[reserveList.price floatValue] - floor([reserveList.price floatValue]*[goodsModel.goodsDTO.shoppingGuideRatio doubleValue])];
        double tax =  floor(([reserveList.price doubleValue] - floor([reserveList.price floatValue]*[goodsModel.goodsDTO.shoppingGuideRatio doubleValue])) * [goodsModel.goodsDTO.taxRatio doubleValue]);
        listcell.tangLabel.text = [NSString stringWithFormat:@"糖赋: ¥ %@",[NSString stringWithFormat:@"%.2f",tax]];
        NSString *gong = [NSString stringWithFormat:@"%.2f",tax/100];
        listcell.dataLabel.text = [NSString stringWithFormat:@"%@",gong];
    }
}

-(void)changeValue:(ReserveList*)reserveList{
    
    _listDetailBuyView.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[reserveList.price floatValue] - floor([reserveList.price floatValue]*[goodsModel.goodsDTO.shoppingGuideRatio doubleValue])];
   // NSString *s = self.readyBuy;
    if ([self.readyBuy isEqualToString:@"3"]) {
        if (![reserveList.amount isEqualToString:@"0"]) {
            _listDetailBuyView.saveLabel.text = [NSString stringWithFormat:@"%@%@%@",@"现货库存 ",reserveList.amount,@" 件"];
            self.saveCount = reserveList.amount;
        }else if(![reserveList.preSaleAmount isEqualToString:@"0"]){
            _listDetailBuyView.saveLabel.text = [NSString stringWithFormat:@"%@%@%@",@"预购库存 ",reserveList.preSaleAmount,@" 件"];
            self.saveCount = reserveList.preSaleAmount;
        }else{
             _listDetailBuyView.saveLabel.text = [NSString stringWithFormat:@"%@%@%@",@"库存 ",@"0",@" 件"];
            self.saveCount = @"0";
        }

    }else{
        if (![reserveList.amount isEqualToString:@"0"]) {
            _listDetailBuyView.saveLabel.text = [NSString stringWithFormat:@"%@%@%@",@"现货库存 ",reserveList.amount,@" 件"];
            self.saveCount = reserveList.amount;
        }else if(![reserveList.preSaleAmount isEqualToString:@"0"]){
            _listDetailBuyView.saveLabel.text = [NSString stringWithFormat:@"%@%@%@",@"预购库存 ",reserveList.preSaleAmount,@" 件"];
            self.saveCount = reserveList.preSaleAmount;
        }else{
            _listDetailBuyView.saveLabel.text = [NSString stringWithFormat:@"%@%@%@",@"库存 ",@"0",@" 件"];
            self.saveCount = @"0";
        }

    }
    if ([self.saveCount isEqualToString:@"0"]) {
        _trueBtn.userInteractionEnabled = NO;
        _trueBtn.backgroundColor = [UIColor grayColor];
        _listDetailFooterView.addButton.userInteractionEnabled = NO;
        _listDetailFooterView.buyButton.userInteractionEnabled = NO;
        _listDetailFooterView.addButton.backgroundColor = [UIColor grayColor];
        _listDetailFooterView.buyButton.backgroundColor = [UIColor lightGrayColor];
    }else{
        _trueBtn.userInteractionEnabled = YES;
        [_trueBtn setBackgroundColor:COLOR_14];;
        _listDetailFooterView.addButton.userInteractionEnabled = YES;
        _listDetailFooterView.buyButton.userInteractionEnabled = YES;
        _listDetailFooterView.addButton.backgroundColor =  COLOR_14;
        _listDetailFooterView.buyButton.backgroundColor = COLOR_13;
    }
    [self updateDetailTableViewData:reserveList];
}
-(void)changeProNameAndImage:(PropertyReList*)pr{
    NSString *str = pr.relImg;
    SelectCell *listcell = (SelectCell*)[self.view viewWithTag:3000];
    

    if (![str isEqualToString:@""]&&str != nil) {
        [_listDetailBuyView.detailImageView sd_setImageWithURL:[NSURL URLWithString:pr.relImg] placeholderImage:[UIImage imageNamed:@"default"]];
    }
    NSArray *array = [self.result_dic allKeys];
    NSString *temp_str = @"已选择: ";
    NSString *temp_str1 = @"";
    for (NSString *key in array) {
        pr = [self.result_dic objectForKey:key];
        temp_str = [temp_str stringByAppendingString:pr.propertyValue];
        listcell.selectLabel.text = [temp_str1 stringByAppendingString:pr.propertyValue];
    }
    _listDetailBuyView.colorLabel.text = temp_str;
}

-(BOOL)isAllSelect{
    self.isSelect = false;
    NSArray *keys1 = [self.select_dic allKeys];
    NSArray *names = self.proname_arry;
    //self.isx = NO;
    if (keys1.count == 0){
        [ShowMessage showMessage:@"请选择商品属性" withCenter:self.view.center];
    }else{
        for (NSString *str in names) {
            if ([keys1 indexOfObject:str]== NSNotFound) {
                [ShowMessage showMessage:[NSString stringWithFormat:@"%@%@",@"请选择",str] withCenter:self.view.center];
                self.isSelect = NO;
                break;
            }else{
                self.isSelect = YES;
            }
        }
    }
    return self.isSelect;
}
#pragma mark  提交订单
-(void)comfireOrder{
    if ([Common isLogin]) {
        self.isSelect = false;
        self.isx = YES;
        NSArray *keys1 = [self.select_dic allKeys];
        NSArray *keys2 = [self.result_dic allKeys];
        NSArray *names = self.proname_arry;
        if (self.buttontag == ADDBUYCAR) {
            if ([Common isLogin]) {
                if (goodsModel.goodsDetailDTO.propertyList.count == 0) {
                    NSDictionary *paramdic = [self paramdic];
                    NSString *strjson = [Common dictionaryToJson:paramdic];
                    [BKService addProduciontoShoppingCar:strjson view:self.view callback:^(id obj,NSError* error) {
                        Result *add_result = obj;
                        if (add_result != nil) {
                            [ShowMessage showMessage:add_result.msg withCenter:self.view.center];
                            [self hiddenPopView];
                        }
                    }];
                    
                }else{
                    if (self.isx) {
                        if ([self isAllSelect]) {
                            if ([self.saveCount isEqualToString:@"0"]) {
                                _trueBtn.userInteractionEnabled = NO;
                                [_trueBtn setBackgroundColor:[UIColor grayColor]];
                                [ShowMessage showMessage:@"库存不足" withCenter:self.view.center];
                            }else{
                                _trueBtn.userInteractionEnabled = YES;
                                [_trueBtn setBackgroundColor:COLOR_14];
                                NSDictionary *paramdic = [self paramdic];
                                NSString *strjson = [Common dictionaryToJson:paramdic];
                                [BKService addProduciontoShoppingCar:strjson view:self.view callback:^(id obj,NSError* error) {
                                    Result *add_result = obj;
                                    if (add_result != nil) {
                                        [ShowMessage showMessage:add_result.msg withCenter:self.view.center];
                                        [self hiddenPopView];
                                    }
                                }];
                            }
                        }
                        else{
                            [self popViewWithDetail];
                        }
                    }else{
                        [self popViewWithDetail];
                    }
                }
            }else{
                LoginController *loginVC = [[LoginController alloc]init];
                BKNavigationController *nv = [[BKNavigationController  alloc] initWithRootViewController:loginVC];
                [self presentViewController:nv animated:YES completion:nil];
            }
            
        }
        
        //！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
        else{
            //        self.isSelect = false;
            //        self.isx = YES;
            //        NSArray *keys1 = [self.select_dic allKeys];
            //        NSArray *keys2 = [self.result_dic allKeys];
            //        NSArray *names = self.proname_arry;
            if (goodsModel.goodsDetailDTO.propertyList.count == 0) {
                for (int i = 0; i < 5; i++) {
                    [self.orderInfo_dic setObject:@"" forKey:[NSString stringWithFormat:@"%@%d",@"goods_pro_rel",i+1]];
                }
                [self.orderInfo_dic setObject:_listDetialBuyFooterView.dataLabel.text forKey:@"amount"];
                [self.orderInfo_dic setObject:goodsModel.goodsDTO.id forKey:@"goods_id"];
                ConfirmationIndentViewController *coVC = [[ConfirmationIndentViewController alloc] init];
                coVC.sc_array = [NSMutableArray arrayWithObjects:self.orderInfo_dic, nil];
                coVC.formDetail = @"2";
                coVC.str_global = goodsModel.goodsDTO.channelId;
                [self.navigationController pushViewController:coVC animated:YES];
                
            }else{
                if (keys1.count == 0){
                    [ShowMessage showMessage:@"请选择商品属性" withCenter:self.view.center];
                }else{
                    for (NSString *str in names) {
                        if ([keys1 indexOfObject:str]== NSNotFound) {
                            [ShowMessage showMessage:[NSString stringWithFormat:@"%@%@",@"请选择",str] withCenter:self.view.center];
                            self.isSelect = NO;
                            break;
                        }else{
                            self.isSelect = YES;
                        }
                    }
                }
                if (self.isSelect) {
                    if (keys2.count != 0) {
                        if ([self.saveCount isEqualToString:@"0"]) {
                            [_trueBtn setBackgroundColor:[UIColor grayColor]];
                            _trueBtn.userInteractionEnabled = NO;
                            
                            [ShowMessage showMessage:@"库存不足" withCenter:self.view.center];
                        }
                        else{
                            [_trueBtn setBackgroundColor:COLOR_14];
                            _trueBtn.userInteractionEnabled = YES;
                            for (int i = 0; i < [keys2 count]; i++) {
                                NSString *key = [keys2 objectAtIndex:i];
                                PropertyReList *pr = [self.result_dic objectForKey:key];
                                [self.orderInfo_dic setObject:pr.id forKey:[NSString stringWithFormat:@"%@%d",@"goods_pro_rel",i+1]];
                            }
                            [self.orderInfo_dic setObject:_listDetialBuyFooterView.dataLabel.text forKey:@"amount"];
                            [self.orderInfo_dic setObject:goodsModel.goodsDTO.id forKey:@"goods_id"];
                            ConfirmationIndentViewController *coVC = [[ConfirmationIndentViewController alloc] init];
                            coVC.sc_array = [NSMutableArray arrayWithObjects:self.orderInfo_dic, nil];
                            coVC.formDetail = @"1";
                            coVC.str_global = goodsModel.goodsDTO.channelId;
                            [self.navigationController pushViewController:coVC animated:YES];
                        }
                    }else{
                        [self popViewWithDetail];
                    }
                }
            }
            
        }
    }else{
        LoginController *loginVC = [[LoginController alloc]init];
        BKNavigationController *nv = [[BKNavigationController  alloc] initWithRootViewController:loginVC];
        [self presentViewController:nv animated:YES completion:nil];
    }
}

#pragma mark 对字典进行排序
-(NSMutableDictionary*)sortedDic:(NSArray*)keys{
    NSMutableDictionary *temp_dic = [NSMutableDictionary dictionary];
    keys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result == NSOrderedDescending;
    }];
    for (NSString *key in keys) {
        [temp_dic setObject:[self.result_dic objectForKey:key] forKey:key];
    }
    return temp_dic;
}
#pragma mark 底部按钮点击事件
- (void)shareButtonClick:(UIButton*)sender //分享
{
    if ([Common isLogin]) {
        NSString *shareurl = [NSString stringWithFormat:@"%@%@?%@%@",@"http://m.bestkeep.cn/invite/",[Userinfo getVisitor_code],@"goods_no=",goodsModel.goodsDTO.goodsNo];
        [UMSocialQQHandler setSupportWebView:YES];
        [UMSocialWechatHandler setWXAppId:@"wx12ade979ef648797" appSecret:@"f9b523512927f15249dad73161d21934" url:shareurl];
        //qq空间和qq好友
        [UMSocialQQHandler setQQWithAppId:@"1104759459" appKey:@"ymbLBKw0coxYre0r" url:shareurl];
        NSString *shareContent = @"Bestkeep,基于用户精准需求的专业导购型电商平台，彻底去除造成成本浪费的中间环节，让商品回归本来价值";
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"53fbf399fd98c5a48f01c81f"
                                          shareText:shareContent
                                         shareImage:self.image3 shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ, nil]
                                           delegate:nil];

    }else{
        LoginController *loginVC = [[LoginController alloc]init];
        BKNavigationController *nv = [[BKNavigationController  alloc] initWithRootViewController:loginVC];
        [self presentViewController:nv animated:YES completion:nil];
    }
}

- (void)saveButtonClick:(UIButton*)sender //收藏
{
    if ([Common isLogin]) {
        [self getSaveBtnData];
        
    }else{
        LoginController *loginVC = [[LoginController alloc]init];
        BKNavigationController *nv = [[BKNavigationController  alloc] initWithRootViewController:loginVC];
        [self presentViewController:nv animated:YES completion:nil];
    }
}
- (void)getSaveBtnselect
{
    NSString* goods_id1 = goodsModel.goodsDTO.id;
    
    [BKService isSaveGoodsToCollect:goods_id1 view:nil callback:^(id obj,NSError* error){
        NSDictionary* dict = (NSDictionary*)obj;
        if (dict) {
            NSDictionary* dataDic = [dict objectForKey:@"data"];
            NSString* flag = [dataDic objectForKey:@"flag"];
            isSaved = [flag boolValue];
            if (isSaved) {
                [self setLabel:_listDetailFooterView.saveLabel ButtonImage:@"\U0000e601" color:COLOR_06];
            }else{
                [self setLabel:_listDetailFooterView.saveLabel ButtonImage:@"\U0000e602" color:COLOR_05];
            }
        }
    }];
}
- (void)getSaveBtnData
{
    NSString* goods_id1 = goodsModel.goodsDTO.id;
    
    [BKService isSaveGoodsToCollect:goods_id1 view:nil callback:^(id obj,NSError* error){
        NSDictionary* dict = (NSDictionary*)obj;
        if (dict) {
            NSDictionary* dataDic = [dict objectForKey:@"data"];
            NSString* flag = [dataDic objectForKey:@"flag"];
            isSaved = [flag boolValue];
            if (!isSaved) {
                [BKService addGoodsToCollect:goods_id1 view:nil callback:^(id obj,NSError* error) {
                    Result *collect_result = obj;
                    if (collect_result.success) {
                        [ShowMessage showMessage:collect_result.msg withCenter:self.view.center];
                        [self setLabel:_listDetailFooterView.saveLabel ButtonImage:@"\U0000e601" color:COLOR_06];
                    }else{
                        [ShowMessage showMessage:collect_result.msg withCenter:self.view.center];
                    }
                }];
            }else{
                
                [BKService deleteCollectGoods:goods_id1 view:nil callback:^(id obj,NSError* error) {
                    Result *collect_result = obj;
                    if (collect_result.success) {
                        [ShowMessage showMessage:collect_result.msg withCenter:self.view.center];
                        [self setLabel:_listDetailFooterView.saveLabel ButtonImage:@"\U0000e602" color:COLOR_05];
                    }else{
                        [ShowMessage showMessage:collect_result.msg withCenter:self.view.center];
                    }
                }];
            }
        }
    }];
}
-(void)setLabel:(UILabel *)iconLabel ButtonImage:(NSString*)iconText color:(UIColor*)color{
    iconLabel.translatesAutoresizingMaskIntoConstraints=NO;
    UIFont *iconfont1 = [UIFont fontWithName:@"iconfont" size:20];
    iconLabel.font = iconfont1;
    iconLabel.textAlignment = NSTextAlignmentCenter;
    iconLabel.text = iconText;
    iconLabel.textColor = color;
}
- (void)addButtonClick:(UIButton*)sender // 加入购物车
{
    self.buttontag = ADDBUYCAR;//按钮标记
    if ([Common isLogin]) {
        [_trueBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        if (goodsModel.goodsDetailDTO.propertyList.count == 0 && self.isCount) {
            NSDictionary *paramdic = [self paramdic];
            NSString *strjson = [Common dictionaryToJson:paramdic];
            [BKService addProduciontoShoppingCar:strjson view:self.view callback:^(id obj,NSError* error) {
                Result *add_result = obj;
                if (add_result != nil) {
                    [ShowMessage showMessage:add_result.msg withCenter:self.view.center];
                }
            }];

        }else{
            if (self.isx && self.isCount) {
                if ([self isAllSelect]) {
                    NSDictionary *paramdic = [self paramdic];
                    NSString *strjson = [Common dictionaryToJson:paramdic];
                    [BKService addProduciontoShoppingCar:strjson view:self.view callback:^(id obj,NSError* error) {
                        Result *add_result = obj;
                        if (add_result != nil) {
                            [ShowMessage showMessage:add_result.msg withCenter:self.view.center];
                        }
                    }];
                }
                else{
                    [self popViewWithDetail];
                }
            }else{
                [self popViewWithDetail];
                [ShowMessage showMessage:@"请选择属性" withCenter:self.view.center];
            }
        }
    }else{
        LoginController *loginVC = [[LoginController alloc]init];
        BKNavigationController *nv = [[BKNavigationController  alloc] initWithRootViewController:loginVC];
        [self presentViewController:nv animated:YES completion:nil];
    }
}
-(NSDictionary*)paramdic{
    NSArray *keys = [self.result_dic allKeys];
    self.orderInfo_dic = [NSMutableDictionary dictionary];
    NSInteger num;
    if (goodsModel.goodsDetailDTO.propertyList.count == 0) {
        for (int i = 0; i < 5; i++) {
            [self.orderInfo_dic setObject:@"" forKey:[NSString stringWithFormat:@"%@%d",@"goods_pro_rel",i+1]];
        }
        [self.orderInfo_dic setObject:_listDetialBuyFooterView.dataLabel.text forKey:@"goods_amount"];
        [self.orderInfo_dic setObject:goodsModel.goodsDTO.id forKey:@"goods_id"];

    }else{
        if (keys.count != 0) {
            if (keys.count < 5) {
                num = 5;
            }else{
                num = [keys count];
            }
            for (int i = 0; i < num; i++) {
                if (keys.count >= i+1) {
                    NSString *key = [keys objectAtIndex:i];
                    PropertyReList *pr = [self.result_dic objectForKey:key];
                    [self.orderInfo_dic setObject:pr.id forKey:[NSString stringWithFormat:@"%@%d",@"goods_pro_rel",i+1]];
                }else{
                    [self.orderInfo_dic setObject:@"" forKey:[NSString stringWithFormat:@"%@%d",@"goods_pro_rel",i+1]];
                }
            }
            [self.orderInfo_dic setObject:_listDetialBuyFooterView.dataLabel.text forKey:@"goods_amount"];
            [self.orderInfo_dic setObject:goodsModel.goodsDTO.id forKey:@"goods_id"];
        }

    }
    return self.orderInfo_dic;
}
- (void)buyButtonClick:(UIButton*)sender // 立即购买
{
    if ([Common isLogin]) {
            [_trueBtn setTitle:@"预购" forState:UIControlStateNormal];
        if (goodsModel.goodsDetailDTO.propertyList.count == 0 && self.isCount) {
            self.buttontag = ATONCEBUY;
            [self comfireOrder];
        }else{
            if (self.isx && self.isCount) {
                if ([self isAllSelect]) {
                    switch ([self.readyBuy integerValue]) {
                        case 0:
                        case 3:
                            self.buttontag = ATONCEBUY;
                            _listDetailFooterView.buyButton.userInteractionEnabled = NO;
                            _listDetailFooterView.buyButton.backgroundColor = [UIColor grayColor];
                            break;
                        case 1:
                        case 2:
                            self.buttontag = ATONCEBUY;
                            _listDetailFooterView.buyButton.userInteractionEnabled = YES;
                            _listDetailFooterView.buyButton.backgroundColor = COLOR_13;
                            [_trueBtn setTitle:@"预购" forState:UIControlStateNormal];
                            [self comfireOrder];
                            break;
                            
                        default:
                            break;
                    }
                   
                }
            }else{
                [self popViewWithDetail];
                [ShowMessage showMessage:@"请选择属性" withCenter:self.view.center];
            }
        }
    }else {
        LoginController *loginVC = [[LoginController alloc]init];
        BKNavigationController *nv = [[BKNavigationController  alloc] initWithRootViewController:loginVC];
        [self presentViewController:nv animated:YES completion:nil];
    }
}
- (void)addBtnClick:(UIButton*)sender  //  加号
{
    if ([self.saveCount integerValue] > [_listDetialBuyFooterView.dataLabel.text integerValue]) {
        [_listDetialBuyFooterView.dataLabel setText:[NSString stringWithFormat:@"%d",[_listDetialBuyFooterView.dataLabel.text intValue] + 1]];
    }
}
- (void)reduceBtnClick:(UIButton*)sender  //减号
{
    if ([_listDetialBuyFooterView.dataLabel.text floatValue] > 1) {
        [_listDetialBuyFooterView.dataLabel setText:[NSString stringWithFormat:@"%d",[_listDetialBuyFooterView.dataLabel.text intValue] - 1]];
    }else{
        [ShowMessage showMessage:@"购买数量不能少于一件" withCenter:self.view.center];
       }
}


- (void)popViewWithDetail  //弹出详情视图
{
//    [_popTableView reloadData];
    [self removeTimer];
    self.isCount = YES;
    _popView.hidden = NO;
    [UIView animateWithDuration:0.5
                         animations:^{
                             CGRect rect =  CGRectMake( 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                             _popView.frame = rect;
                         }
                         completion:^(BOOL finished) {
                             
                         }];
 
}
- (void)cancelBtnClick:(UIButton*)sender
{
    [self hiddenPopView];
}
-(void)hiddenPopView{
    [self addTimer];
    self.navigationController.navigationBar.hidden = NO;
    [UIView animateWithDuration:0.4
                     animations:^{
                         CGRect rect =  CGRectMake( 0, SCREEN_WIDTH - 0.1, SCREEN_HEIGHT, 0.1);
                         _popView.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         _popView.hidden = YES;
                     }];
}
-(void)gotoShop
{
    if ([Common isLogin]) {
        BuyCarViewController *bvc =[[BuyCarViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:bvc animated:YES];
        
    }else{
        LoginController *loginVC = [[LoginController alloc]init];
        BKNavigationController *nv = [[BKNavigationController  alloc] initWithRootViewController:loginVC];
        [self presentViewController:nv animated:YES completion:nil];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (float)createdBtnSelectViewWithTitle:(NSString*)titleSource andBtn:(NSMutableArray*)btnSource
{
    data_array= btnSource;
    
    UILabel* titleLabel = [UILabel new];
    titleLabel.text = titleSource;
    titleLabel.backgroundColor = [UIColor whiteColor];
    [titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    titleLabel.frame = CGRectMake(10, 0, SCREEN_WIDTH - 20, 40);
    titleLabel.numberOfLines = 0;
    
    CGFloat cruuentY = 40;
    CGFloat cruuentX = 10;
    CGFloat forwardHeight = 0;
    
    for (int i = 0; i<btnSource.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        PropertyReList *pr = [btnSource objectAtIndex:i];
        CGSize btnSize = [listDetailBuyDetail boundingRectWithSize:pr.propertyValue  Font:[UIFont systemFontOfSize:14.0] Size:CGSizeMake(SCREEN_WIDTH - 40, 40)];
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:pr.propertyValue forState:UIControlStateNormal];
        
        
        if (cruuentX + btnSize.width >SCREEN_WIDTH - 10) {
            cruuentX = 10;
            cruuentY = cruuentY + forwardHeight + 10;
        }
        button.frame = CGRectMake(cruuentX, cruuentY, btnSize.width, btnSize.height);
        forwardHeight = btnSize.height;
        cruuentX = cruuentX + btnSize.width + 10;
    }
    return cruuentY+ forwardHeight + 10;
}
- (float)createDetailLabel:(NSMutableArray*)labelText{
    if (labelText.count != 0) {
        UILabel *_titleLabel;
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        _titleLabel.text = @"商品参数";
        _titleLabel.frame = CGRectMake(10, 5, 100, 45);
        UILabel *_line;
        _line = [UILabel new];
        _line.frame = CGRectMake(10, 50, SCREEN_WIDTH - 10, 0.5);
        
        for (int i = 0; i < labelText.count; i ++) {
            UILabel* label = [UILabel new];
            label.textColor = [UIColor grayColor];
            label.text = [NSString stringWithFormat:@"%@",labelText[i]];
            label.font = [UIFont systemFontOfSize:14.0];
            label.frame = CGRectMake(10, 50 + i * 25, SCREEN_WIDTH - 20, 30);
        }
        //self.frame = CGRectMake(0, 0, SCREEN_WIDTH, labelText.count * 25 + 50);
    }
    return labelText.count * 25 + 50;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self hiddenPopView];
}

@end
