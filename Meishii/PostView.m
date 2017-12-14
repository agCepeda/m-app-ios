//
//  PostView.m
//  Meishii
//
//  Created by Develop Mx on 22/08/17.
//  Copyright © 2017 Develop Mx. All rights reserved.
//

#import "PostView.h"

@implementation PostView

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

-(void) initialize {
    [[NSBundle mainBundle] loadNibNamed: NSStringFromClass([self class])
                                  owner: self
                                options: nil];
    
    self.view.frame = self.bounds;
    
    [self addSubview:self.view];
}

-(void)awakeFromNib {
    [super awakeFromNib];
    UIFont* font = [UIFont fontWithName:@"FontAwesome" size:12];
    
    [self.btnComment.titleLabel setFont:font];
    [self.btnComment.titleLabel setText:@"\uf013"];
}

@end
