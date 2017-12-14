//
//  Session.m
//  Meishii
//
//  Created by Develop Mx on 03/12/17.
//  Copyright © 2017 Develop Mx. All rights reserved.
//

#import "Session.h"

@interface User() {
    NSString* _token;
    User* _user;
}
@end

@implementation Session

- (id) initWithDictionary: (NSDictionary *) dictionary {
    self = [super init];
    if (self) {
        _token = [dictionary valueForKey:@"token"];
        _user = [[User alloc] initWithDictionary:[dictionary objectForKey:@"user"]];
    }
    return self;
}

@end
