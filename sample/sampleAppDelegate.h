//
//  sampleAppDelegate.h
//  sample
//
//  Created by xvonabur on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface sampleAppDelegate : NSObject <UIApplicationDelegate> {
    UITabBarController*  tabBarController;
    UIWindow *window;
    HomeViewController* controller;
}


@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
