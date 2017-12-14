//
//  EditProfileViewController.m
//  Meishii
//
//  Created by Develop Mx on 28/08/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import "AppDelegate.h"
#import "EditProfileViewController.h"
#import "AFURLSessionManager.h"
#import "Profession.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SelectCardViewController.h"
#import "Text.h"
#import <FSMediaPicker/FSMediaPicker.h>

@interface EditProfileViewController () <FSMediaPickerDelegate>

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tfTelephone1.mask = @"(###) ###-####";
    self.tfTelephone2.mask = @"(###) ###-####";

    user = [AppDelegate sharedInstance].session.user;
    
    self.tfName.text       = user.firstName;
    self.tfLastName.text   = user.lastName;
    self.tfProfession.text = user.profession;
    self.tfTelephone1.text = user.telephone1;
    self.tfEmail.text = user.workEmail;
    self.tfWebsite.text = user.website;
    self.tfFacebook.text = user.facebook;
    self.tfTwitter.text = user.twitter;
    self.tfInstagram.text = user.instagram;
    self.tfBio.text = user.bio;
    
    self.tfStreet.text = user.street;
    self.tfNumber.text = user.number;
    self.tfNeighborhood.text = user.neighborhood;
    self.tfCity.text = user.city;
    self.tfZipCode.text = user.zipCode;
    
    [_tfProfession setDelegate:self];
    
    [self setupTextField:_tfName withPlacholder:@"Name"];
    [self setupTextField:_tfLastName withPlacholder:@"Last name"];
    [self setupTextField:_tfProfession withPlacholder:@"Profession"];
    [self setupTextField:_tfTelephone1 withPlacholder:@"Phone"];
    [self setupTextField:_tfEmail withPlacholder:@"Email"];
    [self setupTextField:_tfWebsite withPlacholder:@"Website"];
    [self setupTextField:_tfFacebook withPlacholder:@"Facebook"];
    [self setupTextField:_tfTwitter withPlacholder:@"Twitter"];
    [self setupTextField:_tfInstagram withPlacholder:@"Instagram"];
    [self setupTextField:_tfBio withPlacholder:@"Bio"];
    
    [self setupTextField:_tfStreet withPlacholder:@"Street"];;
    [self setupTextField:_tfNumber withPlacholder:@"Number"];;
    [self setupTextField:_tfNeighborhood withPlacholder:@"Neighborhood"];;
    [self setupTextField:_tfCity withPlacholder:@"City"];;
    [self setupTextField:_tfZipCode withPlacholder:@"Zip code"];
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 2;
    border.borderColor = [UIColor whiteColor].CGColor;
    border.frame = CGRectMake(0, _lblProfession.frame.size.height - borderWidth, _lblProfession.frame.size.width, _lblProfession.frame.size.height);
    border.borderWidth = borderWidth;
    [_lblProfession.layer addSublayer:border];
    _lblProfession.layer.masksToBounds = YES;
    
    [self.ivProfilePhoto sd_setImageWithURL:user.profilePicture];
    [self.ivLogo sd_setImageWithURL:user.logo];
    
    UIGestureRecognizer *profileImageTap = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(didProfilePhotoTap:)];
    [_ivProfilePhoto setUserInteractionEnabled:YES];
    [_ivProfilePhoto addGestureRecognizer:profileImageTap];
    
    UIGestureRecognizer *logoImageTap = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(didLogoTap:)];
    [_ivLogo setUserInteractionEnabled:YES];
    [_ivLogo addGestureRecognizer:logoImageTap];

    self.ivProfilePhoto.layer.cornerRadius = 50;
    self.ivProfilePhoto.layer.masksToBounds = YES;
    
    UIImage* backgroundImage = [UIImage imageNamed:@"backpattern.jpg"];
    UIColor* backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    [self.view setBackgroundColor:backgroundColor];
}

- (void)didProfilePhotoTap:(UIGestureRecognizer *)gestureRecognizer {
    //UIImageView *myImage = (UIImageView *)gestureRecognizer.view;
    // do stuff;
    NSLog(@"it works profile");
}

- (void)didLogoTap:(UIGestureRecognizer *)gestureRecognizer {
    //UIImageView *myImage = (UIImageView *)gestureRecognizer.view;
    // do stuff;
    NSLog(@"it works logo");
}


