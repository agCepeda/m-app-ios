//
//  DeckViewController.m
//  Meishii
//
//  Created by Develop Mx on 19/08/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import "DeckViewController.h"
#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "CardTableViewCell.h"
#import "AFURLRequestSerialization.h"
#import "AFURLResponseSerialization.h"
#import "User.h"
#import "MeisshiCard.h"
#import "MeisshiListItem.h"

@interface DeckViewController ()

@end

@implementation DeckViewController

- (id) init {
    self = [super init];
    
    if (self){
        contactSections      = [[NSMutableDictionary alloc] init];
        contactSectionTitles = [[NSMutableArray alloc] init];
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _tableTarjetas.sectionIndexBackgroundColor = [UIColor clearColor];
    _tableTarjetas.sectionIndexColor = [UIColor whiteColor];
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
    [self.viewPlaceHolder addSubview:indicator];
    [indicator bringSubviewToFront:self.viewPlaceHolder];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    [[AppDelegate sharedInstance].api getContacts:^(NSArray *users, NSError *error) {
        if (!error) {
            NSArray* arrContacts = users;
            
            if (!error) {
                
                contactSections = [[NSMutableDictionary alloc] init];
                
                for (NSDictionary* contact in arrContacts) {
                    User* user = [[User alloc] initWithDictionary:contact];
                    NSString* firstLetter = [user.showName substringWithRange:NSMakeRange(0, 1)];
                    firstLetter           = [firstLetter capitalizedString];
                    
                    NSMutableArray* section = [contactSections objectForKey:firstLetter];
                    
                    if (section == nil) {
                        section = [[NSMutableArray alloc] init];
                        [contactSections setObject:section forKey:firstLetter];
                    }
                    
                    [section addObject:user];
                    
                    contactSectionTitles = [[contactSections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
                    
                }
                NSLog(@"%@", contactSections);
                NSLog(@"%@", contactSectionTitles);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableTarjetas reloadData];
                });
                
            } else {
                
                NSLog(@"%@", error);
            }
            
        } else {
            NSLog(@"%@", error);
        }
        
        [self.viewPlaceHolder setHidden:YES];
        [indicator stopAnimating];
    }];
    [indicator startAnimating];
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [contactSectionTitles count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [contactSectionTitles objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return contactSectionTitles;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString* sectionTitle     = [contactSectionTitles objectAtIndex:section];
    NSMutableArray* ctcSection = [contactSections objectForKey:sectionTitle];
    
    return [ctcSection count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CardCell";
    
    CardTableViewCell *cell = (CardTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[CardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:CellIdentifier];
        
    }
    
    NSString* sectionTitle = [contactSectionTitles objectAtIndex:indexPath.section];
    NSArray* section       = [contactSections objectForKey:sectionTitle];
    
    User* user = (User *) [section objectAtIndex:indexPath.row];
    cell.user = user;
    
    MeisshiListItem* meisshiUser = (MeisshiListItem *) [cell viewWithTag:10];
    meisshiUser.delegate = self;
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [meisshiUser loadCard:user.card withUser:user];
    });
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* sectionTitle = [contactSectionTitles objectAtIndex:indexPath.section];
    NSArray* section       = [contactSections objectForKey:sectionTitle];
    
    User* user = (User *) [section objectAtIndex:indexPath.row];
    
    [self showProfileView: user];
}

-(void)viewDidAppear:(BOOL)animated {
    [self loadContacts];
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

- (void) showProfileView: (User*) user {
    UIStoryboard* storyBoard     = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navController = (UINavigationController*) [storyBoard instantiateViewControllerWithIdentifier:@"ProfileController"];
    
    
    ProfileViewController* controller = navController.viewControllers[0];
    controller.user = user;
    
    [navController setTitle:user.showName];
    
    [self showViewController:navController sender:nil];
}

@end
