//
//  Card.h
//  Meishii
//
//  Created by Develop Mx on 27/09/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Field.h"

@interface Card : NSObject

@property (nonatomic, copy) NSString* identifier;
@property (nonatomic, copy) NSURL* path;

@property (nonatomic, strong) Field* showName;
@property (nonatomic, strong) Field* profession;
@property (nonatomic, strong) Field* telephone1;
@property (nonatomic, strong) Field* telephone2;
@property (nonatomic, strong) Field* address;
@property (nonatomic, strong) Field* twitter;
@property (nonatomic, strong) Field* facebook;
@property (nonatomic, strong) Field* website;
@property (nonatomic, strong) Field* company;
@property (nonatomic, strong) Field* workEmail;
@property (nonatomic, strong) Field* logo;

- (id) initWithDictionary: (NSDictionary *) dictionary;

@end