-(void) back: (id) sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"showSelectCard"]) {
        NSMutableArray* errors = [self validate];
        if (errors.count == 0) {
            return YES;
        }
        
            NSString* error = [errors componentsJoinedByString:@"\n"];
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:error preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okButton = [UIAlertAction
                                       actionWithTitle:@"Ok"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                       }];
            [alert addAction:okButton];
            
            [self presentViewController:alert animated:YES completion:nil];
    }
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showSelectCard"]) {
        
            _settings = [[NSMutableDictionary alloc] init];
            
            if (![self.tfName.text isEqualToString:user.firstName])
                [_settings setValue:self.tfName.text forKey:@"name"];
            
            if (![self.tfLastName.text isEqualToString:user.lastName])
                [_settings setValue:self.tfLastName.text forKey:@"last_name"];
        
        if (![self.tfProfession.text isEqualToString:user.profession])
            [_settings setValue:self.tfProfession.text forKey:@"profession"];
        
            if (![self.tfTelephone1.text isEqualToString:user.telephone1])
                [_settings setValue:self.tfTelephone1.text forKey:@"telephone1"];
            
            if (![self.tfEmail.text isEqualToString:user.workEmail])
                [_settings setValue:self.tfEmail.text forKey:@"work_email"];
            
            if (![self.tfWebsite.text isEqualToString:user.website])
                [_settings setValue:self.tfWebsite.text forKey:@"website"];
            
            if (![self.tfFacebook.text isEqualToString:user.facebook])
                [_settings setValue:self.tfFacebook.text forKey:@"facebook"];
            
            if (![self.tfTwitter.text isEqualToString:user.twitter])
                [_settings setValue:self.tfTwitter.text forKey:@"twitter"];
            
            if (![self.tfInstagram.text isEqualToString:user.instagram])
                [_settings setValue:self.tfInstagram.text forKey:@"instagram"];
            
            if (![self.tfBio.text isEqualToString:user.bio])
                [_settings setValue:self.tfBio.text forKey:@"bio"];
            
            if (![self.tfStreet.text isEqualToString:user.street])
                [_settings setValue:self.tfStreet.text forKey:@"street"];
            if (![self.tfNumber.text isEqualToString:user.number])
                [_settings setValue:self.tfNumber.text forKey:@"number"];
            if (![self.tfNeighborhood.text isEqualToString:user.neighborhood])
                [_settings setValue:self.tfNeighborhood.text forKey:@"neighborhood"];
            if (![self.tfCity.text isEqualToString:user.city])
                [_settings setValue:self.tfCity.text forKey:@"city"];
            if (![self.tfZipCode.text isEqualToString:user.zipCode])
                [_settings setValue:self.tfZipCode.text forKey:@"zip_code"];
            
            if(_imageLogoData != nil)
                [_settings setObject:_imageLogoData forKey:@"logo"];
            if(_imageProfileData != nil)
                [_settings setObject:_imageProfileData forKey:@"profile_picture"];
            
            SelectCardViewController *vc = ((UINavigationController*) [segue destinationViewController]).viewControllers[0];
            
            vc.profileViewController = self.profileViewController;
            vc.parameters = _settings;
    }
}

- (IBAction)onBackClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    if (indexPath.row == 0 && indexPath.section == 0){
        [_tfName setEnabled:YES];
        [_tfName becomeFirstResponder];
    }
    */
    if (indexPath.row == 1 && indexPath.section == 0){
        [_tfName setEnabled:YES];
        [_tfName becomeFirstResponder];
    }
    if (indexPath.row == 2 && indexPath.section == 0){
        [_tfLastName setEnabled:YES];
        [_tfLastName becomeFirstResponder];
    }
    if (indexPath.row == 3 && indexPath.section == 0){
        [_tfTelephone1 setEnabled:YES];
        [_tfTelephone1 becomeFirstResponder];
    }
    if (indexPath.row == 4 && indexPath.section == 0) {
        [_tfProfession setEnabled:YES];
        [_tfProfession becomeFirstResponder];
    }
    if (indexPath.row == 5 && indexPath.section == 0) {
        [_tfEmail setEnabled:YES];
        [_tfEmail becomeFirstResponder];
    }
    if (indexPath.row == 6 && indexPath.section == 0) {
        [_tfWebsite setEnabled:YES];
        [_tfWebsite becomeFirstResponder];
    }
    if (indexPath.row == 7 && indexPath.section == 0) {
        [_tfFacebook setEnabled:YES];
        [_tfFacebook becomeFirstResponder];
    }
    if (indexPath.row == 8 && indexPath.section == 0) {
        [_tfTwitter setEnabled:YES];
        [_tfTwitter becomeFirstResponder];
    }
    if (indexPath.row == 9 && indexPath.section == 0) {
        [_tfInstagram setEnabled:YES];
        [_tfInstagram becomeFirstResponder];
    }
    if (indexPath.row == 10 && indexPath.section == 0) {
        [_tfBio setEnabled:YES];
        [_tfBio becomeFirstResponder];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}


