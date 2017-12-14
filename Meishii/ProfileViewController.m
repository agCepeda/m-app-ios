//
//  ProfileViewController.m
//  Meishii
//
//  Created by Develop Mx on 19/08/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import "ProfileViewController.h"
#import "EditProfileViewController.h"
#import "AppDelegate.h"
#import "AFURLSessionManager.h"
#import <MessageUI/MessageUI.h>
#import <HCSStarRatingView/HCSStarRatingView.h>

#import "FollowersViewController.h"
#import "ReviewListCell.h"
#import "ReviewFormViewController.h"

@interface ProfileViewController () {
    BOOL reviewsLoaded;
    NSMutableArray* listReviews;
}
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 600;
    
    reviewsLoaded = NO;
    
    UIImage* backgroundImage = [UIImage imageNamed:@"backpattern.jpg"];
    UIColor* backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    [self.view setBackgroundColor:backgroundColor];

    /*
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ProfileInfoCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ProfileInfoCell class])];
    */
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentSizeChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];
    
    [self update];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void) contentSizeChanged: (NSNotification *) notification {
    [self.tableView reloadData];
}

-(void) didTapTelephone1: (UITapGestureRecognizer *)tapGesture {
}

-(void) didTapAddress: (UITapGestureRecognizer *)tapGesture {
    NSString* address   = [_user.address stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString* urlAction = [NSString stringWithFormat:@"http://maps.apple.com/?q=%@", address];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlAction] options:@{} completionHandler:nil];
}

-(void) didTapWebsite: (UITapGestureRecognizer *)tapGesture {
    NSString* urlAction = _user.website;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlAction] options:@{} completionHandler:nil];
}

-(void) didTapFollowers: (UITapGestureRecognizer *)tapGesture {
    NSLog(@"Did tap followers");
}

-(void) didTapFollowed: (UITapGestureRecognizer *)tapGesture {
    NSLog(@"Did tap followed");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSString * segueName = segue.identifier;
    if ([segueName isEqualToString: @"profile_info"]) {
//        _infoViewController = (InfoViewController *) [segue destinationViewController];
    }
    if ([segueName isEqualToString: @"profile_review"]) {
//        _reviewViewController = (ReviewViewController*) [segue destinationViewController];
    }
    
    
    if ([segueName isEqualToString:@"ShowEditProfileViewController"]) {
        NSArray *viewControllers = ((UINavigationController*) segue.destinationViewController).viewControllers;
        EditProfileViewController *editVC = [viewControllers objectAtIndex:0];
        
        [editVC setProfileViewController:self];
    }
    
}

- (IBAction)showComponent:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        
        [UIView animateWithDuration:0.5 animations:^{
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
        }];
    }
}

-(void) addContact {
    // _btnEdit.enabled = NO;
    [[AppDelegate sharedInstance].api addContact: _user.identifier
                                        callback: ^(id responseObject, NSError *error) {
                                            if (!error) {
                                                _user.isContact = YES;
                                                [self update];
                                            } else {
                                                NSLog(@"%@", error);
                                            }
                                            // _btnEdit.enabled = YES;
    }];
}

-(void) removeContact {
    // _btnEdit.enabled = NO;
    [[AppDelegate sharedInstance].api removeContact: _user.identifier
                                           callback: ^(id responseObject, NSError *error) {
                                               if (!error) {
                                                   _user.isContact = NO;
                                                   [self update];
                                               } else {
                                                   NSLog(@"%@", error);
                                               }
                                               // _btnEdit.enabled = YES;
                                        }];
}

-(void) update {
    reviewsLoaded = NO;
    [self loadProfile];
}

- (void) loadProfile {
    [[AppDelegate sharedInstance].api getUser: _user.identifier
                                 loadMyReview: YES
                                     callback: ^(id responseObject, NSError *error) {
                                         if (!error) {
                                             _user = [[User alloc] initWithDictionary:responseObject];
                                             [self updateView];
                                             
                                             [self loadReviews];
                                         } else {
                                             NSLog(@"%@", error);
                                         }
                                     }];
}

