//
//  sampleAppDelegate.h
//  sample
//
//  Created by xvonabur on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "TabsForFaceController.h"

@class Movie;

@interface sampleAppDelegate : NSObject <UIApplicationDelegate> {
    UITabBarController*  tabBarController;
    UIWindow *window;
    HomeViewController* controller;
    
    NSMutableArray *moviesArray;
}

@property (nonatomic, retain) NSMutableArray *moviesArray;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;


//"copyDatabaseIfNeeded" is used to copy the database on the user’s phone when the application is finished launching. “getDBPath” gets the database location on the user’s phone.
- (void) copyDatabaseIfNeeded;
- (NSString *) getDBPath;



@end
