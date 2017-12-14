//
//  ProfileViewController.h
//  Meishii
//
//  Created by Develop Mx on 19/08/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#import "User.h"
#import "ReviewViewController.h"
#import "ProfileInfoCell.h"

@interface ProfileViewController : UITableViewController<MFMailComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, ProfileInfoCellDelegate>

@property (strong, nonatomic) User* user;

@property (nonatomic, assign) BOOL showingCard;
@property (nonatomic, assign) BOOL isOwnProfile;
- (IBAction)onBtnBackClick:(id)sender;

@property (nonatomic, strong) MFMailComposeViewController* mailComposeController;

-(void) update;

@end
