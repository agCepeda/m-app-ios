//
//  Profession.h
//  Meishii
//
//  Created by Develop Mx on 27/09/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Profession : NSObject

@property (nonatomic, copy) NSString* identifier;
@property (nonatomic, copy) NSString* name;

- (id) initWithDictionary: (NSDictionary *) dictionary;

@end
