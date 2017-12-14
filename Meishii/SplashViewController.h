//
//  SplashViewController.h
//  Meishii
//
//  Created by Develop Mx on 19/08/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "User.h"
#import "Session.h"

@interface SplashViewController : UIViewController<FBSDKLoginButtonDelegate, UITextFieldDelegate>

@property (nonatomic, strong) User* user;

@property (weak, nonatomic) UITextField *activeField;

@property (weak, nonatomic) IBOutlet UITextField *txfUsername;
@property (weak, nonatomic) IBOutlet UITextField *txfPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnForgotPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *btnLoginFacebook;

- (IBAction) onBtnNewUserClick: (id) sender;
- (IBAction) onBtnShowLoginClick: (id) sender;

@property (weak, nonatomic) IBOutlet UIView *optionsContainer;

- (IBAction)onBtnForgotPasswordClick:(id)sender;
- (IBAction)onBtnLoginClick:(id)sender;
- (IBAction)onBtnLoginFacebookClick:(id)sender;

@end
