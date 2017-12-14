//
//  MeisshiCard.m
//  Meishii
//
//  Created by Develop Mx on 21/01/17.
//  Copyright © 2017 Develop Mx. All rights reserved.
//

#import "MeisshiCard.h"
#import "AppDelegate.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface MeisshiCard() {
    CGSize _intrinsicContentSize;
    BOOL isFlipping;
};
@end

@implementation MeisshiCard

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //[self xibSetup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
        
        self.view.frame = self.bounds;
        
        [self addSubview:self.view];
        
        _intrinsicContentSize = self.bounds.size;
        
    }
    return self;
}

-(CGSize)intrinsicContentSize {
    return _intrinsicContentSize;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    _viewContainer = [self viewWithTag:1000];
    _viewQr = [self viewWithTag:100];
    _viewCard = [self viewWithTag:200];
    
    _imgViewCard = [self viewWithTag:201];
    _imgViewQr = [self viewWithTag:101];
    _imgViewLogo = [self viewWithTag:202];
    
    _lblShowName = [self viewWithTag:203];
    _lblProfession = [self viewWithTag:204];
    _lblCompany = [self viewWithTag:205];
    _lblAddress = [self viewWithTag:206];
    _lblTwitter = [self viewWithTag:207];
    _lblFacebook = [self viewWithTag:208];
    _lblWebsite = [self viewWithTag:209];
    _lblWorkEmail = [self viewWithTag:210];
    _lblTelephone1 = [self viewWithTag:211];
    _lblTelephone2 = [self viewWithTag:212];
    
    _viewQr.layer.shadowOffset  = CGSizeMake(5, 5);
    _viewQr.layer.shadowRadius  = 5.0;
    _viewQr.layer.shadowOpacity = 0.5;
    
    _viewQr.layer.masksToBounds = NO;
    
    _viewCard.layer.shadowOffset  = CGSizeMake(5, 5);
    _viewCard.layer.shadowRadius  = 5.0;
    _viewCard.layer.shadowOpacity = 0.6;
    
    _viewCard.layer.masksToBounds = NO;
    /*
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapTelephoneLabel:)];
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapTelephoneLabel:)];
    UITapGestureRecognizer *tapGesture3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapLogoImageView:)];
    UITapGestureRecognizer *tapGesture4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapShowNameLabel:)];
    UITapGestureRecognizer *tapGesture5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAddressLabel:)];
    UITapGestureRecognizer *tapGesture6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapFacebookLabel:)];
    UITapGestureRecognizer *tapGesture7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapTwitterLabel:)];
    UITapGestureRecognizer *tapGesture8 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapWebsiteLabel:)];
    UITapGestureRecognizer *tapGesture9 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapEmailLabel:)];
    
    [_imgViewLogo setUserInteractionEnabled:YES];
    [_lblShowName setUserInteractionEnabled:YES];
    [_lblAddress setUserInteractionEnabled:YES];
    [_lblTelephone1 setUserInteractionEnabled:YES];
    [_lblTelephone2 setUserInteractionEnabled:YES];
    [_lblWorkEmail setUserInteractionEnabled:YES];
    [_lblWebsite setUserInteractionEnabled:YES];
    [_lblTwitter setUserInteractionEnabled:YES];
    [_lblFacebook setUserInteractionEnabled:YES];
    
    [_lblTelephone1 addGestureRecognizer:tapGesture1];
    [_lblTelephone2 addGestureRecognizer:tapGesture2];
    [_imgViewLogo addGestureRecognizer:tapGesture3];
    [_lblShowName addGestureRecognizer:tapGesture4];
    [_lblAddress addGestureRecognizer:tapGesture5];
    [_lblFacebook addGestureRecognizer:tapGesture6];
    [_lblTwitter addGestureRecognizer:tapGesture7];
    [_lblWebsite addGestureRecognizer:tapGesture8];
    [_lblWorkEmail addGestureRecognizer:tapGesture9];
     */
    
}

