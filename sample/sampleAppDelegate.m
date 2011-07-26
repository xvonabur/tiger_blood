//
//  sampleAppDelegate.m
//  sample
//
//  Created by xvonabur on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "sampleAppDelegate.h"
#import "HomeViewController.h"


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
    NSArray *temp_arr;
    temp_arr = [managedObjectContext executeFetchRequest:request error:&error];
   
//initial inserting data to db
    if ([temp_arr count] == 0)
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
  //  [temp_arr release];
    [request release];

    controller = [[HomeViewController alloc] init];
    controller.view.frame = CGRectMake(0, 20, 320, 460);
    
    // Override point for customization after application launch.
    [window addSubview:controller.view];
   // [window addSubview:tabBarController.view];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [[controller facebook] handleOpenURL:url];
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
    [controller release];
    [managedObjectContext release];
    [managedObjectModel release];
    [persistentStoreCoordinator release];
    [tabBarController release];
    [table_controller release];
    [super dealloc];
}

@end
