//
//  sampleAppDelegate.m
//  sample
//
//  Created by xvonabur on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "sampleAppDelegate.h"
#import "HomeViewController.h"
#import "TableViewController.h"


@implementation sampleAppDelegate

@synthesize window, managedObjectModel, managedObjectContext,persistentStoreCoordinator;
@synthesize tabBarController;

- (NSManagedObjectContext *) managedObjectContext {
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];
    
    return managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                               stringByAppendingPathComponent: @"sample.sqlite"]];
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                  initWithManagedObjectModel:[self managedObjectModel]];
    if(![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                 configuration:nil URL:storeUrl options:nil error:&error]) {
        /*Error for store creation should be handled in here*/
    }
    
    return persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
    table_controller.managedObjectContext = self.managedObjectContext;  
    //NSManagedObjectContext *context = [self managedObjectContext];
    
    
    NSEntityDescription *entityDesc = [NSEntityDescription    
                                       entityForName:@"Movies" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc]; 
    NSError *error;
    NSArray * temp_arr;
    temp_arr = [managedObjectContext executeFetchRequest:request error:&error];
//initial inserting data to db
       if ([[managedObjectContext executeFetchRequest:request error:&error] count] == 0)
    {
        NSManagedObject *newMovie;
        newMovie = [NSEntityDescription
                    insertNewObjectForEntityForName:@"Movies"
                    inManagedObjectContext:managedObjectContext];
        [newMovie setValue:@"LOST" forKey:@"name"];
        [managedObjectContext save:&error];
        
        NSManagedObject *newMovie1;
        newMovie1 = [NSEntityDescription
                     insertNewObjectForEntityForName:@"Movies"
                     inManagedObjectContext:managedObjectContext];
        [newMovie1 setValue:@"Friends" forKey:@"name"];
        [managedObjectContext save:&error];
        
        NSManagedObject *newMovie2;
        newMovie2 = [NSEntityDescription
                     insertNewObjectForEntityForName:@"Movies"
                     inManagedObjectContext:managedObjectContext];
        [newMovie2 setValue:@"Two and a Half men" forKey:@"name"];
        [managedObjectContext save:&error];

    }
  //[temp_arr autorelease];
    [request release];

//Tab bar creation for facebook sdk
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
 
    // set up a local nav controller which we will reuse for each view controller
    UINavigationController *localNavigationController;
    
    // create tab bar controller and array to hold the view controllers
    tabBarController = [[UITabBarController alloc] init];
    NSMutableArray *localControllersArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    // setup the first view controller (Root view controller)
   // HomeViewController *myViewController;
    myViewController = [[HomeViewController alloc] initWithTabBar];
    
    // create the nav controller and add the root view controller as its first view
    localNavigationController = [[UINavigationController alloc] initWithRootViewController:myViewController];
    
    // add the new nav controller (with the root view controller inside it)
    // to the array of controllers
    [localControllersArray addObject:localNavigationController];
    
    // release since we are done with this for now
    [localNavigationController release];
    [myViewController release];
    
    // setup the second view controller just like the firstSecondViewController *secondViewController;
    TableViewController *table_contr;
    table_contr = [[TableViewController alloc] initWithTabBar];
    localNavigationController = [[UINavigationController alloc]
                                 initWithRootViewController:table_contr];
    [localControllersArray addObject:localNavigationController];
    [localNavigationController release];
    [table_contr release];
    
    // load up our tab bar controller with the view controllers
    tabBarController.viewControllers = localControllersArray;
    
    // release the array because the tab bar controller now has it
    [localControllersArray release];
    
    // add the tabBarController as a subview in the window
    [window addSubview:tabBarController.view];
    
    // need this last line to display the window (and tab bar controller)
    [window makeKeyAndVisible];
    

    
    
//   controller = [[HomeViewController alloc] init];
//    controller.view.frame = CGRectMake(0, 20, 320, 460);
    
    // Override point for customization after application launch.
//    [window addSubview:controller.view];
   // [window addSubview:tabBarController.view];
    
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [[myViewController facebook] handleOpenURL:url];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    //[Movie finalizeStatements];
}

- (void)dealloc
{
    
    [window release];
    [myViewController release];
    [managedObjectContext release];
    [managedObjectModel release];
    [persistentStoreCoordinator release];
    [tabBarController release];
    [table_controller release];
    [super dealloc];
}

@end
