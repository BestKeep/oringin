//
//  TextCell.m
//  
//
//  Created by UTOUU on 15/10/13.
//
//

#import "TextCell.h"
#import "Masonry.h"

@implementation TextCell

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
        
        _detailView = [UITextView new];
        _detailView.backgroundColor = [UIColor whiteColor];
        _detailView.textColor = [UIColor grayColor];
        _detailView.userInteractionEnabled = NO;
        [self.contentView addSubview:_detailView];
        
        [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(self.mas_top).offset(0);
            make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        }];

    }
    return self;
}
//- (void)createDetailTextView:(NSMutableArray*)textView
//{
//    
//}
@end
