//
//  MeisshiApi.m
//  Meishii
//
//  Created by Develop Mx on 07/03/17.
//  Copyright © 2017 Develop Mx. All rights reserved.
//

#import "MeisshiApi.h"
#import "AFURLSessionManager.h"

@interface MeisshiApi() {
    NSString* _baseUrl;
    NSString* _sessionToken;
    AFURLSessionManager* _manager;
}
@end

@implementation MeisshiApi

- (instancetype) initWithBaseUrl: (NSString *) baseUrl andSessionToken: (NSString *) sessionToken {
    self = [super init];
    if (self) {
        _baseUrl = baseUrl;
        _sessionToken = sessionToken;
        [self rebuildClient];
    }
    return self;
}

- (void) setSessionToken:(NSString *)sessionToken {
    _sessionToken = sessionToken;
    [self rebuildClient];
}

- (NSString *) serviceEndpoint:(NSString *) service {
    NSString* url = [NSString stringWithFormat:@"%@%@", _baseUrl, service];
    NSLog(@"Endpoint: %@", url);
    return url;
}


- (NSString*) urlImageQrByUserId: (NSString*) userId {
    return [self serviceEndpoint:[NSString stringWithFormat:@"user/%@/qr", userId]];
}


- (void) loginEmail: (NSString *) email
           password: (NSString *) password
           callback: (void (^)(NSDictionary* users, NSError *error)) callback {
    NSMutableURLRequest* request = [[AFHTTPRequestSerializer serializer]
                                    requestWithMethod: @"POST"
                                            URLString: [self serviceEndpoint:@"auth/login"]
                                           parameters: @{ @"username": email, @"password" : password }
                                                error: nil];
    NSURLSessionDataTask* dataTask = [_manager
                                      dataTaskWithRequest: request
                                        completionHandler: ^(
                                                             NSURLResponse * _Nonnull response,
                                                             id  _Nullable responseObject,
                                                             NSError * _Nullable error) {
        callback(responseObject, error);
    }];
    [dataTask resume];
}

- (void) loginEmail: (NSString *) email
               name: (NSString *) name
           lastName: (NSString *) lastName
           callback: (void (^)(NSDictionary* users, NSError *error)) callback {
    
    NSURLRequest* request = [[AFHTTPRequestSerializer serializer]
                             requestWithMethod: @"POST"
                                     URLString: [self serviceEndpoint:@"auth/fb-login"]
                                    parameters: @{ @"email" : email, @"name" : name, @"last_name" : lastName }
                                         error: nil];
    
    NSURLSessionDataTask* dataTask = [_manager
                                      dataTaskWithRequest: request
                                      completionHandler: ^(
                                                           NSURLResponse * _Nonnull response,
                                                           id  _Nullable responseObject,
                                                           NSError * _Nullable error) {
                                          callback(responseObject, error);
                                      }];
    [dataTask resume];
}


- (void) signUpWithEmail: (NSString *) email
                    name: (NSString *) name
                lastName: (NSString *) lastName
                password: (NSString *) password
                callback: (void (^)(NSDictionary* responseObject, NSError *error)) callback {
    NSDictionary* data = @{
                           @"email" : email,
                           @"name" : name,
                           @"last_name" : lastName,
                           @"password" : password
                           };
    
    NSURLRequest* request = [[AFHTTPRequestSerializer serializer] requestWithMethod: @"POST"
                                                                          URLString: [self serviceEndpoint:@"auth/sign-up"]
                                                                         parameters: data
                                                                              error: nil];
    NSURLSessionDataTask* dataTask = [_manager
                                      dataTaskWithRequest: request
                                      completionHandler: ^(
                                                           NSURLResponse * _Nonnull response,
                                                           id  _Nullable responseObject,
                                                           NSError * _Nullable error) {
                                          callback(responseObject, error);
                                      }];
    [dataTask resume];
}

- (void) checkSession:(void (^)(NSDictionary *, NSError *))callback {
    
    NSMutableURLRequest* request = [[AFHTTPRequestSerializer serializer]
                                    requestWithMethod: @"GET"
                                            URLString: [self serviceEndpoint:@"auth/check-session"]
                                           parameters: nil
                                                error: nil];
    
    NSURLSessionDataTask* dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        callback(responseObject, error);
    }];
    [dataTask resume];
}

