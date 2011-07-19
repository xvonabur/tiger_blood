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


@interface HomeViewController : UIViewController
<FBRequestDelegate,
FBDialogDelegate,
FBSessionDelegate>{
    IBOutlet UILabel* _label;
    IBOutlet FBLoginButton* _fbButton;
    IBOutlet UIButton* _publishButton;
    Facebook* _facebook;
    NSArray* _permissions;
}

@property(nonatomic, retain) UILabel* label;

@property(readonly) Facebook *facebook;

-(IBAction)fbButtonClick:(id)sender;
-(IBAction)publishStream:(id)sender;
@end
