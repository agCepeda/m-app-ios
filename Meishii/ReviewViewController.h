//
//  ReviewViewController.h
//  Meishii
//
//  Created by Develop Mx on 20/08/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ReviewViewController : UITableViewController {
    NSMutableArray* listReviews;
}

@property (nonatomic, strong) User* user;
@property (nonatomic, assign) BOOL isOwnProfile;

-(void) loadReviews;

@end
