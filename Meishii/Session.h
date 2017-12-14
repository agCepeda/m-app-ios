//
//  Session.h
//  Meishii
//
//  Created by Develop Mx on 03/12/17.
//  Copyright © 2017 Develop Mx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Session : NSObject

@property (nonatomic, copy) NSString* token;
@property (nonatomic, copy) User* user;


- (id) initWithDictionary: (NSDictionary *) dictionary;

@end