- (void) updateDeviceToken: (NSString *) deviceToken
                  callback: (void (^)(NSDictionary* response, NSError *error)) callback {
    NSDictionary* data = @{ @"device_token" : deviceToken };
    NSMutableURLRequest* request = [[AFHTTPRequestSerializer serializer]
                                    requestWithMethod: @"POST"
                                    URLString: [self serviceEndpoint:@"auth/update-device-token"]
                                    parameters: data
                                    error: nil];
    
    NSURLSessionDataTask* dataTask = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        callback(responseObject, error);
    }];
    [dataTask resume];
}


- (void) getUser: (NSString *) userId
    loadMyReview: (BOOL) loadMyReview
        callback: (void (^)(id responseObject, NSError *error)) callback {
    NSString* endpoint = [self serviceEndpoint:[NSString stringWithFormat: @"user/%@%@", userId, (loadMyReview ? @"?with=my_review" : @"")]];
    
    NSMutableURLRequest * request = [[AFHTTPRequestSerializer serializer]
                                     requestWithMethod: @"GET"
                                             URLString: endpoint
                                            parameters: nil
                                                 error: nil];
    
    NSURLSessionDataTask* task = [_manager dataTaskWithRequest: request
                                             completionHandler: ^(NSURLResponse * _Nonnull response,
                                                                  id  _Nullable responseObject,
                                                                  NSError * _Nullable error) {
        callback(responseObject, error);
    }];
    [task resume];
}

-(void) search: (NSString *)query
      callback: (void (^)(id, NSError *))callback {
    
    NSMutableURLRequest * request = [[AFHTTPRequestSerializer serializer] requestWithMethod: @"GET"
                                                                                  URLString: [self serviceEndpoint:@"user"]
                                                                                 parameters: @{ @"q" : query }
                                                                                      error: nil];
    NSURLSessionDataTask* task = [_manager dataTaskWithRequest: request
                                             completionHandler: ^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                 callback(responseObject, error);
                                             }];
    [task resume];
}

-(void) search: (NSString *)query
          size: (NSInteger *) size
          page: (NSInteger *) page
      callback: (void (^)(id, NSError *))callback {
    
    NSMutableURLRequest * request = [[AFHTTPRequestSerializer serializer] requestWithMethod: @"GET"
                                                                                  URLString: [self serviceEndpoint:@"user"]
                                                                                 parameters: @{ @"q" : query,
                                                                                                @"page": page ? [NSString stringWithFormat:@"%ld", (long) page] : nil,
                                                                                                @"size": size ? [NSString stringWithFormat:@"%ld", (long) size] : nil
                                                                                                }
                                                                                      error: nil];
    NSURLSessionDataTask* task = [_manager dataTaskWithRequest: request
                                             completionHandler: ^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                 callback(responseObject, error);
                                             }];
    [task resume];
}


- (void) getContacts: (void (^)(NSArray* users, NSError *error)) callback {
    
    NSMutableURLRequest * request = [[AFHTTPRequestSerializer serializer] requestWithMethod: @"GET"
                                                                                  URLString: [self serviceEndpoint:@"contact"]
                                                                                 parameters: nil
                                                                                      error: nil];
    NSURLSessionDataTask* task    = [_manager dataTaskWithRequest: request
                                                completionHandler: ^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                    callback(responseObject, error);
                                                }];
    [task resume];
}

- (void) addContact: (NSString *) userId
           callback: (void (^)(id responseObject, NSError *error)) callback {
    NSMutableURLRequest * request = [[AFHTTPRequestSerializer serializer]
                                     requestWithMethod: @"POST"
                                             URLString: [self serviceEndpoint:@"contact"]
                                            parameters: @{ @"contact_id": userId }
                                                 error: nil];
    
    NSURLSessionDataTask* task = [_manager dataTaskWithRequest: request
                                             completionHandler: ^(
                                                                  NSURLResponse * _Nonnull response,
                                                                  id  _Nullable responseObject,
                                                                  NSError * _Nullable error) {
                                                 callback(responseObject, error);
                                             }];
    [task resume];
}

