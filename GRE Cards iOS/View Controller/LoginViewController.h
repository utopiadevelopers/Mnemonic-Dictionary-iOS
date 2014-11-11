//
//  LoginViewController.h
//  Gre Cards
//
//  Created by Satyam Krishna on 11/07/14.
//

#import <UIKit/UIKit.h>
#import <GooglePlus/GooglePlus.h>
#import <FacebookSDK/FacebookSDK.h>
#import "LoginAPI.h"
#import "SocialLoginAPI.h"

@class GPPSignInButton;

@interface LoginViewController : UIViewController<GPPSignInDelegate,LoginDelegateAPI,SocialLoginDelegateAPI>

@end
