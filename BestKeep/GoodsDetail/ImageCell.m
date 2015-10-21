//
//  ImageCell.m
//  
//
//  Created by UTOUU on 15/10/13.
//
//

#import "ImageCell.h"

@implementation ImageCell

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
        
        _detailImage = [UIImageView new];
        _detailImage.backgroundColor = [UIColor whiteColor];
        _detailImage.contentMode = UIViewContentModeScaleAspectFit ;
        [self.contentView addSubview:_detailImage];
        
        [_detailImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(self.mas_top).offset(0);
            make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        }];

    }
    return self;
}
//- (void)createDetailViewImage:(NSMutableArray*)imageData
//{
//    
//}
@end
