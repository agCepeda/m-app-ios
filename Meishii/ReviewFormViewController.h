//
//  ReviewFormViewController.h
//  Meishii
//
//  Created by Develop Mx on 23/09/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HCSStarRatingView/HCSStarRatingView.h>
#import "User.h"

@interface ReviewFormViewController : UIViewController

@property (strong, nonatomic) User *user;
@property (weak, nonatomic) IBOutlet UITextView *tvComment;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *srScore;

@end
