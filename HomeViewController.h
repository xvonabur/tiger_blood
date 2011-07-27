//
//  HomeViewController.h
//  sample
//
//  Created by xvonabur on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "FBLoginButton.h"
#import <CoreData/CoreData.h>



@interface HomeViewController : UIViewController
<FBRequestDelegate,
FBDialogDelegate,
FBSessionDelegate>{
    
   // NSFetchedResultsController *fetchedResultsController;
   // NSManagedObjectContext *managedObjectContext;

    IBOutlet UILabel* _label;
    IBOutlet FBLoginButton* _fbButton;
    IBOutlet UIButton* _publishButton;
    Facebook* _facebook;
    NSArray* _permissions;
    IBOutlet UITableView* table_view;
     

}

//@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
//@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property(nonatomic, retain) UILabel* label;
@property(nonatomic, retain) UITableView* table_view;
@property(readonly) Facebook *facebook;

-(IBAction)fbButtonClick:(id)sender;
-(IBAction)publishStream:(id)sender;
-(id)initWithTabBar;

@end
