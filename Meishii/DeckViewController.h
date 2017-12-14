//
//  DeckViewController.h
//  Meishii
//
//  Created by Develop Mx on 19/08/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "MeisshiCard.h"

@interface DeckViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate, MeisshiCardDelegate>
{
    NSMutableDictionary* contactSections;
    NSArray* contactSectionTitles;
}

@property (weak, nonatomic) IBOutlet UITableView *tableTarjetas;
@property (weak, nonatomic) IBOutlet UIView *viewPlaceHolder;

@property (nonatomic, strong) MFMailComposeViewController* mailComposeController;

@end
