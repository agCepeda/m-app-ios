//
//  FollowerCell.m
//  Meishii
//
//  Created by Develop Mx on 07/03/17.
//  Copyright © 2017 Develop Mx. All rights reserved.
//

#import "FollowerCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation FollowerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) loadFollower:(User *)user {
    UIImageView* imgViewLogo   = [self viewWithTag:100];
    UILabel* lblShowName   = [self viewWithTag:10];
    UILabel* lblProfession = [self viewWithTag:20];
    
    [imgViewLogo sd_setImageWithURL:user.profilePicture];
    [lblShowName setText:user.showName];
    [lblProfession setText:user.profession];
}

@end
