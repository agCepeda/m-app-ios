//
//  EditProfileViewController.h
//  Meishii
//
//  Created by Develop Mx on 28/08/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "ProfileViewController.h"
#import <VMaskTextField/VMaskTextField.h>

@interface EditProfileViewController : UITableViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>
{
    BOOL imagePickerHidden;
    User* user;
    
    BOOL flagProfileImage;
}

@property (strong, nonatomic) NSMutableDictionary* settings;

@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UITextField *tfLastName;
@property (weak, nonatomic) IBOutlet UITextField *tfProfession;

@property (weak, nonatomic) IBOutlet VMaskTextField *tfTelephone1;
@property (weak, nonatomic) IBOutlet VMaskTextField *tfTelephone2;

@property (weak, nonatomic) UITextField *tfActiveField;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;

@property (weak, nonatomic) IBOutlet UIImageView *ivProfilePhoto;
@property (weak, nonatomic) IBOutlet UIImageView *ivLogo;

@property (weak, nonatomic) UIImageView *ivTarget;

@property (weak, nonatomic) IBOutlet UIPickerView *pkvProfessions;

@property (weak, nonatomic) IBOutlet UILabel *lblProfession;

@property (weak, nonatomic) IBOutlet UISwitch *swTelephone1;
@property (weak, nonatomic) IBOutlet UISwitch *swTelephone2;
@property (weak, nonatomic) IBOutlet UISwitch *swProfession;

@property (nonatomic, strong) ProfileViewController* profileViewController;

@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfWebsite;
@property (weak, nonatomic) IBOutlet UITextField *tfFacebook;
@property (weak, nonatomic) IBOutlet UITextField *tfTwitter;
@property (weak, nonatomic) IBOutlet UITextField *tfInstagram;
@property (weak, nonatomic) IBOutlet UITextField *tfBio;

@property (weak, nonatomic) IBOutlet UITextField *tfStreet;
@property (weak, nonatomic) IBOutlet UITextField *tfNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfNeighborhood;
@property (weak, nonatomic) IBOutlet UITextField *tfCity;
@property (weak, nonatomic) IBOutlet UITextField *tfZipCode;

@property (strong, nonatomic) NSData* imageLogoData;
@property (strong, nonatomic) NSData* imageProfileData;

@property (strong, nonatomic) NSData* imageDataTarget;

@property (strong, nonatomic) NSString* error;
- (IBAction)OnBtnCancelClick:(id)sender;

- (IBAction)profileImageClick:(id)sender;
- (IBAction)logoImageClick:(id)sender;

@end
