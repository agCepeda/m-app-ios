//
//  User.h
//  Meishii
//
//  Created by Develop Mx on 29/08/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Review.h"
#import "Card.h"
#import "Profession.h"

@interface User : NSObject

@property (nonatomic, copy) NSString* identifier;
@property (nonatomic, copy) NSString* email;
@property (nonatomic, copy) NSString* workEmail;
@property (nonatomic, copy) NSString* showName;
@property (nonatomic, copy) NSString* firstName;
@property (nonatomic, copy) NSString* lastName;
@property (nonatomic, copy) NSString* bio;

@property (nonatomic, strong) Card* card;
@property (nonatomic, copy) NSString* profession;

@property (nonatomic, copy) NSString* telephone1;
@property (nonatomic, copy) NSString* telephone2;

@property (nonatomic, copy) NSString* street;
@property (nonatomic, copy) NSString* number;
@property (nonatomic, copy) NSString* neighborhood;
@property (nonatomic, copy) NSString* city;
@property (nonatomic, copy) NSString* zipCode;

@property (nonatomic, copy) NSString* website;
@property (nonatomic, copy) NSString* twitter;
@property (nonatomic, copy) NSString* facebook;
@property (nonatomic, copy) NSString* instagram;
@property (nonatomic, copy) NSURL* logo;

@property (nonatomic, copy) NSURL* qrImage;
@property (nonatomic, copy) NSURL* profilePicture;

@property (nonatomic, copy) NSNumber* distance;
@property (nonatomic, copy) NSNumber* followers;
@property (nonatomic, copy) NSNumber* following;

@property (nonatomic, assign) BOOL isContact;

@property (nonatomic, strong) NSData* logoData;
@property (nonatomic,strong) Review* review;

@property (nonatomic, assign) BOOL fliped;

- (id) initWithDictionary: (NSDictionary *) dictionary;
- (NSDictionary*) info;
-(NSMutableArray*) infoKeys;
- (NSString*) address;

@end
