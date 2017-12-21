//
//  AppDelegate.h
//  Meishii
//
//  Created by Develop Mx on 18/08/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AFURLSessionManager.h"
#import "Session.h"
#import "User.h"
#import "MeisshiApi.h"
#import <UserNotifications/UNUserNotificationCenter.h>
@import Firebase;


@interface AppDelegate : UIResponder <UIApplicationDelegate, FIRMessagingDelegate, UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) AFURLSessionManager* manager;
@property (strong, nonatomic) MeisshiApi* api;
@property (strong, nonatomic) Session* session;
@property (strong, nonatomic) User* user;
@property (strong, nonatomic) NSString* openUserId;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void) requestForAuthorizationNotification;
+ (AppDelegate*) sharedInstance;

@end

