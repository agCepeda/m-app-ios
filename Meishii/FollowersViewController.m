//
//  FollowersViewController.m
//  Meishii
//
//  Created by Develop Mx on 07/03/17.
//  Copyright © 2017 Develop Mx. All rights reserved.
//

#import "FollowersViewController.h"
#import "ProfileViewController.h"
#import "FollowerCell.h"
#import "AppDelegate.h"

@interface FollowersViewController () {
    NSMutableArray* _followers;
    int _type;
}
@end

@implementation FollowersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    UIImage* backgroundImage = [UIImage imageNamed:@"backpattern.jpg"];
    UIColor* backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    [self.view setBackgroundColor:backgroundColor];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    indicator.center = self.tableView.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    _followers = [[NSMutableArray alloc] init];
    if (_type == TYPE_FOLLOWER) {
        [self.navigationController setTitle:@"Followers"];
        [[AppDelegate sharedInstance].api getFollowersOfUser: _user.identifier
                                                    callback: ^(NSArray *users, NSError *error) {
                                                        if (!error) {
                                                            _followers = [[NSMutableArray alloc] init];
                                                            for (NSDictionary* userDict in users) {
                                                                User* user = [[User alloc] initWithDictionary:userDict];
                                                                [_followers addObject:user];
                                                            }
                                                            [self.tableView reloadData];
                                                        }
                                                        [indicator stopAnimating];
                                                    }];
    } else if (_type == TYPE_FOLLOWING) {
        [self.navigationController setTitle:@"Followed"];
        [[AppDelegate sharedInstance].api getFollowingByUser: _user.identifier
                                                    callback: ^(NSArray *users, NSError *error) {
                                                        if (!error) {
                                                            _followers = [[NSMutableArray alloc] init];
                                                            for (NSDictionary* userDict in users) {
                                                                User* user = [[User alloc] initWithDictionary:userDict];
                                                                [_followers addObject:user];
                                                            }
                                                            [self.tableView reloadData];
                                                        }
                                                        [indicator stopAnimating];
                                                    }];
    }
    [indicator startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _followers.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"FollowerCell";
    
    FollowerCell *cell = (FollowerCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[FollowerCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:CellIdentifier];
    }
    
    [cell loadFollower:_followers[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    User* user = (User *) [_followers objectAtIndex:indexPath.row];
    
    [self showProfileView:user];
}

-(void)setType:(int)type {
    _type = type;
    
    if (_type == TYPE_FOLLOWER) {
        self.navigationItem.title = @"Followers";
    }
    if (_type == TYPE_FOLLOWING) {
        self.navigationItem.title = @"Followed";
    }
}

-(int)type {
    return _type;
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

- (IBAction)onBtnBackClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
