//
//  ProfileInfoCell.h
//  Meishii
//
//  Created by Develop Mx on 28/09/17.
//  Copyright © 2017 Develop Mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeisshiCard.h"
#import "User.h"

@protocol ProfileInfoCellDelegate;

@interface ProfileInfoCell : UITableViewCell

@property (nonatomic, weak) id<ProfileInfoCellDelegate> delegate;

@property (weak, nonatomic) NSString* titleAction;

@property (weak, nonatomic) IBOutlet UIImageView *imvProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblProfession;

@property (weak, nonatomic) IBOutlet UILabel *lblFollowers;
@property (weak, nonatomic) IBOutlet UILabel *lblFollowed;

@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
@property (weak, nonatomic) IBOutlet UIButton *btnFacebook;
@property (weak, nonatomic) IBOutlet UIButton *btnTwitter;
@property (weak, nonatomic) IBOutlet UIButton *btnInstagram;

@property (weak, nonatomic) IBOutlet UIView *viewTelephone1;
@property (weak, nonatomic) IBOutlet UILabel *lblIconTelephone1;
@property (weak, nonatomic) IBOutlet UILabel *lblTelephone1;

@property (weak, nonatomic) IBOutlet UIView *viewEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblIconEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;

@property (weak, nonatomic) IBOutlet UIView *viewAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblIconAddress;

@property (weak, nonatomic) IBOutlet UIView *viewWebsite;
@property (weak, nonatomic) IBOutlet UILabel *lblIconWebsite;
@property (weak, nonatomic) IBOutlet UILabel *lblWebsite;

@property (weak, nonatomic) IBOutlet UILabel *lblStatus;

@property (weak, nonatomic) IBOutlet MeisshiCard *card;

- (IBAction)onBtnInstagramClick:(id)sender;
- (IBAction)onBtnTwitterClick:(id)sender;
- (IBAction)onBtnFacebookClick:(id)sender;

- (IBAction)onBtnEditClick:(id)sender;

- (void) loadUser: (User *) user;

@end

@protocol ProfileInfoCellDelegate <NSObject>
@optional
- (void)didClickTelephone;
- (void)didClickEmail;
- (void)didClickAddress;
- (void)didClickWebsite;

- (void)didClickFacebook;
- (void)didClickTwitter;
- (void)didClickInstagram;

- (void) didClickAction;

- (void) didClickFollowers;
- (void) didClickFollowed;

@end

