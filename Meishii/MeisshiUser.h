//
//  MeisshiUser.h
//  Meishii
//
//  Created by Develop Mx on 21/08/17.
//  Copyright © 2017 Develop Mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"
#import "User.h"
#import "MeisshiCard.h"

@protocol MeisshiCardDelegate;

@interface MeisshiUser : UIView

@property (nonatomic, weak) id<MeisshiCardDelegate> delegate;

@property (nonatomic, weak) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet MeisshiCard *meisshiCard;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblProfession;
@property (weak, nonatomic) IBOutlet UIImageView *imvProfile;

- (void) loadCard:(Card *)card withUser:(User *) user;

@end
