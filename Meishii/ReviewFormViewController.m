//
//  ReviewFormViewController.m
//  Meishii
//
//  Created by Develop Mx on 23/09/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import "ReviewFormViewController.h"
#import "AFURLSessionManager.h"
#import "AppDelegate.h"

@interface ReviewFormViewController ()

@end

@implementation ReviewFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    
    UIImage* backgroundImage = [UIImage imageNamed:@"backpattern.jpg"];
    UIColor* backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    [self.view setBackgroundColor:backgroundColor];
    
    _tvComment.layer.borderColor = [[UIColor whiteColor]CGColor];
    _tvComment.layer.borderWidth = 1.5;
    
    /*
    _txfPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) save:(id) sender {
    [_tvComment resignFirstResponder];
    
    NSLog(@"Texto de commentario %@", _tvComment.text);
    NSLog(@"Texto de commentario %ld", (long) _srScore.value);
    
    [[AppDelegate sharedInstance].api postReviewToUser: _user.identifier
                                               comment: _tvComment.text
                                                 score: [NSString stringWithFormat:@"%.f", floor(_srScore.value)]
                                              callback: ^(NSDictionary *responseObject, NSError *error) {
                                                  if (!error) {
                                                      _user.review = [[Review alloc] initWithDictionary:responseObject];
                                                      [self back:nil];
                                                      NSLog(@"%@", responseObject);
                                                  } else {
                                                      NSLog(@"%@", error);
                                                  }
    }];

}

- (void) back:(id) sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
