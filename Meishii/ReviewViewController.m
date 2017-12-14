//
//  ReviewViewController.m
//  Meishii
//
//  Created by Develop Mx on 20/08/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import "ReviewViewController.h"
#import "ReviewFormViewController.h"
#import "AppDelegate.h"
#import "AFURLSessionManager.h"
#import <HCSStarRatingView/HCSStarRatingView.h>

@interface ReviewViewController ()

@end

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString* cellIdentifier = @"ReviewFormCell";
    
    UITableViewCell *reviewFormCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    UIColor *borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
    
    UITextView* tvComment = (UITextView*) [reviewFormCell viewWithTag:20];
    
    tvComment.layer.borderColor = borderColor.CGColor;
    tvComment.layer.borderWidth = 1.0;
    tvComment.layer.cornerRadius = 5.0;
    
    return reviewFormCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 138;
}*/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listReviews.count + (_user.review == nil && !_isOwnProfile ? 1 : 0);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* cellIdentifier = @"ReviewCell";
    
    UITableViewCell *reviewCell = nil;
    
    if (indexPath.row == 0 && _user.review == nil && !_isOwnProfile) {
        
        reviewCell = [tableView dequeueReusableCellWithIdentifier:@"ReviewFormCell"];
        
        UITextView* tvComment = (UITextView*) [reviewCell viewWithTag:20];
        UIButton* btnSend     = (UIButton *) [reviewCell viewWithTag:30];
        
        [btnSend addTarget:self action:@selector(sendButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIColor *borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
        
        tvComment.layer.borderColor = borderColor.CGColor;
        tvComment.layer.borderWidth = 1.0;
        tvComment.layer.cornerRadius = 5.0;
    } else {
        reviewCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        UILabel* lblReviewer    = (UILabel *) [reviewCell viewWithTag:10];
        UILabel* lblComment     = (UILabel *) [reviewCell viewWithTag:20];
        HCSStarRatingView* srScore = [reviewCell viewWithTag:30];
        
        Review* review = [listReviews objectAtIndex:indexPath.row - (_user.review == nil && !_isOwnProfile ? 1 : 0)];
        
        [lblReviewer setText:review.reviewerName];
        [lblComment setText:review.comment];
        [srScore setValue:review.score];
        

    }
    
    return reviewCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66;
}

-(void)sendButtonClicked:(UIButton*)sender
{
    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    UITextView* tvComment = (UITextView*) [cell viewWithTag:20];
    HCSStarRatingView* srScore = (HCSStarRatingView*) [cell viewWithTag:10];
    
    [tvComment resignFirstResponder];
    
    NSLog(@"Texto de commentario %@", tvComment.text);
    NSLog(@"Texto de commentario %ld", (long) srScore.value);
    
    [[AppDelegate sharedInstance].api postReviewToUser: _user.identifier
                                               comment: tvComment.text
                                                 score: [NSString stringWithFormat:@"%.f", floor(srScore.value)]
                                              callback: ^(NSDictionary *responseObject, NSError *error) {
                                                  if (!error) {
                                                      Review* review = [[Review alloc] initWithDictionary:responseObject];
                                                      [listReviews addObject:review];
                                                      
                                                      _user.review = review;
                                                      
                                                      dispatch_async(dispatch_get_main_queue(), ^{
                                                          [self.tableView reloadData];
                                                      });
                                                      
                                                      NSLog(@"%@", responseObject);
                                                  } else {
                                                      NSLog(@"%@", error);
                                                  }
    }];
}

-(void) loadReviews {
    
    if (listReviews != nil)
        return;
    
    listReviews = [[NSMutableArray alloc] init];
    
    [[AppDelegate sharedInstance].api getReviewsById: _user.identifier
                                            callback: ^(NSDictionary *responseObject, NSError *error) {
                                                if (!error) {
                                                    NSArray* reviews = [responseObject objectForKey:@"data"];
                                                    
                                                    for (NSDictionary* dicReview in reviews) {
                                                        Review* review = [[Review alloc] initWithDictionary:dicReview];
                                                        [listReviews addObject:review];
                                                    }
                                                    
                                                    NSLog(@"%@", listReviews);
                                                    
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        [self.tableView reloadData];
                                                    });
                                                } else {
                                                    NSLog(@"%@", error);
                                                }
    }];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showReviewForm"]) {
        ReviewFormViewController* reviewFormVC = (ReviewFormViewController *) [segue destinationViewController];
        reviewFormVC.user = _user;
        
    }
}

@end
