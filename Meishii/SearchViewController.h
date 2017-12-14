//
//  SearchViewController.h
//  Meishii
//
//  Created by Develop Mx on 19/08/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "MeisshiCard.h"

@interface SearchViewController : UIViewController<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate,MFMailComposeViewControllerDelegate, MeisshiCardDelegate>
{
    NSMutableArray* listContacts;
}
@property (weak, nonatomic) IBOutlet UITableView *tableCards;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITextField *tfSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
- (IBAction)onBtnSearchClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewPlaceHolder;

@property (nonatomic, strong) MFMailComposeViewController* mailComposeController;
@end
