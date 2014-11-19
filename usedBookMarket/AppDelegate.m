//
//  AppDelegate.m
//  usedBookMarket
//
//  Created by Tony's Mac on 5/1/14.
//  Copyright (c) 2014 TonyCP. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
//#import <FacebookSDK/FacebookSDK.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [PFImageView class];
    
    [Parse setApplicationId:@"Hy7kvCeesPPH4yRtaJ3RwuFsZRKeMfvPwLIyjQXC"
                  clientKey:@"zdCoASx7xXmskqO0YYbbfhAHSBGPZNkhrXbVBn0c"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    
    // ****************************************************************************
    // Fill in with your Parse and Twitter credentials. Don't forget to add your
    // Facebook id in Info.plist:
    // ****************************************************************************
    
    [PFFacebookUtils initializeFacebook];
    
    [PFTwitterUtils initializeWithConsumerKey:@"upQyXTc25c7QVYHbmkaPFUGiz"
                               consumerSecret:@"wFJIwRIqq7yuty046zDi6YxPuC3aouIgRiEGyb8Drrza9a0VmD"];
    
    // Set default ACLs
//    PFACL *defaultACL = [PFACL ACL];
//    [defaultACL setPublicReadAccess:YES];
//    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];

    return YES;
}

    // ****************************************************************************
    // App switching methods to support Facebook Single Sign-On.
    // ****************************************************************************


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:[PFFacebookUtils session]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [[PFFacebookUtils session] close];
}



@end
