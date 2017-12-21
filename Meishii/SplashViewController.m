//
//  SplashViewController.m
//  Meishii
//
//  Created by Develop Mx on 19/08/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import "SplashViewController.h"
#import "AppDelegate.h"
#import "AFURLSessionManager.h"
#import <FBSDKCoreKit/FBSDKAccessToken.h>
#import <FBSDKCoreKit/FBSDKGraphRequest.h>
#import "Text.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _btnLoginFacebook.readPermissions = @[ @"email" ];
    
    _txfUsername.layer.borderColor = [[UIColor whiteColor]CGColor];
    _txfUsername.layer.borderWidth = 1.5;
    _txfUsername.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    _txfPassword.layer.borderColor = [[UIColor whiteColor]CGColor];
    _txfPassword.layer.borderWidth = 1.5;
    _txfPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    _txfUsername.delegate = self;
    _txfPassword.delegate = self;
    
    _btnLogin.layer.cornerRadius = 10;
    
    _btnSignUp.layer.borderColor = [[UIColor whiteColor]CGColor];
    _btnSignUp.layer.borderWidth = 1.0;
    
    [_btnLoginFacebook setTitle:[NSString stringWithFormat:@"%C Log In With Facebook", 0xf230] forState:UIControlStateNormal];
}

-(void)viewDidAppear:(BOOL)animated {
    [self checkSession];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self registerForKeyboardNotifications];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self deregisterFromKeyboardNotifications];
    
    [super viewWillDisappear:animated];
    
}

-(BOOL)loginButtonWillLogin:(FBSDKLoginButton *)loginButton {
    return YES;
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) checkSession {
    [[AppDelegate sharedInstance].api checkSession:^(NSDictionary *user, NSError *error) {
        if (!error) {
            [AppDelegate sharedInstance].session = [[Session alloc] initWithDictionary:user];
            [self showMainViewController];
        } else {
            [self showLoginViewController];
            //[self.loginForm setHidden:NO];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)onBtnNewUserClick:(id)sender {
    
     UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     UIViewController* vc = [storyBoard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
     
     [self presentViewController:vc animated:YES completion:^{
     [[[UIApplication sharedApplication] keyWindow] setRootViewController:vc];
     }];
}

- (IBAction)onBtnShowLoginClick:(id)sender {
    
     UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     UIViewController* vc = [storyBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
     
     [self presentViewController:vc animated:YES completion:^{
     [[[UIApplication sharedApplication] keyWindow] setRootViewController:vc];
     }];
}

-(void) showMainViewController {
    
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController* vc = [storyBoard instantiateViewControllerWithIdentifier:@"MainNavigationController"];
    
    [self presentViewController:vc animated:YES completion:^{
        [[[UIApplication sharedApplication] keyWindow] setRootViewController:vc];
    }];
}

-(void) showLoginViewController {
    [_optionsContainer setHidden:NO];
}



- (IBAction)onBtnForgotPasswordClick:(id)sender {
}

- (IBAction)onBtnLoginClick:(id)sender {
    if (_txfUsername.text.length == 0 || _txfPassword.text.length == 0) {
        return;
    }
    [_activeField resignFirstResponder];
    [[AppDelegate sharedInstance].api loginEmail:_txfUsername.text password:_txfPassword.text callback:^(NSDictionary *responseObject, NSError *error) {
        if (!error) {
            // Show MainView
            Session* session = [[Session alloc] initWithDictionary:responseObject];
            [AppDelegate sharedInstance].session = session;
            
            NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
            [preferences setValue:session.token forKey:@"SESSION_TOKEN"];
            [preferences synchronize];
            
            
            //NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            //configuration.HTTPAdditionalHeaders      = @{ @"App-Key": @"24be5a2a527205a027ce648ecb65708a", @"Session-Token": sessionToken };
            
            //[AppDelegate sharedInstance].manager     = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
            
            //[self.navigationController performSegueWithIdentifier:@"showMainViewController" sender:self];
            [[AppDelegate sharedInstance].api setSessionToken:session.token];
            
            [self showMainViewController];
            
        } else {
            NSMutableDictionary *userInfo = [error.userInfo mutableCopy];
            
            NSString* msgString = nil;
            
            if ([userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] != nil) {
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:[userInfo objectForKey: @"com.alamofire.serialization.response.error.data"] options:0 error:nil];
                msgString = [json objectForKey:@"message"];
            } else {
                msgString = [userInfo objectForKey:@"NSLocalizedDescription"];
            }
            
            
            
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:msgString preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okButton = [UIAlertAction
                                       actionWithTitle:@"Aceptar"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                       }];
            [alert addAction:okButton];
            
            [self presentViewController:alert animated:YES completion:nil];
            
        }
    }];
}


-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    NSLog(@"Error: %@", error);
    NSLog(@"Result: %@", result);
    if (!error) {
        FBSDKAccessToken* accessToken = result.token;
        
        NSString* tokenString = accessToken.tokenString;
        NSString* userID      = accessToken.userID;
        
        
        NSLog(@"Access Token: %@", accessToken);
        NSLog(@"Token: %@", tokenString);
        NSLog(@"User: %@", userID);
        NSLog(@"Result: %@", result.grantedPermissions);
        NSLog(@"Result: %@", result.declinedPermissions);
        
        FBSDKGraphRequest* request = [[FBSDKGraphRequest alloc] initWithGraphPath:userID parameters:@{ @"fields": @" email,first_name,last_name" } ];
        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                [self initSessionWithFBResult: result];
            }
            
            [FBSDKAccessToken setCurrentAccessToken:nil];
        }];
        
        
    }
}

