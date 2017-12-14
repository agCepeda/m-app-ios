//
//  CardViewController.m
//  Meishii
//
//  Created by Develop Mx on 19/08/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import "CardViewController.h"
#import "User.h"
#import "AppDelegate.h"

@interface CardViewController ()

@end

@implementation CardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _btnCreateCard.layer.shadowOffset  = CGSizeMake(5, 5);
    _btnCreateCard.layer.shadowRadius  = 5.0;
    _btnCreateCard.layer.shadowOpacity = 0.5;
    
    _btnCreateCard.layer.masksToBounds = NO;
    
    _card.delegate = self;
    _meisshiUser.delegate = self;
    
    
    // _btnShare.frame
    
    CGRect rect = CGRectMake(
                _btnShare.frame.origin.x,
                _btnShare.frame.origin.y,
                _btnShare.frame.size.width,
                _btnShare.frame.size.height
            );
    
    rect.size.height = 30;
    _btnShare.layer.cornerRadius = 23;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self update];
}

-(void) update {
    
    User* user = [AppDelegate sharedInstance].user;
    
    
    if (user.card != nil) {
        _containerCard.hidden = NO;
        _containerCreate.hidden = YES;
        
        [_card loadCard:user.card withUser:user];
        [_meisshiUser loadCard:user.card withUser:user];
        
    } else {
        _containerCard.hidden = YES;
        _containerCreate.hidden = NO;
    }
    
    /*
    [_lblName setText:user.showName];
    if (user.profession != nil)
        [_lblProfession setText:user.profession.name];
    
    [_lblAddress setText:[user address]];
    [_lblWebsite setText:user.website];
    [_lblTwitter setText:user.twitter];
    [_lblFacebook setText:user.facebook];
    [_lblTelephone1 setText:user.telephone1];
    [_lblTelephone2 setText:user.telephone2];
    
    [_lblCompany setText:user.company];
    [_lblWorkEmail setText:user.workEmail];
    
    NSString *qrUrl = [AppDelegate serviceEndpoint:[NSString stringWithFormat:@"user/%@/qr", user.identifier]];
    //NSString *logoUrl = [AppDelegate serviceEndpoint:[NSString stringWithFormat:@"user/%@/logo", user.identifier]];
    
    //NSLog(@"%@", logoUrl);
    NSLog(@"%@", qrUrl);
    
    [_qrImageView setImageWithURL:[NSURL URLWithString:qrUrl]];
    [_logoImageView setImageWithURL:user.logo];
    
    */
}

-(void)didTapEmailLabel: (UITapGestureRecognizer *)tapGesture {
    User* user = [AppDelegate sharedInstance].user;
    
    if ([MFMailComposeViewController canSendMail])
    {
        _mailComposeController = [[MFMailComposeViewController alloc] init];
        [_mailComposeController setSubject:@"Sample Subject"];
        [_mailComposeController setMessageBody:@"Here is some main text in the email!" isHTML:NO];
        [_mailComposeController setToRecipients:@[user.workEmail]];
        [_mailComposeController setMailComposeDelegate:self];
        
        [self presentViewController:_mailComposeController animated:YES completion:nil];
    }
    else
    {
        NSLog(@"This device cannot send email");
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [_mailComposeController dismissViewControllerAnimated:YES completion:NULL];
}

-(void)makeTelephoneCall:(NSString *) phone {
    
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@", phone]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl options:@{} completionHandler:nil];
    } else {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Llamadas no disponibles" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"Aceptar" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alert addAction:okButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)logout:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SESSION_TOKEN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)onBtnShareClick:(id)sender {

    User* user = [AppDelegate sharedInstance].user;
    
    NSString* textToShare = @"Take my Meisshi and i hope to serve you";
    NSString* sharedUrl   = [[AppDelegate sharedInstance].api serviceEndpoint:[NSString stringWithFormat:@"profile/%@", user.identifier]];
    
    NSArray *objectsToShare = @[textToShare, sharedUrl];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    
    UIView* view = sender;
    
    activityVC.popoverPresentationController.sourceView = view;
    activityVC.popoverPresentationController.sourceRect = view.bounds;
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (IBAction)onBtnCreateCardClick:(id)sender {
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController* vc     = [storyBoard instantiateViewControllerWithIdentifier:@"EditController"];
    
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscape;
}



-(void) didClickCard:(MeisshiCard *)card telephone:(NSString *)telephone {
    [self makeTelephoneCall:telephone];
}

-(void) didClickCard:(MeisshiCard *)card twitter:(NSString *)twitter {
    NSString* urlAction = nil;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]])
        urlAction = [NSString stringWithFormat:@"twitter://user?screen_name=%@", twitter];
    else
        urlAction = [NSString stringWithFormat:@"https://www.twitter.com/%@", twitter];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:urlAction]
                                       options: @{}
                             completionHandler: nil];
}

-(void) didClickCard:(MeisshiCard *)card facebook:(NSString *)facebook {
    NSString* urlAction = nil;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://profile"]])
        urlAction = [NSString stringWithFormat:@"fb://profile?id=%@", facebook];
    else
        urlAction = [NSString stringWithFormat: @"https://www.facebook.com/%@", facebook];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:urlAction]
                                       options: @{}
                             completionHandler: nil];
}

-(void) didClickCard:(MeisshiCard *)card website:(NSString *)website {
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:website]
                                       options: @{}
                             completionHandler: nil];
}

-(void) didClickCard:(MeisshiCard *)card address:(NSString *)address {
    address   = [address stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString* urlAction = [NSString stringWithFormat:@"http://maps.apple.com/?q=%@", address];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:urlAction]
                                       options: @{}
                             completionHandler: nil];
}

-(void) didClickCard:(MeisshiCard *)card email:(NSString *)email {
    if ([MFMailComposeViewController canSendMail])
    {
        _mailComposeController = [[MFMailComposeViewController alloc] init];
        [_mailComposeController setSubject:@"Sample Subject"];
        [_mailComposeController setMessageBody:@"Here is some main text in the email!" isHTML:NO];
        [_mailComposeController setToRecipients:@[email]];
        [_mailComposeController setMailComposeDelegate:self];
        
        [self presentViewController:_mailComposeController animated:YES completion:nil];
    }
    else
    {
        NSLog(@"This device cannot send email");
    }
}
@end
