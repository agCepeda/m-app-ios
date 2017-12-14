//
//  MeisshiApi.h
//  Meishii
//
//  Created by Develop Mx on 07/03/17.
//  Copyright © 2017 Develop Mx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeisshiApi : NSObject

- (instancetype) initWithBaseUrl: (NSString *) baseUrl
                 andSessionToken: (NSString *) sessionToken;

- (NSString *) serviceEndpoint:(NSString *) service;

- (NSString*) urlImageQrByUserId: (NSString*) userId;

- (void) loginEmail: (NSString *) email
           password: (NSString *) password
           callback: (void (^)(NSDictionary* responseObject, NSError *error)) callback;

- (void) loginEmail: (NSString *) email
               name: (NSString *) name
           lastName: (NSString *) lastName
           callback: (void (^)(NSDictionary* responseObject, NSError *error)) callback;

- (void) signUpWithEmail: (NSString *) email
               name: (NSString *) name
           lastName: (NSString *) lastName
           password: (NSString *) password
           callback: (void (^)(NSDictionary* responseObject, NSError *error)) callback;


- (void) checkSession: (void (^)(NSDictionary* users, NSError *error)) callback;
- (void) updateDeviceToken: (NSString *) deviceToken
                  callback: (void (^)(NSDictionary* response, NSError *error)) callback;

- (void) setSessionToken: (NSString *) sessionToken;

- (void) getContacts: (void (^)(NSArray* users, NSError *error)) callback;
- (void) search: (NSString *) query
       callback: (void (^)(id, NSError *error)) callback;
- (void) search: (NSString *) query
           size: (NSInteger *) size
           page: (NSInteger *) page
       callback: (void (^)(id, NSError *error)) callback;

- (void) getUser: (NSString *) userId
    loadMyReview: (BOOL) loadMyReview
        callback: (void (^)(id responseObject, NSError *error)) callback;

- (void) addContact: (NSString *) userId
           callback: (void (^)(id responseObject, NSError *error)) callback;

- (void) removeContact: (NSString *) userId
              callback: (void (^)(id responseObject, NSError *error)) callback;

- (void) getFollowersOfUser: (NSString *) userId
                   callback: (void (^)(NSArray* users, NSError *error)) callback;
- (void) getFollowingByUser: (NSString *) userId
                   callback: (void (^)(NSArray* users, NSError *error)) callback;

- (void) getReviewsById: (NSString *) userId
               callback: (void (^)(NSDictionary* responseObject, NSError *error)) callback;

- (void) postReviewToUser: (NSString *) userId
                  comment: (NSString *) comment
                    score: (NSString *) score
                 callback: (void (^)(NSDictionary* responseObject, NSError *error)) callback;

- (void) getCards: (void (^)(NSArray* responseObject, NSError *error)) callback;
- (void) getProfessions: (void (^)(NSArray* responseObject, NSError *error)) callback;

- (void) updateUserWithData: (NSDictionary *) parameters
                       logo: (NSData *) logo
             profilePicture: (NSData *) profilePicture
                   callback: (void (^)(NSDictionary* responseObject, NSError *error)) callback;

- (void) pushNotificationsWithToken: (NSString *) token
                           callback: (void (^)(NSDictionary* responseObject, NSError *error)) callback;

- (void) getNotifications: (void (^)(NSDictionary* responseObject, NSError *error)) callback;

- (void) readNotification: (NSString *) notificationId
                 callback: (void (^)(NSDictionary* responseObject, NSError *error)) callback;
@end