- (void) initSessionWithFBResult: (NSDictionary*) result {
    NSString* email     = [result objectForKey:@"email"];
    NSString* firstName = [result objectForKey:@"first_name"];
    NSString* lastName  = [result objectForKey:@"last_name"];
    
    [[AppDelegate sharedInstance].api loginEmail: email
                                            name: firstName
                                        lastName: lastName
                                        callback: ^(NSDictionary *responseObject, NSError *error) {
                                            if (!error) {
                                                
                                                Session * session = [[Session alloc] initWithDictionary:responseObject];
                                                
                                                [AppDelegate sharedInstance].session = session;
                                                
                                                NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
                                                [preferences setValue:session.token forKey:@"SESSION_TOKEN"];
                                                [preferences synchronize];
                                                
                                                
                                                NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
                                                configuration.HTTPAdditionalHeaders      = @{ @"App-Key": @"24be5a2a527205a027ce648ecb65708a", @"Session-Token": session.token };
                                                [AppDelegate sharedInstance].manager     = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
                                                
                                                
                                                //[self.navigationController performSegueWithIdentifier:@"showMainViewController" sender:self];
                                                [self showMainViewController];
                                            } else {
                                                
                                                NSMutableDictionary *userInfo = [error.userInfo mutableCopy];
                                                
                                                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:[userInfo objectForKey: @"com.alamofire.serialization.response.error.data"] options:0 error:nil];
                                                
                                                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:[json objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
                                                
                                                UIAlertAction* okButton = [UIAlertAction
                                                                           actionWithTitle:@"Aceptar"
                                                                           style:UIAlertActionStyleDefault
                                                                           handler:^(UIAlertAction * action) {
                                                                               [alert dismissViewControllerAnimated:YES completion:nil];
                                                                           }];
                                                [alert addAction:okButton];
                                                
                                                [self presentViewController:alert animated:YES completion:nil];
                                                
                                            }
                                        }];
    
}


- (IBAction)onBtnLoginFacebookClick:(id)sender {
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _activeField = textField;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _activeField = nil;
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)deregisterFromKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}


// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    /// UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    //self.scrollView.contentInset = contentInsets;
    //self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWasShown:(NSNotification*)aNotification {
    /*
    NSDictionary* info = [aNotification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbRect.size.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
    */
}
@end
