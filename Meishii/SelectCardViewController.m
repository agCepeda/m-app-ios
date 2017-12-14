//
//  SelectCardViewController.m
//  Meishii
//
//  Created by Develop Mx on 28/08/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import "SelectCardViewController.h"

#import "AppDelegate.h"
#import "AFURLSessionManager.h"
#import "UIColor+Hex.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SelectCardViewController ()

@end

@implementation SelectCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    listCards = [[NSMutableArray alloc] init];
    
    [self loadCards];
    // Uncomment the following line to preserve selection between presentations.
    //
    self.clearsSelectionOnViewWillAppear = NO;
    
    self.navigationItem.title  = @"Select yout card";
    self.navigationItem.prompt = @"Edit Profile";
    self.navigationItem.leftBarButtonItem.title = @"";
    self.navigationItem.leftBarButtonItem.accessibilityLabel = @"";
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    
    
    UIImage* backgroundImage = [UIImage imageNamed:@"backpattern.jpg"];
    UIColor* backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    [self.view setBackgroundColor:backgroundColor];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setParameters:(NSMutableDictionary *)parameters {
    _user = [[User alloc] init];
    
    _user.email     = [AppDelegate sharedInstance].user.email;
    _user.firstName = [AppDelegate sharedInstance].user.firstName;
    _user.lastName  = [AppDelegate sharedInstance].user.lastName;
    
    _user.profession = [AppDelegate sharedInstance].user.profession;
    
    _user.telephone1 = [AppDelegate sharedInstance].user.telephone1;
    _user.telephone2 = [AppDelegate sharedInstance].user.telephone2;
    
    _user.street       = [AppDelegate sharedInstance].user.street;
    _user.number       = [AppDelegate sharedInstance].user.number;
    _user.neighborhood = [AppDelegate sharedInstance].user.neighborhood;
    _user.city         = [AppDelegate sharedInstance].user.city;
    _user.zipCode      = [AppDelegate sharedInstance].user.zipCode;
    
    _user.website  = [AppDelegate sharedInstance].user.website;
    _user.facebook = [AppDelegate sharedInstance].user.facebook;
    _user.twitter  = [AppDelegate sharedInstance].user.twitter;
    
    _user.logo     = [AppDelegate sharedInstance].user.logo;
    
    NSData* logoData = [parameters objectForKey:@"logo"];
    _imageLogo = [UIImage imageWithData:logoData];
    
    if ([parameters objectForKey:@"name"])
        _user.firstName = [parameters objectForKey:@"name"];
    if ([parameters objectForKey:@"last_name"])
        _user.lastName = [parameters objectForKey:@"last_name"];
    if ([parameters objectForKey:@"telephone1"])
        _user.telephone1 = [parameters objectForKey:@"telephone1"];
    if ([parameters objectForKey:@"profession"])
        _user.profession = [parameters objectForKey:@"profession"];
    
    if ([parameters objectForKey:@"work_email"])
        _user.workEmail = [parameters objectForKey:@"work_email"];
    if ([parameters objectForKey:@"street"])
        _user.street = [parameters objectForKey:@"street"];
    if ([parameters objectForKey:@"number"])
        _user.number = [parameters objectForKey:@"number"];
    if ([parameters objectForKey:@"neighborhood"])
        _user.neighborhood = [parameters objectForKey:@"neighborhood"];
    if ([parameters objectForKey:@"zip_code"])
        _user.zipCode = [parameters objectForKey:@"zip_code"];
    if ([parameters objectForKey:@"city"])
        _user.city = [parameters objectForKey:@"city"];
    
    if ([parameters objectForKey:@"facebook"])
        _user.facebook = [parameters objectForKey:@"facebook"];
    if ([parameters objectForKey:@"twitter"])
        _user.twitter = [parameters objectForKey:@"twitter"];
    if ([parameters objectForKey:@"website"])
        _user.website = [parameters objectForKey:@"website"];
    
    _parameters = parameters;
    
}