-(NSMutableArray*) validate {
    NSMutableArray* errors = [[NSMutableArray alloc] init];
    if (self.tfFacebook.text.length > 0 && ![Text isFacebook:self.tfFacebook.text])
        [errors addObject:@"The facebook has not the correct format. \nEx. john.cena"];
    if (self.tfTwitter.text.length > 0 && ![Text isTwitter:self.tfTwitter.text])
        [errors addObject:@"The twitter has not the correct format. \nEx. @lady_gaga"];
    if (self.tfWebsite.text.length > 0 && ![Text isWebsite:self.tfWebsite.text])
        [errors addObject:@"The website has not the correct format. \nEx. http://www.google.com"];
    
    
    if (self.tfEmail.text.length > 0 && ![Text isEmail:self.tfEmail.text])
        [errors addObject:@"The email has not the correct format."];
    
    if (![self.tfStreet.text isEqualToString:user.street])
        [_settings setValue:self.tfStreet.text forKey:@"street"];
    if (![self.tfNumber.text isEqualToString:user.number])
        [_settings setValue:self.tfNumber.text forKey:@"number"];
    if (![self.tfNeighborhood.text isEqualToString:user.neighborhood])
        [_settings setValue:self.tfNeighborhood.text forKey:@"neighborhood"];
    if (![self.tfCity.text isEqualToString:user.city])
        [_settings setValue:self.tfCity.text forKey:@"city"];
    if (![self.tfZipCode.text isEqualToString:user.zipCode])
        [_settings setValue:self.tfZipCode.text forKey:@"zip_code"];
    
    return errors;
}

-(void) next: (id) sender {
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    _tfActiveField = textField;
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.tfName)
        [self.tfLastName becomeFirstResponder];
    if (textField == self.tfLastName)
        [self.tfTelephone1 becomeFirstResponder];
    if (textField == self.tfTelephone1)
        [self.tfTelephone2 becomeFirstResponder];
    if (textField == self.tfTelephone2)
        [self.tfTelephone2 resignFirstResponder];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == _tfTelephone1)
        return  [_tfTelephone1 shouldChangeCharactersInRange:range replacementString:string];
    if (textField == _tfTelephone2)
        return  [_tfTelephone2 shouldChangeCharactersInRange:range replacementString:string];
    return YES;
}

-(void) setupTextField: (UITextField *) textField withPlacholder:(NSString *) placeholder {
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 2;
    border.borderColor = [UIColor whiteColor].CGColor;
    border.frame = CGRectMake(0, textField.frame.size.height - borderWidth, textField.frame.size.width, textField.frame.size.height);
    border.borderWidth = borderWidth;
    [textField.layer addSublayer:border];
    textField.layer.masksToBounds = YES;
    textField.textColor = [UIColor whiteColor];
    
    
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
}

-(void) openImagePicker {
    //UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //picker.delegate = self;
    //7picker.allowsEditing = YES;
    ///picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary | UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    //[picker.navigationBar setBarStyle: UIBarStyleBlack];
    
    //[self.navigationController showDetailViewController:picker sender:nil];
    
    //FSMediaPicker *mediaPicker = [[FSMediaPicker alloc] init];
    //mediaPicker.mediaType = FSMediaTypePhoto;
    //mediaPicker.editMode = FSEditModeStandard;
    //mediaPicker.delegate = self;
    //[mediaPicker showFromView:_ivProfilePhoto];
    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]
                                                 init];
    pickerController.delegate = self;
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary | UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [pickerController.navigationBar setTintColor:[UIColor blackColor]];
    [pickerController.navigationController.navigationBar setTintColor:[UIColor blackColor]];
 
    [self showViewController:pickerController sender:nil];
    //[self presentViewController:pickerController animated:YES completion:nil];
}

- (IBAction)OnBtnCancelClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)profileImageClick:(id)sender {
    flagProfileImage = YES;
    [self openImagePicker];
}

- (IBAction)logoImageClick:(id)sender {
    flagProfileImage = FALSE;
    [self openImagePicker];
}

#pragma mark - ImagePickerView Delegate

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [self dismissViewControllerAnimated:YES completion:^{
        if (_error) {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:_error preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okButton = [UIAlertAction
                                       actionWithTitle:@"Ok"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                       }];
            [alert addAction:okButton];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    
    
    UIImage* image    = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData* imageData =  UIImageJPEGRepresentation(image, 1.0f);
    
    if (flagProfileImage) {
        if((float)imageData.length/1024.0f/1024.0f <= 5) {
            if (flagProfileImage) {
                _ivProfilePhoto.image  = image;
                _imageProfileData = imageData;
            }
            _error = nil;
        } else {
            _error = [NSString stringWithFormat: @"The size of the image must be smaller than 5MB"];
            NSLog(@"Tamaño de la imagen inadecuado  %.2f MB", (float)imageData.length/1024.0f/1024.0f);
        }
    } else {
        if((float)imageData.length/1024.0f/1024.0f <= 5) {
            _ivLogo.image  = image;
            _imageLogoData = imageData;
            _error = nil;
        } else {
            _error = [NSString stringWithFormat: @"The size of the image must be smaller than 5MB"];
            NSLog(@"Tamaño de la imagen inadecuado  %.2f MB", (float)imageData.length/1024.0f/1024.0f);
        }
    }
}


- (void)mediaPicker:(FSMediaPicker *)mediaPicker didFinishWithMediaInfo:(NSDictionary *)mediaInfo
{
}

- (void)mediaPickerDidCancel:(FSMediaPicker *)mediaPicker
{
    NSLog(@"%s",__FUNCTION__);
}
@end
