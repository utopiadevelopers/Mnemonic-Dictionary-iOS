//
//  LoginViewController.h
//  Gre Cards
//
//  Created by Satyam Krishna on 11/07/14.
//

#import <UIKit/UIKit.h>
#import <GooglePlus/GooglePlus.h>
#import <FacebookSDK/FacebookSDK.h>

@class GPPSignInButton;

@interface LoginViewController : UIViewController<GPPSignInDelegate>

@property (retain, nonatomic) IBOutlet GPPSignInButton *signInButton;
@property (retain, nonatomic) IBOutlet UIButton *fbButton;
@property (strong, nonatomic) GPPSignIn *signIn;

@end
