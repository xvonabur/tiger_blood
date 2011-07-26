//
//  TableViewController.h
//  sample
//
//  Created by xvonabur on 7/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
//#import "sampleAppDelegate.h"
#import "Movies.h"

//@class Movie;

@interface TableViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
  
    NSArray *movies;
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSArray *movies;

@end
