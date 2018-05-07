//
//  MyCellTableViewCell.m
//  WYXW
//
//  Created by 刘冠中 on 2018/4/21.
//  Copyright © 2018年 刘冠中. All rights reserved.
//

#import "MyCellTableViewCell.h"

@implementation MyCellTableViewCell

@synthesize image;
@synthesize lTitle;
@synthesize source;
@synthesize reply;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImage:(UIImage *)img{
    if (![img isEqual:image]) {
        image = [img copy];
        self.lImageView.image = image;
    }
}

- (void)setLTitle:(NSString *)ltitle{
    if (![ltitle isEqualToString:lTitle]) {
        lTitle = [ltitle copy];
        self.lTitleLabel.text = lTitle;
    }
}

-(void)setSource:(NSString *)Source{
    if (![Source isEqualToString:source]) {
        source = [Source copy];
        self.sourceLabel.text = source;
    }
}

-(void)setReply:(NSString *)Reply{
    if (![Reply isEqualToString:reply]) {
        reply = [Reply copy];
        self.replyCount.text = reply;
    }
}

@end
