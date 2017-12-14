//
//  MeisshiUser.m
//  Meishii
//
//  Created by Develop Mx on 21/08/17.
//  Copyright © 2017 Develop Mx. All rights reserved.
//

#import "MeisshiUser.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MeisshiUser

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

-(instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    self.imvProfile.layer.cornerRadius = 18;
    self.imvProfile.layer.masksToBounds = YES;
}

-(void) initialize {
    [[NSBundle mainBundle] loadNibNamed: NSStringFromClass([self class])
                                  owner: self
                                options: nil];
    
    self.view.frame = self.bounds;
    
    [self addSubview:self.view];
}

-(void) loadCard:(Card *)card withUser:(User *)user {
    [self.meisshiCard loadCard:card withUser:user];
    
    [self.lblName setText:user.firstName];
    [self.lblProfession setText:user.profession];
    
    [self.imvProfile sd_setImageWithURL:user.profilePicture];
}

-(void)setDelegate:(id<MeisshiCardDelegate>)delegate {
    self.meisshiCard.delegate = delegate;
}

@end
