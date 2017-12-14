//
//  SearchViewController.m
//  Meishii
//
//  Created by Develop Mx on 19/08/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import "SearchViewController.h"
#import "CardTableViewCell.h"
#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "User.h"
#import "AFURLSessionManager.h"
#import "MeisshiCard.h"
#import "MeisshiListItem.h"

@interface SearchViewController () {
    UIRefreshControl* refreshControl;
    NSInteger* page;
    NSInteger* size;
    NSString* query;
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    refreshControl = [[UIRefreshControl alloc] init];
    
    //if (@available(iOS 10.0, *)) {
    //    [_tableCards setRefreshControl: refreshControl];
    //} else {
    //    [_tableCards addSubview:refreshControl];
    //}
    
    ///[refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    
    [self registerForKeyboardNotifications];
    [self loadContacts];
}

-(void) loadData {
    
    
    [[AppDelegate sharedInstance].api search: query
                                        size: (page ++)
                                        page: size
                                    callback:^(id responseObject, NSError *error) {
                                        if (!error) {
                                            listContacts = [[NSMutableArray alloc] init];
                                            
                                            for (NSDictionary* dicUser in [responseObject objectForKey:@"data"]) {
                                                [listContacts addObject:[[User alloc] initWithDictionary: dicUser]];
                                            }
                                            
                                            NSLog(@"%@", responseObject);
                                            
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                [self.tableCards reloadData];
                                            });
                                        } else {
                                            NSLog(@"%@", error);
                                        }
                                        [self.viewPlaceHolder setHidden:YES];
                                        [refreshControl endRefreshing];
                                        //[indicator stopAnimating];
                                    }];
    //[indicator startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) loadContacts {
    
    [self.viewPlaceHolder setHidden:NO];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    indicator.center = self.viewPlaceHolder.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.viewPlaceHolder];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    listContacts = [[NSMutableArray alloc] init];
    
    query = _searchBar.text;
    page = (NSInteger*) 1;
    
    [[AppDelegate sharedInstance].api search: query
                                        size: page
                                        page: size
                                    callback:^(id responseObject, NSError *error) {
        if (!error) {
            listContacts = [[NSMutableArray alloc] init];
            
            for (NSDictionary* dicUser in [responseObject objectForKey:@"data"]) {
                [listContacts addObject:[[User alloc] initWithDictionary: dicUser]];
            }
            
            NSLog(@"%@", responseObject);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableCards reloadData];
            });
        } else {
            NSLog(@"%@", error);
        }
        [self.viewPlaceHolder setHidden:YES];
        [indicator stopAnimating];
    }];
    [indicator startAnimating];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CardCell";
    
    CardTableViewCell *cell = (CardTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[CardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:CellIdentifier];
    }
    
    User* user = (User *)[listContacts objectAtIndex:indexPath.row];
    cell.user = user;
    
    MeisshiListItem* meisshiUser = (MeisshiListItem *) [cell viewWithTag:10];
    meisshiUser.delegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [meisshiUser loadCard:user.card withUser:user];
    });
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listContacts count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    User* user = [listContacts objectAtIndex:indexPath.row];
    
    [self showProfileView:user];
}

- (void) showProfileView: (User*) user {
    UIStoryboard* storyBoard     = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navController = (UINavigationController*) [storyBoard instantiateViewControllerWithIdentifier:@"ProfileController"];
    
    ProfileViewController* controller = navController.viewControllers[0];
    controller.user = user;
    
    [navController setTitle:user.showName];
    
    [self showViewController:navController sender:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) keyboardWasShown: (NSNotification*) aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    _tableCards.contentInset = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
   /* if (!CGRectContainsPoint(aRect, _activeField.frame.origin)) {
        [_tableCards scrollRectToVisible:_activeField.frame animated:YES];
    } */
}

- (void) keyboardWillBeHidden: (NSNotification*) aNotification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _tableCards.contentInset   = contentInsets;
    _tableCards.scrollIndicatorInsets = contentInsets;
}

- (IBAction)onBtnSearchClick:(id)sender {
    [_tfSearch resignFirstResponder];
    [self loadContacts];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    [self loadContacts];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
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

-(void) didClickCard:(MeisshiCard *)card telephone:(NSString *)telephone {
    [self makeTelephoneCall:telephone];
}

-(void) didClickCard:(MeisshiCard *)card twitter:(NSString *)twitter {
    NSString* urlAction = nil;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]])
        urlAction = [NSString stringWithFormat:@"twitter://user?screen_name=%@", twitter];
    else
        urlAction = [NSString stringWithFormat:@"https://www.twitter.com/%@", twitter];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:urlAction]
                                       options: @{}
                             completionHandler: nil];
}

-(void) didClickCard:(MeisshiCard *)card facebook:(NSString *)facebook {
    NSString* urlAction = nil;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://profile"]])
        urlAction = [NSString stringWithFormat:@"fb://profile?id=%@", facebook];
    else
        urlAction = [NSString stringWithFormat: @"https://www.facebook.com/%@", facebook];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:urlAction]
                                       options: @{}
                             completionHandler: nil];
}

-(void) didClickCard:(MeisshiCard *)card website:(NSString *)website {
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:website]
                                       options: @{}
                             completionHandler: nil];
}

-(void) didClickCard:(MeisshiCard *)card address:(NSString *)address {
    address   = [address stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString* urlAction = [NSString stringWithFormat:@"http://maps.apple.com/?q=%@", address];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:urlAction]
                                       options: @{}
                             completionHandler: nil];
}

-(void) didClickCard:(MeisshiCard *)card email:(NSString *)email {
    if ([MFMailComposeViewController canSendMail])
    {
        _mailComposeController = [[MFMailComposeViewController alloc] init];
        [_mailComposeController setSubject:@"Sample Subject"];
        [_mailComposeController setMessageBody:@"Here is some main text in the email!" isHTML:NO];
        [_mailComposeController setToRecipients:@[email]];
        [_mailComposeController setMailComposeDelegate:self];
        
        [self presentViewController:_mailComposeController animated:YES completion:nil];
    }
    else
    {
        NSLog(@"This device cannot send email");
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat top = 0;
    CGFloat bottom = scrollView.contentSize.height - scrollView.frame.size.height;
    CGFloat buffer = 600;
    CGFloat scrollPosition = scrollView.contentOffset.y;

    if (scrollPosition > bottom - buffer) {
        [self loadData];
    }
}
@end
