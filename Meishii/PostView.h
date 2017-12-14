//
//  PostView.h
//  Meishii
//
//  Created by Develop Mx on 22/08/17.
//  Copyright © 2017 Develop Mx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostView : UIView

@property (nonatomic, weak) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *imvProfilePhoto;
@property (weak, nonatomic) IBOutlet UILabel *lblShowName;
@property (weak, nonatomic) IBOutlet UILabel *lblProfession;
@property (weak, nonatomic) IBOutlet UIButton *btnComment;
@property (weak, nonatomic) IBOutlet UIButton *btnLike;

@end
