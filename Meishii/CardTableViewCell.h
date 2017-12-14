//
//  CardTableViewCell.h
//  Meishii
//
//  Created by Develop Mx on 19/08/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "User.h"

@interface CardTableViewCell : UITableViewCell<MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnFlip;
@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UIView *qrView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
- (IBAction)flip:(id)sender;
@property (nonatomic, assign) BOOL showingCard;

@property (weak, nonatomic) IBOutlet UILabel *lblShowName;
@property (weak, nonatomic) IBOutlet UILabel *lblTelephone1;
@property (weak, nonatomic) IBOutlet UILabel *lblTelephone2;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblFacebook;
@property (weak, nonatomic) IBOutlet UILabel *lblTwitter;
@property (weak, nonatomic) IBOutlet UILabel *lblWebsite;
@property (weak, nonatomic) IBOutlet UILabel *lblWorkEmail;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@property (nonatomic, strong) User* user;

@property (nonatomic, strong) MFMailComposeViewController* mailComposeController;

@end
