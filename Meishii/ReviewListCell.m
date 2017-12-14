//
//  ReviewListCell.m
//  Meishii
//
//  Created by Develop Mx on 25/09/17.
//  Copyright © 2017 Develop Mx. All rights reserved.
//

#import "ReviewListCell.h"

@implementation ReviewListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.estimatedRowHeight = 66;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void) loadUser: (User *) user {
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* reviewIdentifier = @"ReviewCell";
    // static NSString* reviewFormIdentifier = @"ReviewFormCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reviewIdentifier];
    
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                      reuseIdentifier: reviewIdentifier];
    }
    UILabel* lblComment = (UILabel *) [cell viewWithTag:20];
    [lblComment setNumberOfLines:0];
    
    return cell;
}

@end
