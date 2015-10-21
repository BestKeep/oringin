//
//  ImageCell.h
//  
//
//  Created by UTOUU on 15/10/13.
//
//

#import <UIKit/UIKit.h>

@interface ImageCell : UITableViewCell  //详情页底部显示的图片

//- (void)createDetailViewImage:(NSMutableArray*)imageData;
@property(nonatomic , strong)UIImageView* detailImage;

@end
