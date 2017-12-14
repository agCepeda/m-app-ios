//
//  QrViewController.m
//  Meishii
//
//  Created by Develop Mx on 19/08/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import "AppDelegate.h"
#import "QrViewController.h"
#import "ProfileViewController.h"
#import "User.h"

#import "AFURLSessionManager.h"


@interface QrViewController ()

@end

@implementation QrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated {
    if (!_isScanning)
        [self startScanner];
}

-(void) loadProfile:(NSString*) identifier {
    [[AppDelegate sharedInstance].api getUser: identifier
                                 loadMyReview: NO
                                     callback: ^(id responseObject, NSError *error) {
        if (!error) {
            User *user = [[User alloc] initWithDictionary:responseObject];
            
            UIStoryboard* storyBoard     = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ProfileViewController *controller = (ProfileViewController*) [storyBoard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
            controller.user = user;
            
            [self.navigationController pushViewController:controller animated:YES];
        } else {
            NSLog(@"%@", error);
        }
    }];
    
}

-(void) startScanner {
    
    NSString* baseUrl = [[AppDelegate sharedInstance].api serviceEndpoint:@"user/"];
    
    self.scanner = [[MTBBarcodeScanner alloc] initWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode] previewView:_outputView];
    [MTBBarcodeScanner requestCameraPermissionWithSuccess:^(BOOL success) {
        _isScanning = success;
        if (success) {
            
            [self.scanner startScanningWithResultBlock:^(NSArray *codes) {
                AVMetadataMachineReadableCodeObject *code = [codes firstObject];
                [self.scanner stopScanning];
                _isScanning = NO;
                NSRange replaceRange = [code.stringValue rangeOfString:baseUrl];
                if (replaceRange.location != NSNotFound) {
                    NSString* identifier = [code.stringValue stringByReplacingCharactersInRange:replaceRange withString:@""];
                    [self loadProfile:identifier];
                } else {
                    
                    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Codigo QR no valido" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* okButton = [UIAlertAction
                                               actionWithTitle:@"Aceptar"
                                               style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                                   [self startScanner];
                                               }];
                    [alert addAction:okButton];
                    
                    [self presentViewController:alert animated:YES completion:nil];
                }
            }];
            
        } else {
            // The user denied access to the camera
        }
    }];
}

-(void)viewDidDisappear:(BOOL)animated {
    if (_isScanning)
        [self.scanner stopScanning];
    _isScanning = NO;
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