- (void) loadReviews {
    listReviews = [[NSMutableArray alloc] init];
    
    [[AppDelegate sharedInstance].api getReviewsById: _user.identifier
                                            callback: ^(NSDictionary *responseObject, NSError *error) {
                                                if (! error) {
                                                    NSArray* reviews = [responseObject objectForKey:@"data"];
                                                    
                                                    for (NSDictionary* dicReview in reviews) {
                                                        Review* review = [[Review alloc] initWithDictionary:dicReview];
                                                        [listReviews addObject:review];
                                                    }
                                                    
                                                    NSLog(@"%@", listReviews);
                                                    
                                                    reviewsLoaded = YES;
                                                    
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        [self.tableView reloadData];
                                                    });
                                                } else {
                                                    NSLog(@"%@", error);
                                                }
                                            }];
}

-(void) updateView {
    [self.tableView reloadData];
}



-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [_mailComposeController dismissViewControllerAnimated:YES completion:NULL];
}


-(void)makeTelephoneCall:(NSString *) phone {
    
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@", phone]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl  options:@{} completionHandler:nil];
    } else {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Llamadas no disponibles" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"Aceptar"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                   }];
        [alert addAction:okButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

- (void) didTapReviewForm: (UIButton *) sender {
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UINavigationController* nvc = [storyBoard instantiateViewControllerWithIdentifier:@"ReviewController"];
    
    ReviewFormViewController* reviewFormVC = (ReviewFormViewController *) nvc.viewControllers[0];
    
    reviewFormVC.user = _user;
    
    ///[self.navigationController pushViewController:reviewFormVC animated:YES];
    [self showViewController:nvc sender:nil];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _isOwnProfile ? (reviewsLoaded ? 2 : 1) : (reviewsLoaded ? 3 : 2);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return 1;
    
    if (_isOwnProfile)
        return listReviews.count;
    else
        if (section == 1)
            return 1;
        else
            return listReviews.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *profileInfoCellIdentifier = @"ProfileInfoCell";
    static NSString *reviewCellIdentifier = @"ReviewCell";
    static NSString *reviewFormCellIdentifier = @"ReviewFormCell";

    if (indexPath.section == 0) {
        ProfileInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:profileInfoCellIdentifier];
        if (cell == nil) {
            cell = [[ProfileInfoCell alloc] initWithStyle: UITableViewCellStyleDefault
                                              reuseIdentifier: profileInfoCellIdentifier];
        }
        
        [cell loadUser:_user];
        if (_isOwnProfile) {
            [cell setTitleAction:@"Edit"];
        } else {
            if (_user.isContact) {
                [cell setTitleAction:@"Remove"];
            } else {
                [cell setTitleAction:@"Add"];
            }
        }
        
        [cell setDelegate:self];
        
        return cell;
    }
    
    if (_isOwnProfile) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reviewCellIdentifier];
        
        if (! cell) {
            cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                          reuseIdentifier: reviewCellIdentifier];
        }
        
        UILabel* lblReviewer    = (UILabel *) [cell viewWithTag:10];
        UILabel* lblComment     = (UILabel *) [cell viewWithTag:20];
        HCSStarRatingView* srScore = [cell viewWithTag:30];
        
        Review* review = [listReviews objectAtIndex:indexPath.row];
        
        [lblReviewer setText:review.reviewerName];
        [lblComment setText:review.comment];
        [srScore setValue:review.score];
        
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        
        return cell;
    } else {
        if (indexPath.section == 1) {
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: reviewFormCellIdentifier];
            
            if (! cell) {
                cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                              reuseIdentifier: reviewFormCellIdentifier];
            }
            
            UIButton* btnAction = (UIButton *) [cell viewWithTag:10];
            
            [btnAction removeTarget:nil
                               action:NULL
                     forControlEvents:UIControlEventAllEvents];
            [btnAction addTarget:self action:@selector(didTapReviewForm:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        } else {
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reviewCellIdentifier];
            
            if (! cell) {
                cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                              reuseIdentifier: reviewCellIdentifier];
            }
            
            UILabel* lblReviewer    = (UILabel *) [cell viewWithTag:10];
            UILabel* lblComment     = (UILabel *) [cell viewWithTag:20];
            HCSStarRatingView* srScore = [cell viewWithTag:30];
            
            Review* review = [listReviews objectAtIndex:indexPath.row];
            
            [lblReviewer setText:review.reviewerName];
            [lblComment setText:review.comment];
            [srScore setValue:review.score];
            
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
            
            return cell;
        }
    }
    
    return nil;
}
/*
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (reviewsLoaded) {
        if (_isOwnProfile) {
        } else {
        }
        return @"";
    }
    return nil;
}
 */

