//
//  LoginViewController.m
//  Meishii
//
//  Created by Develop Mx on 25/10/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import "LoginViewController.h"
#import "AFURLSessionManager.h"
#import "AppDelegate.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _btnLoginFacebook.readPermissions = @[ @"email" ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self registerForKeyboardNotifications];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self deregisterFromKeyboardNotifications];
    
    [super viewWillDisappear:animated];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onBtnLoginClick:(id)sender {
    [_activeField resignFirstResponder];
    [[AppDelegate sharedInstance].api loginEmail:_tfUsername.text password:_tfPassword.text callback:^(NSDictionary *responseObject, NSError *error) {
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

- (IBAction)onCancelClick:(id)sender {
    [_activeField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void) showMainViewController {
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController* vc = [storyBoard instantiateViewControllerWithIdentifier:@"MainNavigationController"];
    
    [self presentViewController:vc animated:YES completion:^{
        [[[UIApplication sharedApplication] keyWindow] setRootViewController:vc];
    }];
}

-(BOOL)loginButtonWillLogin:(FBSDKLoginButton *)loginButton {
    return YES;
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
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
                                                
                                                Session* session = [[Session alloc] initWithDictionary:responseObject];
                                                
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _activeField = textField;
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
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWasShown:(NSNotification*)aNotification {
    
    NSDictionary* info = [aNotification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    // If you are using Xcode 6 or iOS 7.0, you may need this line of code. There was a bug when you
    // rotated the device to landscape. It reported the keyboard as the wrong size as if it was still in portrait mode.
    //kbRect = [self.view convertRect:kbRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbRect.size.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
    /*
     NSDictionary* info = [aNotification userInfo];
    
    CGRect rectKeyboard = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect rectScrollView = _scrollView.frame;
    
    rectScrollView.size.height -= rectKeyboard.size.height;
    [_scrollView setFrame:rectScrollView];
    */
}
@end
