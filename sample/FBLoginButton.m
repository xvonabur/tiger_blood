//
//  FBLoginButton.m
//  sample
//
//  Created by xvonabur on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FBLoginButton.h"
#import "Facebook.h"

#import <dlfcn.h>

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation FBLoginButton

@synthesize isLoggedIn = _isLoggedIn;

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

/**
 * return the regular button image according to the login status
 */
- (UIImage*)buttonImage {
    if (_isLoggedIn) {
        return [UIImage imageNamed:@"FBConnect.bundle/images/LogoutNormal.png"];
    } else {
        return [UIImage imageNamed:@"FBConnect.bundle/images/LoginNormal.png"];
    }
}

/**
 * return the highlighted button image according to the login status
 */
- (UIImage*)buttonHighlightedImage {
    if (_isLoggedIn) {
        return [UIImage imageNamed:@"FBConnect.bundle/images/LogoutPressed.png"];
    } else {
        return [UIImage imageNamed:@"FBConnect.bundle/images/LoginPressed.png"];
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////
// public

/**
 * To be called whenever the login status is changed
 */
- (void)updateImage {
    self.imageView.image = [self buttonImage];
    [self setImage: [self buttonImage]
          forState: UIControlStateNormal];
    
    [self setImage: [self buttonHighlightedImage]
          forState: UIControlStateHighlighted |UIControlStateSelected];
    
}

@end 