/*
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return UITableViewAutomaticDimension;
}
*/

#pragma mark - ProfileInfoDelegate


- (void)didClickTelephone {
    [self makeTelephoneCall:_user.telephone1];
}

- (void)didClickEmail {
    if ([MFMailComposeViewController canSendMail])
    {
        _mailComposeController = [[MFMailComposeViewController alloc] init];
        [_mailComposeController setSubject:@"Sample Subject"];
        [_mailComposeController setMessageBody:@"Here is some main text in the email!" isHTML:NO];
        [_mailComposeController setToRecipients:@[_user.workEmail]];
        [_mailComposeController setMailComposeDelegate:self];
        
        [self presentViewController:_mailComposeController animated:YES completion:nil];
    }
    else
    {
        NSLog(@"This device cannot send email");
    }
}

- (void)didClickAddress {
    NSString* address   = [_user.address stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString* urlAction = [NSString stringWithFormat:@"http://maps.apple.com/?q=%@", address];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:urlAction]
                                       options: @{}
                             completionHandler: nil];
}

- (void)didClickWebsite {
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:_user.website]
                                       options: @{}
                             completionHandler: nil];
}

- (void)didClickFacebook {
    NSString* urlAction = nil;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://profile"]])
        urlAction = [NSString stringWithFormat:@"fb://profile?id=%@", _user.facebook];
    else
        urlAction = [NSString stringWithFormat:@"https://www.facebook.com/%@", _user.facebook];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlAction] options:@{} completionHandler:nil];
}

- (void)didClickTwitter {
    NSString* urlAction = nil;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]])
        urlAction = [NSString stringWithFormat:@"twitter://user?screen_name=%@", _user.twitter];
    else
        urlAction = [NSString stringWithFormat:@"https://www.twitter.com/%@", _user.twitter];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlAction] options:@{} completionHandler:nil];
}

- (void)didClickInstagram {
    NSString* urlAction = nil;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"instagram://"]])
        urlAction = [NSString stringWithFormat:@"instagram://user?username=%@", _user.instagram];
    else
        urlAction = [NSString stringWithFormat:@"https://www.instagram.com/%@", _user.instagram];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:urlAction]
                                       options: @{}
                             completionHandler: nil];
}

- (void) didClickAction {
    if (_isOwnProfile) {
        UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController* vc     = [storyBoard instantiateViewControllerWithIdentifier:@"EditController"];
        EditProfileViewController* eVC = (EditProfileViewController*) [vc viewControllers][0];
        
        [eVC setProfileViewController:self];
        
        [self showViewController:vc sender:nil];
    }else if (_user.isContact)
        [self removeContact];
    else
        [self addContact];
}
-(void)didClickFollowers {
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController* nvc = (UINavigationController *)[storyBoard instantiateViewControllerWithIdentifier:@"SocialController"];
    FollowersViewController* vc = nvc.viewControllers[0];
    vc.user = _user;
    vc.type = TYPE_FOLLOWER;
    [self showViewController:nvc sender:nil];
}

-(void)didClickFollowed {
    
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController* nvc = (UINavigationController *)[storyBoard instantiateViewControllerWithIdentifier:@"SocialController"];
    FollowersViewController* vc = nvc.viewControllers[0];
    vc.user = _user;
    vc.type = TYPE_FOLLOWING;
    [self showViewController:nvc sender:nil];
}

- (IBAction)onBtnBackClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