- (void) removeContact: (NSString *) userId
              callback: (void (^)(id responseObject, NSError *error)) callback {
    NSMutableURLRequest * request = [[AFHTTPRequestSerializer serializer]
                                     requestWithMethod: @"DELETE"
                                             URLString: [self serviceEndpoint:[NSString stringWithFormat:@"contact/%@", userId]]
                                            parameters: nil
                                                 error: nil];
    
    NSURLSessionDataTask* task = [_manager dataTaskWithRequest: request
                                             completionHandler: ^(NSURLResponse * _Nonnull response,
                                                                  id  _Nullable responseObject,
                                                                  NSError * _Nullable error) {
                                                 callback(responseObject, error);
                                             }];
    [task resume];
    
}

- (void) getFollowersOfUser: (NSString *)userId
                   callback: (void (^)(NSArray* users, NSError *error)) callback {
    NSString* urlGetFollower = [self serviceEndpoint:[NSString stringWithFormat:@"user/%@/follower", userId]];
    
    NSMutableURLRequest * request = [[AFHTTPRequestSerializer serializer]
                                     requestWithMethod: @"GET"
                                             URLString: urlGetFollower
                                            parameters: nil
                                                 error: nil];
    
    NSURLSessionDataTask* task = [_manager
                                  dataTaskWithRequest:request
                                    completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                        callback(responseObject, error);
    }];
    [task resume];
}

- (void) getFollowingByUser: (NSString *)userId
                   callback: (void (^)(NSArray* users, NSError *error)) callback {
    NSString* urlGetFollowing = [self serviceEndpoint:[NSString stringWithFormat:@"user/%@/following", userId]];
    
    NSMutableURLRequest * request = [[AFHTTPRequestSerializer serializer]
                                     requestWithMethod: @"GET"
                                             URLString: urlGetFollowing
                                            parameters: nil
                                                 error: nil];
    
    NSURLSessionDataTask* task = [_manager
                                  dataTaskWithRequest:request
                                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                      callback(responseObject, error);
                                  }];
    [task resume];
}

- (void) getReviewsById: (NSString *) userId
               callback: (void (^)(NSDictionary* responseObject, NSError *error)) callback {
    
    NSString* url = [self serviceEndpoint:[NSString stringWithFormat:@"user/%@/review", userId]];
    NSMutableURLRequest * request = [[AFHTTPRequestSerializer serializer] requestWithMethod: @"GET"
                                                                                  URLString: url
                                                                                 parameters: nil
                                                                                      error: nil];
    
    NSURLSessionDataTask* task = [_manager dataTaskWithRequest: request
                                             completionHandler: ^(NSURLResponse * _Nonnull response,
                                                                  id  _Nullable responseObject,
                                                                  NSError * _Nullable error) {
                                                 callback(responseObject, error);
    }];
    [task resume];
}

- (void) postReviewToUser: (NSString *) userId
                  comment: (NSString *) comment
                    score: (NSString *) score
                 callback: (void (^)(NSDictionary* responseObject, NSError *error)) callback {
    
    
    NSString* url = [self serviceEndpoint:[NSString stringWithFormat:@"user/%@/review", userId]];
    NSMutableURLRequest * request = [[AFHTTPRequestSerializer serializer] requestWithMethod: @"POST"
                                                                                  URLString: url
                                                                                 parameters: @{ @"comment": comment, @"score" : score }
                                                                                      error: nil];
    
    NSURLSessionDataTask* task = [_manager dataTaskWithRequest: request
                                             completionHandler: ^(NSURLResponse * _Nonnull response,
                                                                  id  _Nullable responseObject,
                                                                  NSError * _Nullable error) {
                                                 callback(responseObject, error);
    }];
    [task resume];
}

