//
//  MainViewController.h
//  Meishii
//
//  Created by Develop Mx on 21/08/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UITabBarController<UITabBarControllerDelegate>

@property (nonatomic, assign) NSInteger oldSelectedIndex;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnLogout;
- (IBAction)onBtnLogoutClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnNotifications;
- (IBAction)onBtnNotificationsClick:(id)sender;

@end
