
//
//  Notification.m
//  Meishii
//
//  Created by Develop Mx on 12/03/17.
//  Copyright © 2017 Develop Mx. All rights reserved.
//

#import "Notification.h"

@implementation Notification {
    NSString* _identifier;
    NSString* _type;
    User* _attachment;
    NSString* _date;
}

- (id) initWithDictionary: (NSDictionary *) dictionary {
    self = [super init];
    if (self) {
        _identifier = [dictionary objectForKey:@"identifier"];
        _type = [dictionary objectForKey:@"type"];
        _attachment = [[User alloc] initWithDictionary:[dictionary objectForKey:@"attachment"]];
        _date = [dictionary objectForKey:@"created_at"];
    }
    return self;
}

- (void) setIdentifier:(NSString *)identifier {
    _identifier = identifier;
}

- (void) setType:(NSString *)type {
    _type = type;
}
- (void) setDate:(NSString *)date {
    _date = date;
}
-(void) setAttachment:(User *)attachment {
    _attachment = attachment;
}

- (NSString *)identifier {
    return _identifier;
}

- (NSString *)type {
    return _type;
}

- (User *)attachment {
    return _attachment;
}
- (NSString *)date {
    return _date;
}

@end
