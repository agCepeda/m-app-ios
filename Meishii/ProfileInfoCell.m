//
//  ProfileInfoCell.m
//  Meishii
//
//  Created by Develop Mx on 28/09/17.
//  Copyright © 2017 Develop Mx. All rights reserved.
//

#import "ProfileInfoCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ProfileInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [[self.btnEdit layer] setCornerRadius:13];
    
    /*
     UIFont* font = [UIFont fontWithName:@"FontAwesome" size:22];
    [self.btnTwitter.titleLabel setFont:font];
    [self.btnFacebook.titleLabel setFont:font];
    [self.btnInstagram.titleLabel setFont:font];
    
    [self.btnFacebook setTitle:[NSString stringWithFormat:@"%C", 0xf082] forState:UIControlStateNormal];
    [self.btnTwitter setTitle: [NSString stringWithFormat:@"%C", 0xf081] forState:UIControlStateNormal];
    [self.btnInstagram setTitle: [NSString stringWithFormat:@"%C", 0xf16d] forState:UIControlStateNormal];
    */
    [self.lblStatus sizeToFit];
    
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapFollowed:)];
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapFollowers:)];
    
    UITapGestureRecognizer *tapGestureTelephone1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapTelephone1:)];
    UITapGestureRecognizer *tapGestureEmail = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapEmail:)];
    UITapGestureRecognizer *tapGestureAddress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAddress:)];
    UITapGestureRecognizer *tapGestureWebsite = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapWebsite:)];
    
    [_lblFollowers setUserInteractionEnabled:YES];
    [_lblFollowed setUserInteractionEnabled:YES];
    
    [_lblFollowed addGestureRecognizer:tapGesture1];
    [_lblFollowers addGestureRecognizer:tapGesture2];
    
    [_lblIconTelephone1 setText:[NSString stringWithFormat:@"%C", 0xf10b]];
    [_lblIconEmail setText:[NSString stringWithFormat:@"%C", 0xf003]];
    [_lblIconAddress setText:[NSString stringWithFormat:@"%C", 0xf041]];
    [_lblIconWebsite setText:[NSString stringWithFormat:@"%C", 0xf0ac]];
    
    _imvProfile.layer.cornerRadius = 18;
    _imvProfile.layer.masksToBounds = YES;
    
    [_viewTelephone1 setUserInteractionEnabled:YES];
    [_viewEmail setUserInteractionEnabled:YES];
    [_viewAddress setUserInteractionEnabled:YES];
    [_viewWebsite setUserInteractionEnabled:YES];
    
    [_viewTelephone1 addGestureRecognizer:tapGestureTelephone1];
    [_viewEmail addGestureRecognizer:tapGestureEmail];
    [_viewAddress addGestureRecognizer:tapGestureAddress];
    [_viewWebsite addGestureRecognizer:tapGestureWebsite];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onBtnInstagramClick:(id)sender {
    [self.delegate didClickInstagram];
}

- (IBAction)onBtnTwitterClick:(id)sender {
    [self.delegate didClickTwitter];
}

- (IBAction)onBtnFacebookClick:(id)sender {
    [self.delegate didClickFacebook];
}

- (IBAction)onBtnEditClick:(id)sender {
    [self.delegate didClickAction];
}

- (void) didTapFollowed:(UITapGestureRecognizer *)tapGesture {
    [self.delegate didClickFollowed];
}

- (void) didTapFollowers: (UITapGestureRecognizer *)tapGesture {
    [self.delegate didClickFollowers];
}

- (void) didTapTelephone1: (UITapGestureRecognizer *)tapGesture {
    [self.delegate didClickTelephone];
}

- (void) didTapEmail: (UITapGestureRecognizer *)tapGesture {
    [self.delegate didClickEmail];
}

- (void) didTapAddress: (UITapGestureRecognizer *)tapGesture {
    [self.delegate didClickAddress];
}

- (void) didTapWebsite: (UITapGestureRecognizer *)tapGesture {
    [self.delegate didClickWebsite];
}

- (void) loadUser: (User *) user {
    [self.card loadCard:user.card withUser:user];
    
    [self.lblName setText: user.firstName];
    //[self.lblProfession setText: user.profession.name];
    [self.imvProfile sd_setImageWithURL: user.profilePicture];
    
    [self.lblTelephone1 setText: user.telephone1];
    [self.lblWebsite setText: user.website];
    [self.lblEmail setText: user.email];
    [self.lblAddress setText: user.address];
    [self.lblStatus setText: user.bio];
    
    [self.lblFollowed setText: [NSString stringWithFormat:@"%@ Followed", user.following]];
    [self.lblFollowers setText: [NSString stringWithFormat:@"%@ Followers", user.followers]];
}

-(void)setTitleAction:(NSString *)titleAction {
    [_btnEdit setTitle:titleAction forState:UIControlStateNormal];
}

@end
