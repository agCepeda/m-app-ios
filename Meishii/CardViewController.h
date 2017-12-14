//
//  CardViewController.h
//  Meishii
//
//  Created by Develop Mx on 19/08/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "MeisshiCard.h"
#import "MeisshiUser.h"

@interface CardViewController : UIViewController<MFMailComposeViewControllerDelegate, MeisshiCardDelegate>
- (IBAction)logout:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnShare;
- (IBAction)onBtnShareClick:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *containerCard;
@property (weak, nonatomic) IBOutlet UIView *containerCreate;
- (IBAction)onBtnCreateCardClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCreateCard;

@property (nonatomic, strong) MFMailComposeViewController* mailComposeController;
@property (weak, nonatomic) IBOutlet MeisshiCard *card;
@property (weak, nonatomic) IBOutlet MeisshiUser *meisshiUser;


@end