- (IBAction)onBtnFlipClick:(id)sender {
    if (!isFlipping) {
        isFlipping = YES;
        [UIView transitionWithView:self.viewContainer
                      duration:1.0
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        BOOL h = self.viewQr.hidden;
                        self.viewQr.hidden = self.viewCard.hidden;
                        self.viewCard.hidden = h;
                    } completion:^(BOOL finished) {
                        if (finished) {
                            isFlipping = NO;
                        }
                    }];
    }
}

- (void) loadCard:(Card *)card withUser:(User *)user {
    
    _user = user;

    [_imgViewCard sd_setImageWithURL: card.path];
    [_imgViewQr sd_setImageWithURL: user.qrImage];

    
    [self fillLabel:_lblShowName withField:card.showName andText:user.showName];
    [self fillLabel:_lblProfession withField:card.profession andText:user.profession];
    [self fillLabel:_lblTelephone1 withField:card.telephone1 andText:user.telephone1];
    [self fillLabel:_lblTelephone2 withField:card.telephone2 andText:user.telephone2];
    [self fillLabel:_lblAddress withField:card.address andText:user.address];
    [self fillLabel:_lblWebsite withField:card.website andText:user.website];
    [self fillLabel:_lblFacebook withField:card.facebook andText:user.facebook];
    [self fillLabel:_lblTwitter withField:card.twitter andText:user.twitter];
    [self fillLabel:_lblWorkEmail withField:card.workEmail andText:user.workEmail];
    
    [_imgViewLogo sd_setImageWithURL:user.logo];

    if (card.logo) {
        [_imgViewLogo setHidden:NO];
        [_imgViewLogo setFrame:card.logo.frame];
    } else {
        [_imgViewLogo setHidden:YES];
    }
    
}

- (void) fillLabel:(UILabel*) label withField:(Field *) field andText:(NSString *) text {
    if (field) {
        [label setHidden:NO];
        [label setFrame:field.frame];
        [label setTextColor:field.color];
        [label setFont:field.font];
        [label setText:text];
        
        if ([ALIGN_CENTER isEqualToString:field.align]) {
            [label setTextAlignment:NSTextAlignmentCenter];
        } else if ([ALIGN_RIGHT isEqualToString:field.align]) {
            [label setTextAlignment:NSTextAlignmentRight];
        } else {
            [label setTextAlignment:NSTextAlignmentLeft];
        }
        
    } else {
        [label setHidden:YES];
    }
}



-(void) didTapTelephoneLabel: (UITapGestureRecognizer *)tapGesture {
    UILabel* lblTelephone = (UILabel *) tapGesture.view;
    NSString *originalString = lblTelephone.text;
    
    
    NSMutableCharacterSet *nonNumberCharacterSet = [NSMutableCharacterSet decimalDigitCharacterSet];
    [nonNumberCharacterSet invert];

    NSString* numberString = [[originalString componentsSeparatedByCharactersInSet:nonNumberCharacterSet] componentsJoinedByString:@""];
    [self.delegate didClickCard:self telephone:numberString];
}

-(void)didTapShowNameLabel: (UITapGestureRecognizer *)tapGesture {
}


-(void)didTapEmailLabel: (UITapGestureRecognizer *)tapGesture {
    [self.delegate didClickCard:self email:_user.workEmail];
}

-(void)didTapAddressLabel: (UITapGestureRecognizer *)tapGesture {
    NSString* address   = [_user.address stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self.delegate didClickCard:self address:address];
}

-(void)didTapFacebookLabel: (UITapGestureRecognizer *)tapGesture {
    [self.delegate didClickCard:self facebook:_user.facebook];
}

-(void)didTapTwitterLabel: (UITapGestureRecognizer *)tapGesture {
    [self.delegate didClickCard:self twitter:_user.twitter];
}

-(void)didTapWebsiteLabel: (UITapGestureRecognizer *)tapGesture {
    [self.delegate didClickCard:self website:_user.website];
}


@end
