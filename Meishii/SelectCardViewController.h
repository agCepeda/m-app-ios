//
//  SelectCardViewController.h
//  Meishii
//
//  Created by Develop Mx on 28/08/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileViewController.h"
#import "EditProfileViewController.h"
#import "User.h"
#import "Profession.h"

@interface SelectCardViewController : UITableViewController
{
    NSMutableArray *listCards;
    Card* selectedCard;
    Profession* profession;
}

@property (nonatomic, strong) UIImage* imageLogo;
@property (nonatomic, strong) NSMutableDictionary* parameters;
@property (nonatomic, strong) User* user;
@property (nonatomic, strong) ProfileViewController* profileViewController;

@end
