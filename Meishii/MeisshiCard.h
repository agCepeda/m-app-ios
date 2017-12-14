//
//  MeisshiCard.h
//  Meishii
//
//  Created by Develop Mx on 21/01/17.
//  Copyright © 2017 Develop Mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"
#import "User.h"

@protocol MeisshiCardDelegate;

@interface MeisshiCard : UIView

@property (strong, nonatomic) User* user;
@property (nonatomic, weak) id<MeisshiCardDelegate> delegate;

@property (nonatomic, weak) IBOutlet UIView *view;
@property (weak, nonatomic) UIView *viewCard;
@property (weak, nonatomic) UIView *viewQr;
@property (weak, nonatomic) UIView *viewContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintCardHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintCardWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintButtonMarginTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintButtonMarginRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintFlipButtonHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintFlipButtonWidth;


@property (weak, nonatomic) UIImageView *imgViewCard;
@property (weak, nonatomic) UIImageView *imgViewLogo;
@property (weak, nonatomic) UIImageView *imgViewQr;

@property (weak, nonatomic) UILabel *lblShowName;
@property (weak, nonatomic) UILabel *lblProfession;
@property (weak, nonatomic) UILabel *lblWebsite;
@property (weak, nonatomic) UILabel *lblTwitter;
@property (weak, nonatomic) UILabel *lblFacebook;
@property (weak, nonatomic) UILabel *lblCompany;
@property (weak, nonatomic) UILabel *lblWorkEmail;
@property (weak, nonatomic) UILabel *lblAddress;
@property (weak, nonatomic) UILabel *lblTelephone1;
@property (weak, nonatomic) UILabel *lblTelephone2;
@property (weak, nonatomic) IBOutlet UIButton *btnFlip;


- (instancetype) initWithFrame:(CGRect)frame;
- (instancetype) initWithCoder:(NSCoder *) aDecoder;

- (CGSize) intrinsicContentSize;

- (IBAction) onBtnFlipClick:(id)sender;

- (void) loadCard:(Card *)card withUser:(User *) user;

@end

@protocol MeisshiCardDelegate <NSObject>
@optional
- (void)didClickCard: (MeisshiCard *) card telephone: (NSString *) telephone;
- (void)didClickCard: (MeisshiCard *) card website: (NSString *) website;
- (void)didClickCard: (MeisshiCard *) card facebook: (NSString *) facebook;
- (void)didClickCard: (MeisshiCard *) card twitter: (NSString *) twitter;
- (void)didClickCard: (MeisshiCard *) card address: (NSString *) address;
- (void)didClickCard: (MeisshiCard *) card email: (NSString *) email;
@end
