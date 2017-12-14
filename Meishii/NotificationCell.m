//
//  NotificationCell.m
//  Meishii
//
//  Created by Develop Mx on 12/03/17.
//  Copyright © 2017 Develop Mx. All rights reserved.
//

#import "NotificationCell.h"
#import "User.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation NotificationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) loadNotification: (Notification *) notification {
    UIImageView* imgLogo = (UIImageView *) [self viewWithTag:100];
    UILabel* lblText = (UILabel *) [self viewWithTag:10];
    UILabel* lblDate = (UILabel *) [self viewWithTag:20];
    
    User* user = notification.attachment;
    
    [imgLogo sd_setImageWithURL:user.logo];
    
    if ([notification.type isEqualToString:@"review"]) {
        lblText.text = [NSString stringWithFormat:@"%@ posted a review on your profile!", user.showName];
    } else {
        lblText.text = [NSString stringWithFormat:@"%@ started following you!", user.showName];
    }
    
    
    lblDate.text = notification.date;
    [lblDate sizeToFit];
    [lblText sizeToFit];
}

@end
