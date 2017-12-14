//
//  Review.m
//  Meishii
//
//  Created by Develop Mx on 16/09/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import "Review.h"

@implementation Review{
    NSString* _identifier;
    NSString* _comment;
    NSInteger _score;
    NSString* _reviewerName;
}

-(id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        
        _identifier   = [dictionary objectForKey:@"id"];
        _comment      = [dictionary objectForKey:@"comment"];
        
        if ([dictionary objectForKey:@"score"] != [NSNull null])
            _score        = [[dictionary objectForKey:@"score"] integerValue];
        if ([dictionary objectForKey:@"reviewer"] != [NSNull null]){
            NSDictionary* reviewerDicto = [dictionary objectForKey:@"reviewer"];
            _reviewerName = [NSString stringWithFormat:@"%@ %@", [reviewerDicto objectForKey:@"name"], [reviewerDicto objectForKey:@"last_name"]];
        }
        
    }
    return self;
}

-(NSString *)identifier {
    if (![_identifier isEqual:[NSNull null]])
        return _identifier;
    return @"";
}

-(NSString *)comment {
    if (![_comment isEqual:[NSNull null]])
        return _comment;
    return @"";
}

-(NSInteger) score {
    return _score;
}

-(NSString *)reviewerName {
    if (![_reviewerName isEqual:[NSNull null]])
        return _reviewerName;
    return @"";
}

@end