- (void) loadCards {
    
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    indicator.center = self.tableView.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    [[AppDelegate sharedInstance].api getCards:^(NSArray *responseObject, NSError *error) {
        if (!error) {
            listCards = [[NSMutableArray alloc] init];
            for (NSDictionary* dicto in responseObject) {
                [listCards addObject:[[Card alloc] initWithDictionary:dicto]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } else {
            NSLog(@"%@", error);
        }
        [indicator stopAnimating];
    }];
    [indicator startAnimating];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedCard = [listCards objectAtIndex:indexPath.row];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listCards.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"SelectionCard";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    // Configure the cell...
    Card* card = (Card *) [listCards objectAtIndex:indexPath.row];
    /*
    NSString* cardUrl = [AppDelegate serviceEndpoint:[NSString stringWithFormat:@"card/%@/image", card.identifier]];
    UIImageView *cardImageView = (UIImageView *)[cell viewWithTag:100];
    
    [cardImageView setImageWithURL:[NSURL URLWithString:cardUrl]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
    });*/
    
    
    UIView *view = (UIView *)[cell viewWithTag:1000];
    
    view.layer.shadowOffset  = CGSizeMake(5, 5);
    view.layer.shadowRadius  = 5.0;
    view.layer.shadowOpacity = 0.5;
    
    view.layer.masksToBounds = NO;
    
    UIImageView *cardImageView = (UIImageView *)[cell viewWithTag:100];
    
    UILabel *labelName       = (UILabel *)[cell viewWithTag:1];
    UILabel *labelTelephone1 = (UILabel *)[cell viewWithTag:2];
    UILabel *labelProfession = (UILabel *)[cell viewWithTag:4];
    
    UILabel *labelWorkEmail = (UILabel *)[cell viewWithTag:6];
    
    UILabel *labelAddress    = (UILabel *)[cell viewWithTag:7];
    UILabel *labelFacebook   = (UILabel *)[cell viewWithTag:8];
    UILabel *labelTwitter    = (UILabel *)[cell viewWithTag:9];
    UILabel *labelWebsite    = (UILabel *)[cell viewWithTag:10];
    
    UIImageView *logoImageView = (UIImageView *) [cell viewWithTag:11];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (_imageLogo != nil)
            [logoImageView setImage:_imageLogo];
        else
            [logoImageView sd_setImageWithURL:_user.logo];
        [cardImageView sd_setImageWithURL:card.path];
        
        
        [self fillLabel: labelName withField:card.showName andText:_user.showName];
        [self fillLabel: labelProfession withField:card.profession andText:_user.profession];
        [self fillLabel: labelTelephone1 withField:card.telephone1 andText:_user.telephone1];
        [self fillLabel: labelAddress withField:card.address andText:_user.address];
        [self fillLabel: labelWebsite withField:card.website andText:_user.website];
        [self fillLabel: labelFacebook withField:card.facebook andText:_user.facebook];
        [self fillLabel: labelTwitter withField:card.twitter andText:_user.twitter];
        [self fillLabel: labelWorkEmail withField:card.workEmail andText:_user.workEmail];
        
        
        if (card.logo) {
            [logoImageView setHidden:NO];
            [logoImageView setFrame:card.logo.frame];
        } else {
            [logoImageView setHidden:YES];
        }
        
        

    });
    
    return cell;
}



- (void) fillLabel:(UILabel*) label withField:(Field *) field andText:(NSString *) text {
    if (field) {
        [label setHidden:NO];
        [label setFrame:field.frame];
        [label setTextColor:field.color];
        [label setFont:field.font];
        [label setText:text];
        
        if ([ALIGN_CENTER isEqualToString:field.align]) {
            [label setTextAlignment:NSTextAlignmentCenter];
        } else if ([ALIGN_RIGHT isEqualToString:field.align]) {
            [label setTextAlignment:NSTextAlignmentRight];
        } else {
            [label setTextAlignment:NSTextAlignmentLeft];
        }
        
    } else {
        [label setHidden:YES];
    }
}

- (void) save {
    
    if (selectedCard != nil)
        [_parameters setObject:selectedCard.identifier forKey:@"card"];
    else {
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle: @"Error"
                                                                        message: @"Please select a card before continue"
                                                                 preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction actionWithTitle: @"Ok"
                                                           style: UIAlertActionStyleDefault
                                                         handler: ^(UIAlertAction * action) {
                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                   }];
        [alert addAction:okButton];
        
        [self presentViewController: alert
                           animated: YES
                         completion: nil];
        
        return;
    }
    
    if (profession != nil) {
        [_parameters setObject:profession.identifier forKey:@"profession"];
    }
    
    NSData* logoData = [_parameters objectForKey:@"logo"];
    [_parameters removeObjectForKey:@"logo"];
    
    NSData* profileData = [_parameters objectForKey:@"profile_picture"];
    [_parameters removeObjectForKey:@"profile_picture"];
    
    [[AppDelegate sharedInstance].api updateUserWithData: _parameters
                                                    logo: logoData
                                          profilePicture: profileData
                                                callback: ^(NSDictionary *responseObject, NSError *error) {
                                                    if (!error) {
                                                        User* user = [[User alloc] initWithDictionary:responseObject];
                                                        
                                                        [AppDelegate sharedInstance].user = user;
                                                        if (_profileViewController){
                                                            [_profileViewController setUser:user];
                                                            [_profileViewController update];
                                                        }
                                                        NSLog(@"%@", responseObject);
                                                        [[[UIApplication sharedApplication] keyWindow].rootViewController dismissViewControllerAnimated:YES completion:nil];
                                                    } else {
                                                        NSLog(@"%@", error);
                                                    }
    }];
    
    NSLog(@"%@", [AppDelegate sharedInstance].user);
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
