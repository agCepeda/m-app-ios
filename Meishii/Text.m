//
//  Text.m
//  Meishii
//
//  Created by Develop Mx on 19/09/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import "Text.h"

@implementation Text

+(BOOL)isEmail:(NSString *)email {
    NSString *emailRegex   = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(BOOL)isFacebook:(NSString *)facebook {
    NSString *facebookRegex   = @"[A-Za-z]([.A-Za-z0-9]+)[A-Za-z]";
    NSPredicate *facebookTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", facebookRegex];
    if ([facebookTest evaluateWithObject:facebook])
    {
        int numPoints = [[facebook componentsSeparatedByString:@"."] count] - 1;
        return (facebook.length - numPoints) >= 5;
    }
    return NO;
}

+(BOOL)isTwitter:(NSString *)twitter {
    NSString *twitterRegex   = @"@([_A-Za-z0-9-]+)";
    NSPredicate *twitterTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", twitterRegex];
    return [twitterTest evaluateWithObject:twitter];
}

+(BOOL)isWebsite:(NSString *)website {
    NSString *websiteRegex   = @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *websiteTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", websiteRegex];
    return [websiteTest evaluateWithObject:website];
}

+(BOOL)isNumber:(NSString *)number {
    NSString *numRegex   = @"^[0-9]+$";
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numRegex];
    return [numTest evaluateWithObject:number];
}
@end
