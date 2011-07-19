//
//  FBLoginButton.h
//  sample
//
//  Created by xvonabur on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBLoginButton : UIButton {
    BOOL  _isLoggedIn;
}

@property(nonatomic) BOOL isLoggedIn; 

- (void) updateImage;

@end

