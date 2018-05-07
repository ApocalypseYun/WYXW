//
//  MyCellTableViewCell.h
//  WYXW
//
//  Created by 刘冠中 on 2018/4/21.
//  Copyright © 2018年 刘冠中. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyCount;
@property (weak, nonatomic) IBOutlet UIImageView *lImageView;

@property (copy,nonatomic) UIImage *image;
@property (copy,nonatomic) NSString *lTitle;
@property (copy,nonatomic) NSString *source;
@property (copy,nonatomic) NSString *reply;

@end
