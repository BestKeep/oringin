//
//  BuyCarDetailCell.m
//  BESTKEEP
//
//  Created by UTOUU on 15/8/20.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "BuyCarDetailCell.h"
#import "Masonry.h"

#define RgbColor(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define KCELLHIEGITH  88

@interface BuyCarDetailCell ()<CellDataViewDelegate>

@property (nonatomic,strong) ShoppingCarList * buyCarModel;
@property (nonatomic,strong) UIView * imageBackView;



@end

@implementation BuyCarDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.backgroundColor = RgbColor(244, 244, 244);
        
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button1 setBackgroundColor:[UIColor whiteColor]];
        [_button1 setBackgroundImage:[UIImage imageNamed:@"select_image.png"] forState:UIControlStateSelected];
        [_button1 setBackgroundImage:[UIImage imageNamed:@"unselect_image.png"] forState:UIControlStateNormal];
        _button1.layer.cornerRadius = 10;
        _button1.layer.masksToBounds = YES;
        _button1.layer.borderWidth = 1;
        _button1.layer.borderColor = COLOR_11.CGColor;
        
        [_button1 addTarget:self action:@selector(selectedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_button1];
        
        _imageView1 = [[UIImageView alloc] initWithFrame:CGRectZero];
        //_imageView1.layer.borderWidth = 0.5;
        _imageView1.layer.borderColor = [UIColor grayColor].CGColor;
//        [self.contentView addSubview:_imageView1];
        
        _imageBackView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_imageBackView];
        [_imageBackView addSubview:_imageView1];
        
        
        _detailView = [[cellDetailView alloc] init];
        [self.contentView addSubview:_detailView];
        
        _addView = [[cellDataView alloc] init];
        [self.contentView addSubview:_addView];
        _addView.dataViewDelegate = self;
        _addView.hidden = YES;
        
        [_button1 setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_button1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.width.equalTo(@(20));
            make.height.equalTo(@(20));
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        [_imageBackView setTranslatesAutoresizingMaskIntoConstraints:NO];
        _imageBackView.backgroundColor = [UIColor whiteColor];
        _imageBackView.clipsToBounds = YES;
        [_imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_button1.mas_right).offset(11);
            make.height.mas_equalTo(@(92));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(@(92));
        }];
        
        [_imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_imageBackView.mas_centerX);
            make.centerY.equalTo(_imageBackView.mas_centerY);
            make.width.equalTo(@(92));
            make.height.equalTo(@(92));
        }];
        
        [_detailView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_imageView1.mas_right).offset(11);
            make.right.mas_equalTo(self.contentView.mas_right);
            make.top.mas_equalTo(self.contentView.mas_top).offset(8);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-6);
        }];
        
        [_addView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_addView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_imageView1.mas_right).offset(11);
            make.right.mas_equalTo(self.contentView.mas_right);
            make.top.mas_equalTo(self.contentView.mas_top).offset(8);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-6);
        }];
        
    }
    return self;
}

-(void)updateCellWithModel:(ShoppingCarList *)model{
    self.buyCarModel = model;
    if (model.isEdit) {
        self.addView.hidden = NO;
        self.detailView.hidden = YES;
        [self.addView updateDataWithShoppingCarList:model];
    }else{
        self.addView.hidden = YES;
        self.detailView.hidden = NO;
    }
    
    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:model.goods_img] placeholderImage:[UIImage imageNamed:@"default_head"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        CGFloat ratio = image.size.height/image.size.width;
        if (ratio>1) {
        [_imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(92*ratio));
            make.width.equalTo(@(92));
        }];
        }else{
        [_imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(92/ratio));
            make.height.equalTo(@(92));
        }];
        }
    }];
    
    
}

-(void)selectedButtonClick:(UIButton *)button{
    button.selected = !button.selected;
    self.buyCarModel.isCellBtnSelect = button.selected;
    
    if ([self.cellBtnDetegate respondsToSelector:@selector(updataCellButtonModel:tableViewCell:)]) {
        [self.cellBtnDetegate updataCellButtonModel:self.buyCarModel tableViewCell:self];
    }
    
}

-(void)cellDataView:(cellDataView *)dataView addCount:(UIButton *)addButton{
    [self addOrSubCountWithAdd:YES];
}
-(void)cellDataView:(cellDataView *)dataView subCount:(UIButton *)subButton{
    [self addOrSubCountWithAdd:NO];
}
-(void)cellDataView:(cellDataView *)dataView deletButtonClick:(UIButton *)deleteButton{

}


-(void)addOrSubCountWithAdd:(BOOL)isAdd{
    if (isAdd) {
        [self setModelAmountWithIntger:[self getCount] + 1];
    }else{
        if ([self getCount ] == 1) {
            [Common showAlertViewWith:@"" message:@"物品不能为空"];
        }else{
            [self setModelAmountWithIntger:[self getCount] - 1];
        }
        
    }
    [self.addView updateDataWithShoppingCarList:self.buyCarModel];
}
-(void)setModelAmountWithIntger:(NSInteger)count{
    NSString * countStr = [NSString stringWithFormat:@"%ld",(long)count];
    self.buyCarModel.amount = countStr;
}
-(NSInteger)getCount{
    return [self.buyCarModel.amount integerValue];
}

-(void)dealloc{
   
}

@end
