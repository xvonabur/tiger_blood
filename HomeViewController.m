//
//  HomeViewController.m
//  sample
//
//  Created by xvonabur on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "FBConnect.h"
#import "TableViewController.h"

static NSString* kAppId = @"243607465668519";



@implementation HomeViewController
@synthesize label = _label, facebook = _facebook;
@synthesize table_view;
//@synthesize fetchedResultsController, managedObjectContext;


//////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController

/**
 * initialization
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (!kAppId) {
        NSLog(@"missing app id!");
        exit(1);
        return nil;
    }
    
    
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        _permissions =  [[NSArray arrayWithObjects:
                          @"read_stream", @"publish_stream", @"offline_access",nil] retain];
    }
    
    return self;
}

/**
 * Set initial view
 */
- (void)viewDidLoad {
    _facebook = [[Facebook alloc] initWithAppId:kAppId];
    _facebook.accessToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"AccessToken"];
    _facebook.expirationDate = (NSDate *) [[NSUserDefaults standardUserDefaults] objectForKey:@"ExpirationDate"];
     
     
  
    if ([_facebook isSessionValid] == NO) { 
        [self.label setText:@"Please log in"];
        _publishButton.hidden = YES;
        _fbButton.isLoggedIn = NO;
        table_view.scrollEnabled = NO;
        self.view.backgroundColor = [UIColor grayColor];
        [_fbButton updateImage];
    } else {
        [self.label setText:@"logged in"];
        _publishButton.hidden = NO;
        _fbButton.isLoggedIn = YES;
        table_view.scrollEnabled = YES;
       self.view.backgroundColor = [UIColor whiteColor];
       
        
        [_fbButton updateImage];
    }
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (void)dealloc {
    [_label release];
    [_fbButton release];
    
    [_publishButton release];
    
    [_facebook release];
    [_permissions release];
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

/**
 * Show the authorization dialog.
 */
- (void)login {
    [_facebook authorize:_permissions delegate:self];
}

/**
 * Invalidate the access token and clear the cookie.
 */
- (void)logout {
    [_facebook logout:self];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// IBAction

/**
 * Called on a login/logout button click.
 */
- (IBAction)fbButtonClick:(id)sender {
    if (_fbButton.isLoggedIn) {
        [self logout];
    } else {
        [self login];
    }
}


/**
 * Open an inline dialog that allows the logged in user to publish a story to his or
 * her wall.
 */
- (IBAction)publishStream:(id)sender {
    
    SBJSON *jsonWriter = [[SBJSON new] autorelease];
    
    NSDictionary* actionLinks = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:
                                                           @"Always Running",@"text",@"http://itsti.me/",@"href", nil], nil];
    
    NSString *actionLinksStr = [jsonWriter stringWithObject:actionLinks];
    NSDictionary* attachment = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"a long run", @"name",
                                @"The Facebook Running app", @"caption",
                                @"it is fun", @"description",
                                @"http://itsti.me/", @"href", nil];
    NSString *attachmentStr = [jsonWriter stringWithObject:attachment];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Share on Facebook",  @"user_message_prompt",
                                   actionLinksStr, @"action_links",
                                   attachmentStr, @"attachment",
                                   nil];
    
    
    [_facebook dialog:@"feed"
            andParams:params
          andDelegate:self];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


/**
 * Called when the user has logged in successfully.
 */
- (void)fbDidLogin {
    [self.label setText:@"logged in"];
    _publishButton.hidden = NO;
    _fbButton.isLoggedIn = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    table_view.scrollEnabled = YES;
    table_view.allowsSelection = YES;
    [_fbButton updateImage];
    [[NSUserDefaults standardUserDefaults] setObject:self.facebook.accessToken forKey:@"AccessToken"];
    [[NSUserDefaults standardUserDefaults] setObject:self.facebook.expirationDate forKey:@"ExpirationDate"];
}

/**
 * Called when the user canceled the authorization dialog.
 */
-(void)fbDidNotLogin:(BOOL)cancelled {
    NSLog(@"did not login");
}

/**
 * Called when the request logout has succeeded.
 */
- (void)fbDidLogout {
    [self.label setText:@"Please log in"];
    self.view.backgroundColor = [UIColor grayColor];
    table_view.scrollEnabled = NO;
     table_view.allowsSelection = NO;
    _publishButton.hidden        = YES;
    _fbButton.isLoggedIn         = NO;
    [_fbButton updateImage];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"AccessToken"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"ExpirationDate"];
}


////////////////////////////////////////////////////////////////////////////////
// FBRequestDelegate

/**
 * Called when the Facebook API request has returned a response. This callback
 * gives you access to the raw response. It's called before
 * (void)request:(FBRequest *)request didLoad:(id)result,
 * which is passed the parsed response object.
 */
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"received response");
}

/**
 * Called when a request returns and its response has been parsed into
 * an object. The resulting object may be a dictionary, an array, a string,
 * or a number, depending on the format of the API response. If you need access
 * to the raw response, use:
 *
 * (void)request:(FBRequest *)request
 *      didReceiveResponse:(NSURLResponse *)response
 
 - (void)request:(FBRequest *)request didLoad:(id)result {
 if ([result isKindOfClass:[NSArray class]]) {
 result = [result objectAtIndex:0];
 }
 if ([result objectForKey:@"owner"]) {
 [self.label setText:@"Photo upload Success"];
 } else {
 [self.label setText:[result objectForKey:@"name"]];
 }
 };
 */

/**
 * Called when an error prevents the Facebook API request from completing
 * successfully.
 
 - (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
 [self.label setText:[error localizedDescription]];
 };
 */

////////////////////////////////////////////////////////////////////////////////
// FBDialogDelegate

/**
 * Called when a UIServer Dialog successfully return.
 */
- (void)dialogDidComplete:(FBDialog *)dialog {
    [self.label setText:@"publish successfully"];
}



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



@end