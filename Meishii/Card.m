//
//  Card.m
//  Meishii
//
//  Created by Develop Mx on 27/09/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import "Card.h"

@implementation Card {
    NSString* _identifier;
    NSURL* _path;
}

-(id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _identifier = [dictionary objectForKey:@"id"];
        if([dictionary objectForKey:@"path"] && [dictionary objectForKey:@"path"] != [NSNull null])
            _path = [NSURL URLWithString:[dictionary objectForKey:@"path"]];
        if([dictionary objectForKey:@"fields"] && [dictionary objectForKey:@"fields"] != [NSNull null]) {
            NSArray* fields = [dictionary objectForKey:@"fields"];
            for (NSDictionary* f in fields) {
                Field* field = [[Field alloc] initWithDictionary:f];
                if ([field.name isEqualToString:@"show_name"])
                    _showName = field;
                if ([field.name isEqualToString:@"profession"])
                    _profession = field;
                if ([field.name isEqualToString:@"telephone1"])
                    _telephone1 = field;
                if ([field.name isEqualToString:@"telephone2"])
                    _telephone2 = field;
                
                if ([field.name isEqualToString:@"address"])
                    _address = field;
                
                if ([field.name isEqualToString:@"company"])
                    _company = field;
                
                if ([field.name isEqualToString:@"website"])
                    _website = field;
                if ([field.name isEqualToString:@"facebook"])
                    _facebook = field;
                if ([field.name isEqualToString:@"twitter"])
                    _twitter = field;
                
                if ([field.name isEqualToString:@"logo"])
                    _logo = field;
                
                if ([field.name isEqualToString:@"work_email"])
                    _workEmail = field;

            }
        }
    }
    return self;
}

-(NSString *)identifier {
    if ([_identifier isEqual:[NSNull null]])
        return @"";
    return _identifier;
}

-(NSURL *) path {
    return _path;
}



@end
