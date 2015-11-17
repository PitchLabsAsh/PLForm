//
//  PLAppDelegate.m
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Ash Thwaites. All rights reserved.
//

@import Foundation;
#import "PLAppDelegate.h"
#import <PLForm/PLFormTextField.h>
#import <PLForm/PLFloatingLabelTextField.h>
#import <PLForm/PLFloatingLabelDateField.h>
#import <PLForm/PLFloatingLabelSelectField.h>
#import <PLForm/PLFloatingLabelTextView.h>
#import <PLForm/PLFloatingLabelAutoCompleteField.h>
#import <PLForm/PLFormPinField.h>


@implementation PLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // set some appearance
    [[PLFormTextField appearance] setBackgroundColor:[UIColor whiteColor]];
    [[PLFormTextField appearance] setCornerRadius:2];
    [[PLFormTextField appearance] setPlaceholderColor:[UIColor blueColor]];
    [[PLFormTextField appearance] setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
    [[PLFormTextField appearance] setTextColor:[UIColor blackColor]];
    [[PLFormTextField appearance] setContentInsets:UIEdgeInsetsMake(2, 2, 2, 2)];

    [[PLFloatingLabelTextField appearance] setFloatingFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12]];
    [[PLFloatingLabelTextField appearance] setFloatingColor:[UIColor blueColor]];

    
    
    [[PLFormDateField appearance] setBackgroundColor:[UIColor whiteColor]];
    [[PLFormDateField appearance] setCornerRadius:2];
    [[PLFormDateField appearance] setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
    [[PLFormDateField appearance] setTextColor:[UIColor blueColor]];
    [[PLFormDateField appearance] setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
    [[PLFormDateField appearance] setValueColor:[UIColor blackColor]];
    [[PLFormDateField appearance] setContentInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
    
    [[PLFloatingLabelDateField appearance] setFloatingFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12]];
    [[PLFloatingLabelDateField appearance] setFloatingColor:[UIColor blueColor]];

    
    
    [[PLFormSelectField appearance] setBackgroundColor:[UIColor whiteColor]];
    [[PLFormSelectField appearance] setCornerRadius:2];
    [[PLFormSelectField appearance] setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
    [[PLFormSelectField appearance] setTextColor:[UIColor blueColor]];
    [[PLFormSelectField appearance] setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
    [[PLFormSelectField appearance] setValueColor:[UIColor blackColor]];
    [[PLFormSelectField appearance] setContentInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
    
    [[PLFloatingLabelSelectField appearance] setFloatingFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12]];
    [[PLFloatingLabelSelectField appearance] setFloatingColor:[UIColor blueColor]];
    
    
    [[PLFormTextView appearance] setBackgroundColor:[UIColor whiteColor]];
    [[PLFormTextView appearance] setCornerRadius:2];
    [[PLFormTextView appearance] setPlaceholderColor:[UIColor blueColor]];
    [[PLFormTextView appearance] setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
    [[PLFormTextView appearance] setTextColor:[UIColor blackColor]];
    [[PLFormTextView appearance] setContentInsets:UIEdgeInsetsMake(10, 2, 2, 2)];
    
    [[PLFloatingLabelTextView appearance] setFloatingFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12]];
    [[PLFloatingLabelTextView appearance] setFloatingColor:[UIColor blueColor]];
    
    
    
    [[PLFormAutoCompleteField appearance] setBackgroundColor:[UIColor whiteColor]];
    [[PLFormAutoCompleteField appearance] setCornerRadius:2];
    [[PLFormAutoCompleteField appearance] setPlaceholderColor:[UIColor blueColor]];
    [[PLFormAutoCompleteField appearance] setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
    [[PLFormAutoCompleteField appearance] setTextColor:[UIColor blackColor]];
    [[PLFormAutoCompleteField appearance] setContentInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
    
    [[PLFloatingLabelAutoCompleteField appearance] setFloatingFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12]];
    [[PLFloatingLabelAutoCompleteField appearance] setFloatingColor:[UIColor blueColor]];
    
    
    [[PLFormPinField appearance] setBackgroundColor:[UIColor whiteColor]];
    [[PLFormPinField appearance] setCornerRadius:2];
    [[PLFormPinDot appearance] setUnselectedBorderColor:[UIColor blackColor]];
    [[PLFormPinDot appearance] setHighlightedBorderColor:[UIColor lightGrayColor]];
    [[PLFormPinDot appearance] setSelectedBorderColor:[UIColor blueColor]];
    [[PLFormPinDot appearance] setUnselectedColor:[UIColor clearColor]];
    [[PLFormPinDot appearance] setHighlightedColor:[UIColor clearColor]];
    [[PLFormPinDot appearance] setSelectedColor:[UIColor whiteColor]];
    
    return YES;
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

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
