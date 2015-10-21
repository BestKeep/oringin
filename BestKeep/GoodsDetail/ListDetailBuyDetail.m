//
//  ListDetailBuyDetail.m
//  
//
//  Created by UTOUU on 15/9/22.
//
//

#import "ListDetailBuyDetail.h"
#define RgbColor(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]


@implementation ListDetailBuyDetail   //按钮不固定的视图

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
        self.backgroundColor = [UIColor whiteColor];

        self.frame = CGRectMake(0, 0, SCREEN_WIDTH,0.1);
        self.backgroundColor = [UIColor whiteColor];
        
        _btnArray = [NSMutableArray new];
        
            }
    return self;
}

- (void)createdBtnSelectViewWithTitle:(NSString*)titleSource andBtn:(NSMutableArray*)btnSource
{
    data_array= btnSource;
    
    UILabel* titleLabel = [UILabel new];
    titleLabel.text = titleSource;
    titleLabel.backgroundColor = [UIColor whiteColor];
    [titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    titleLabel.frame = CGRectMake(10, 0, SCREEN_WIDTH - 20, 40);
    titleLabel.numberOfLines = 0;
    [self addSubview:titleLabel];
    
    CGFloat cruuentY = 40;
    CGFloat cruuentX = 10;
    CGFloat forwardHeight = 0;
    
    for (int i = 0; i<btnSource.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        PropertyReList *pr = [btnSource objectAtIndex:i];
        CGSize btnSize = [self boundingRectWithSize:pr.propertyValue  Font:[UIFont systemFontOfSize:14.0] Size:CGSizeMake(SCREEN_WIDTH - 40, 40)];
        
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.layer.borderWidth = 0.5;
        button.layer.borderColor = COLOR_05.CGColor;
        button.layer.cornerRadius = 5.0;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.selected = NO;
        button.layer.masksToBounds = YES;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitle:pr.propertyValue forState:UIControlStateNormal];
        //        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.numberOfLines = 0;
        button.titleLabel.textAlignment = NSTextAlignmentLeft;
        [button setTitleColor:COLOR_05 forState:UIControlStateNormal];
        
        if (cruuentX + btnSize.width >SCREEN_WIDTH - 10) {
            cruuentX = 10;
            cruuentY = cruuentY + forwardHeight + 10;
        }
        button.frame = CGRectMake(cruuentX, cruuentY, btnSize.width, btnSize.height);
        forwardHeight = btnSize.height;
        cruuentX = cruuentX + btnSize.width + 10;
        [self addSubview:button];
        [_btnArray addObject:button];
    }
    self.frame = CGRectMake(0, 100, SCREEN_WIDTH, cruuentY+ forwardHeight + 10);
    
    
}
- (CGSize)labelAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize

{
    //要计算的字符串，lalbel的字体大小，label允许的最大尺寸。
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    
    NSDictionary* attributes =@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
    labelSize.height=ceil(labelSize.height);
    
    labelSize.width=ceil(labelSize.width);
    
    labelSize.height += 10;
    
    return labelSize;
    
}

- (CGSize) boundingRectWithSize:(NSString*)string Font:(UIFont*) font Size:(CGSize) size
{
    CGSize _size;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine |
    
    NSStringDrawingUsesLineFragmentOrigin |
    
    NSStringDrawingUsesFontLeading;
    
    _size = [string boundingRectWithSize:size options: options attributes:attribute context:nil].size;
    
#else
    
    _size = [string sizeWithFont:font constrainedToSize:size];
    
#endif
    
    _size.height += 10;
    _size.width += 10;
    return _size;
    
}
- (void)btnClick:(UIButton*)sender
{
   sender.selected = !sender.selected;
    for (UIButton* button in _btnArray) {
        if ([sender isEqual:button]) {
            button.backgroundColor = COLOR_14;
        }
        else{
            button.backgroundColor = [UIColor whiteColor];
            button.selected = NO;
        }
    }
    if ([self.delegate respondsToSelector:@selector(selectGoodsProperty:)]) {
        for (PropertyReList *pr in data_array) {
            if ([pr.propertyValue isEqualToString:sender.titleLabel.text]) {
                self.propRlist = pr;
            }
        }
        [self.delegate selectGoodsProperty:self.propRlist];
    }
}
@end
