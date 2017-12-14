//
//  LoginViewController.h
//  Meishii
//
//  Created by Develop Mx on 25/10/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController : UIViewController<FBSDKLoginButtonDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tfUsername;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *btnLoginFacebook;

@property (weak, nonatomic) UITextField *activeField;

- (IBAction)onBtnLoginClick:(id)sender;
- (IBAction)onCancelClick:(id)sender;
@end
