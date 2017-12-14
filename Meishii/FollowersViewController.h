//
//  FollowersViewController.h
//  Meishii
//
//  Created by Develop Mx on 07/03/17.
//  Copyright © 2017 Develop Mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

#define TYPE_FOLLOWER 2
#define TYPE_FOLLOWING 1

@interface FollowersViewController : UITableViewController

@property (nonatomic, weak) User* user;
@property (nonatomic, assign) int type;
- (IBAction)onBtnBackClick:(id)sender;

@end
