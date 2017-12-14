//
//  Profession.m
//  Meishii
//
//  Created by Develop Mx on 27/09/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import "Profession.h"

@implementation Profession

-(id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _identifier = [dictionary objectForKey:@"id"];
        _name       = [dictionary objectForKey:@"name"];
    }
    return self;
}

@end
