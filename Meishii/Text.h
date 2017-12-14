//
//  Text.h
//  Meishii
//
//  Created by Develop Mx on 19/09/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Text : NSObject

+(BOOL) isEmail:(NSString *) email;
+(BOOL) isFacebook:(NSString *)facebook;
+(BOOL) isTwitter:(NSString *)twitter;
+(BOOL) isWebsite:(NSString *)website;
+(BOOL) isNumber:(NSString *)number;

@end