- (void) updateUserWithData: (NSDictionary *) parameters
                       logo: (NSData *) logo
             profilePicture: (NSData *) profilePicture
                   callback: (void (^)(NSDictionary* responseObject, NSError *error)) callback {

    NSMutableURLRequest* request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod: @"POST"
                                                                                              URLString: [self serviceEndpoint:@"user"]
                                                                                             parameters: parameters
                                                                              constructingBodyWithBlock: ^(id<AFMultipartFormData>  _Nonnull formData) {
        if (logo != nil) {
            [formData appendPartWithFileData: logo
                                        name: @"logo"
                                    fileName: @"logo"
                                    mimeType: @"image/jpeg"];
        }
        if (profilePicture != nil) {
            [formData appendPartWithFileData: profilePicture
                                        name: @"profile_picture"
                                    fileName: @"profile_picture"
                                    mimeType: @"image/jpeg"];
        }
    } error:nil];
    
    NSURLSessionDataTask* task = [_manager dataTaskWithRequest: request
                                             completionHandler: ^(NSURLResponse * _Nonnull response,
                                                                  id  _Nullable responseObject,
                                                                  NSError * _Nullable error) {
                                                 callback(responseObject, error);
    }];
    
    [task resume];
}

- (void) getCards: (void (^)(NSArray* responseObject, NSError *error)) callback {
    
    NSMutableURLRequest * request = [[AFHTTPRequestSerializer serializer] requestWithMethod: @"GET"
                                                                                  URLString: [self serviceEndpoint:@"card"]
                                                                                 parameters: nil
                                                                                      error: nil];

    NSURLSessionDataTask* task = [_manager dataTaskWithRequest: request
                                             completionHandler: ^(NSURLResponse * _Nonnull response,
                                                                  id  _Nullable responseObject,
                                                                  NSError * _Nullable error) {
                                                 callback(responseObject, error);
    }];
    [task resume];
}


- (void) getProfessions: (void (^)(NSArray* responseObject, NSError *error)) callback {
    
    NSMutableURLRequest* request = [[AFHTTPRequestSerializer serializer] requestWithMethod: @"GET"
                                                                                 URLString: [self serviceEndpoint:@"profession"]
                                                                                parameters: nil
                                                                                     error: nil];
    
    NSURLSessionDataTask *task = [_manager dataTaskWithRequest: request
                                             completionHandler: ^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                 callback(responseObject, error);
    }];
    
    [task resume];
}

- (void) pushNotificationsWithToken: (NSString *) token
                           callback: (void (^)(NSDictionary* responseObject, NSError *error)) callback {
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc] init];
    if (token != nil && ![[NSNull null] isEqual:token]) {
        [parameters setValue:token forKey:@"token"];
    }
    NSMutableURLRequest* request = [[AFHTTPRequestSerializer serializer] requestWithMethod: @"GET"
                                                                                 URLString: [self serviceEndpoint: @"push-notification"]
                                                                                parameters: parameters
                                                                                     error: nil];
    
    NSURLSessionDataTask *task = [_manager dataTaskWithRequest: request
                                             completionHandler: ^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                 callback(responseObject, error);
                                             }];
    [task resume];
}

- (void) getNotifications: (void (^)(NSDictionary* responseObject, NSError *error)) callback {
    
    NSMutableURLRequest* request = [[AFHTTPRequestSerializer serializer] requestWithMethod: @"GET"
                                                                                 URLString: [self serviceEndpoint:@"notification"]
                                                                                parameters: nil
                                                                                     error: nil];
    
    NSURLSessionDataTask *task = [_manager dataTaskWithRequest: request
                                             completionHandler: ^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                 callback(responseObject, error);
                                             }];
    [task resume];
}

- (void) readNotification: (NSString *) notificationId
                 callback: (void (^)(NSDictionary* responseObject, NSError *error)) callback {
    
    NSMutableURLRequest* request = [[AFHTTPRequestSerializer serializer] requestWithMethod: @"GET"
                                                                                 URLString: [self serviceEndpoint:[NSString stringWithFormat: @"notification/%@", notificationId]]
                                                                                parameters: nil
                                                                                     error: nil];
    
    NSURLSessionDataTask *task = [_manager dataTaskWithRequest: request
                                             completionHandler: ^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                 callback(responseObject, error);
                                             }];
    [task resume];
}

- (void) rebuildClient {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSMutableDictionary* credentials = [[NSMutableDictionary alloc] init];
    [credentials setValue:@"24be5a2a527205a027ce648ecb65708a" forKey:@"App-Key"];
    if (_sessionToken) {
        [credentials setValue:_sessionToken forKey:@"Session-Token"];
    }
    
    configuration.HTTPAdditionalHeaders = credentials;
    _manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
}

@end
