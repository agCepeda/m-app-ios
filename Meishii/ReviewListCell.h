//
//  ReviewListCell.h
//  Meishii
//
//  Created by Develop Mx on 25/09/17.
//  Copyright © 2017 Develop Mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ReviewListCell : UITableViewCell<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void) loadUser: (User *) user;

@end
