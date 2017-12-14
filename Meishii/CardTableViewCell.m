//
//  CardTableViewCell.m
//  Meishii
//
//  Created by Develop Mx on 19/08/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import "CardTableViewCell.h"
#import "AppDelegate.h"

@implementation CardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)flip:(id)sender {
    /*    [UIView transitionWithView:_testView
     duration:1
     options:UIViewAnimationOptionTransitionFlipFromLeft
     animations:^{
     
     
     } completion:nil];*/
    [UIView transitionWithView:_containerView
                      duration:1.0
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        BOOL h = _qrView.hidden;
                        _qrView.hidden = _cardView.hidden;
                        _cardView.hidden = h;
                    } completion:^(BOOL finished) {
                        if (finished) {
                            _user.fliped = !_cardView.hidden;
                        }
                    }];
}

- (void) didTapTelephoneLabel: (UITapGestureRecognizer *)tapGesture {
    UILabel* lblTelephone = (UILabel *) tapGesture.view;
    [self makeTelephoneCall:lblTelephone.text];
}


-(void)didTapShowNameLabel: (UITapGestureRecognizer *)tapGesture {
    
}

-(void)didTapAddressLabel: (UITapGestureRecognizer *)tapGesture {
    NSString* address   = [_user.address stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString* urlAction = [NSString stringWithFormat:@"http://maps.apple.com/?q=%@", address];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlAction] options:@{} completionHandler:nil];
}

-(void)didTapFacebookLabel: (UITapGestureRecognizer *)tapGesture {
    NSString* urlAction = nil;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://profile"]])
        urlAction = [NSString stringWithFormat:@"fb://profile?id=%@", _user.facebook];
    else
        urlAction = [NSString stringWithFormat:@"https://www.facebook.com/%@", _user.facebook];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlAction] options:@{} completionHandler:nil];
}

-(void)didTapTwitterLabel: (UITapGestureRecognizer *)tapGesture {
    NSString* urlAction = nil;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]])
        urlAction = [NSString stringWithFormat:@"twitter://user?screen_name=%@", _user.twitter];
    else
        urlAction = [NSString stringWithFormat:@"https://www.twitter.com/%@", _user.twitter];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlAction] options:@{} completionHandler:nil];
}

-(void)didTapWebsiteLabel: (UITapGestureRecognizer *)tapGesture {
    NSString* urlAction = _user.website;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlAction] options:@{} completionHandler:nil];
}

-(void)didTapEmailLabel: (UITapGestureRecognizer *)tapGesture {
    if ([MFMailComposeViewController canSendMail])
    {
        _mailComposeController = [[MFMailComposeViewController alloc] init];
        [_mailComposeController setSubject:@"Sample Subject"];
        [_mailComposeController setMessageBody:@"Here is some main text in the email!" isHTML:NO];
        [_mailComposeController setToRecipients:@[_user.workEmail]];
        [_mailComposeController setMailComposeDelegate:self];
        
        [self.window.rootViewController presentViewController:_mailComposeController animated:YES completion:nil];
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
        [[UIApplication sharedApplication] openURL:phoneUrl  options:@{} completionHandler:nil];
    } else {/*
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Llamadas no disponibles" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"Aceptar"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       [self dismissViewControllerAnimated:YES completion:nil];
                                   }];
        [alert addAction:okButton];
        
        [self presentViewController:alert animated:YES completion:nil]; */
    }
    
}

@end
