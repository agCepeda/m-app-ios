//
//  Field.h
//  Meishii
//
//  Created by Develop Mx on 16/11/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define ALIGN_CENTER @"center"
#define ALIGN_LEFT @"left"
#define ALIGN_RIGHT @"right"

#define STYLE_REGULAR @"regular"
#define STYLE_BOLD @"bold"

@interface Field : NSObject

@property(nonatomic, copy) NSString* name;
@property(nonatomic, assign) CGRect frame;
@property(nonatomic, copy) UIColor* color;
@property(nonatomic, copy) UIFont* font;
@property(nonatomic, copy) NSString* align;
@property(nonatomic, copy) NSString* style;

- (id) initWithDictionary: (NSDictionary *) dictionary;

@end
