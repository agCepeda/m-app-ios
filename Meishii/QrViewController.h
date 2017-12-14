//
//  QrViewController.h
//  Meishii
//
//  Created by Develop Mx on 19/08/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTBBarcodeScanner.h"

@interface QrViewController : UIViewController

@property (strong, nonatomic) MTBBarcodeScanner* scanner;
@property (nonatomic, assign) BOOL isScanning;
@property (weak, nonatomic) IBOutlet UIView *outputView;

//-(void) update;

@end
