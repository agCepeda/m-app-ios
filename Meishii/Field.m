//
//  Field.m
//  Meishii
//
//  Created by Develop Mx on 16/11/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import "Field.h"
#import "UIColor+Hex.h"

@implementation Field {
    NSString* _name;
    CGRect _frame;
    UIColor* _color;
    UIFont* _font;
    NSString* _align;
    NSString* _style;
}


- (id) initWithDictionary: (NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        _name = [dictionary objectForKey:@"name"];
        NSInteger x = [[dictionary objectForKey:@"x"] integerValue];
        NSInteger y = [[dictionary objectForKey:@"y"] integerValue];
        NSInteger width = [[dictionary objectForKey:@"width"] integerValue];
        NSInteger height = [[dictionary objectForKey:@"height"] integerValue];
        
        NSInteger fontSize = [[dictionary objectForKey:@"font_size"] integerValue];
        NSString* hexColor = [dictionary objectForKey:@"color"];
 
        NSString* style = [dictionary objectForKey:@"style"];
        if ([STYLE_BOLD isEqualToString:style]) {
            _font  = [UIFont fontWithName:@"Arial-BoldMT" size:fontSize];
        } else {
            _font  = [UIFont fontWithName:@"Arial" size:fontSize];
        }
        _color = [UIColor colorWithCSS:hexColor];
        _frame = CGRectMake(x, y, width, height);
        _align = [dictionary objectForKey:@"align"];
        
    }
    return self;
}

@end
