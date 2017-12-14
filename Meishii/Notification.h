//
//  Notification.h
//  Meishii
//
//  Created by Develop Mx on 12/03/17.
//  Copyright © 2017 Develop Mx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Notification : NSObject

@property (strong, nonatomic) NSString* identifier;
@property (strong, nonatomic) NSString* type;
@property (strong, nonatomic) User* attachment;
@property (strong, nonatomic) NSString* date;

- (id) initWithDictionary: (NSDictionary *) dictionary;

@end
