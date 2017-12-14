//
//  MainViewController.m
//  Meishii
//
//  Created by Develop Mx on 21/08/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "QrViewController.h"
#import "ProfileViewController.h"
#import "DeckViewController.h"
#import "NotificationViewController.h"
#import "EditProfileViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    self.delegate = self;
    self.navigationItem.title = @"MEISSHI";
    
    
    UIFont* fontMeisshi = [UIFont fontWithName:@"Meisshi" size:30.0f];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName: fontMeisshi
                                                                      }];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];

    [self setSelectedIndex:2];
    [self setOldSelectedIndex:2];

    UIImage* backgroundImage = [UIImage imageNamed:@"backpattern.jpg"];
    UIColor* backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    [self.view setBackgroundColor:backgroundColor];

    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(appDidBecomeActive:)
                                                 name: UIApplicationDidBecomeActiveNotification
                                               object: nil];
    
    [[UITabBar appearance] setUnselectedItemTintColor:[UIColor whiteColor]];
    
    [[AppDelegate sharedInstance] requestForAuthorizationNotification];
}

- (void)appDidBecomeActive:(NSNotification *)notification {
    NSLog(@"did become active notification");
    [self openSharedUser];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    User* user = [AppDelegate sharedInstance].user;
    if (user.card == nil) {
        self.tabBar.items[0].enabled = NO;
        self.tabBar.items[1].enabled = NO;
        self.tabBar.items[3].enabled = NO;
        self.tabBar.items[4].enabled = NO;
        [self showEditProfile];
    } else {
        self.tabBar.items[0].enabled = YES;
        self.tabBar.items[1].enabled = YES;
        self.tabBar.items[3].enabled = YES;
        self.tabBar.items[4].enabled = YES;
    }
    [self openSharedUser];
}


-(void) openSharedUser {
    NSString* userId = [AppDelegate sharedInstance].openUserId;
    if (userId != nil) {

        [AppDelegate sharedInstance].openUserId = nil;
        
        User* user = [[User alloc] init];
        user.identifier = userId;
    
        UIStoryboard* storyBoard          = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ProfileViewController *controller = (ProfileViewController*) [storyBoard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    
        [controller setUser:user];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
        switch ([self selectedIndex]) {
            case 2:
                break;
            case 4:
                if ([self oldSelectedIndex] != [self selectedIndex]) {
                    ((ProfileViewController *) viewController).isOwnProfile = YES;
                    ((ProfileViewController *) viewController).user = [AppDelegate sharedInstance].user;
                }
                break;
        }
        NSLog(@"Cambiando aasda fadsdas");
        self.oldSelectedIndex = [self selectedIndex];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onBtnLogoutClick:(id)sender {
    /*    */
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:@"Options" preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [actionSheet dismissViewControllerAnimated:YES completion:nil];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Logout" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [actionSheet dismissViewControllerAnimated:YES completion:^{

        }];
        [self logout];
    }]];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

-(void) logout {
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"SESSION_TOKEN"];
    [userDefaults synchronize];
    
    [[AppDelegate sharedInstance].api setSessionToken:nil];
    
    UIStoryboard* mainStoryBoard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController* vController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"SplashViewController"];
    
    [self presentViewController:vController
                       animated:YES
                     completion:^{
                         [[[UIApplication sharedApplication] keyWindow] setRootViewController:vController];
    }];

}
- (IBAction)onBtnNotificationsClick:(id)sender {
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController* nvc = [storyBoard instantiateViewControllerWithIdentifier:@"NotificationController"];
    
    //NotificationViewController* vc = (NotificationViewController *) nvc.viewControllers[0];

    [self showViewController:nvc sender:nil];
}

- (void) showEditProfile
{
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController* vc     = [storyBoard instantiateViewControllerWithIdentifier:@"EditController"];
    //EditProfileViewController* eVC = (EditProfileViewController*) [vc viewControllers][0];
    
    // [eVC setProfileViewController:nil];
    [self showViewController:vc sender:nil];
    //[self.navigationController presentViewController:vc animated:YES completion:nil];
}

@end
