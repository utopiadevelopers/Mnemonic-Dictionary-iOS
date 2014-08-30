//
//  LoginViewController.m
//  Gre Cards
//
//  Created by Satyam Krishna on 11/07/14.
//  Copyright (c) 2014 Zomato. All rights reserved.
//

#import "LoginViewController.h"
#import "DownloadViewController.h"
#import "Authentication.h"
#import "SocialLogin.h"
#import "NSString+MD5.h"
#import "DashboardViewController.h"
#import "Toast.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>

@interface LoginViewController ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *loginLabel;
@property (strong, nonatomic)  UITextField *emailTextField;
@property (strong, nonatomic)  UITextField *passwordTextField;
@property (strong, nonatomic)  UIButton *loginButton;
@property (strong, nonatomic) UIView *emailTextView ;
@property (strong, nonatomic) UIView *passwordTextView;
@property (strong, nonatomic) UIActivityIndicatorView * loginActivityIndicator;

@end

@implementation LoginViewController
{
    NSInteger buttonWidth;
}

@synthesize signIn;
@synthesize signInButton;
@synthesize fbButton;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self setupKeyboardNotification];
    [self createViews];
    [self createLoginIndicator];
    [self setupGooglePlus];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Keyboard Notification

- (void)setupKeyboardNotification
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void) dismissKeyboard
{
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

#pragma Facebook Login

- (void)loginFB
{
    // If the session state is any of the two "open" states when the button is clicked
    if (FBSession.activeSession.state == FBSessionStateOpen || FBSession.activeSession.state == FBSessionStateOpenTokenExtended)
    {
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        
        [FBSession.activeSession closeAndClearTokenInformation];
        
        // If the session state is not any of the two "open" states when the button is clicked
    }
    else
    {
        // Open a session showing the user the login UI
        // You must ALWAYS ask for public_profile permissions when opening a session
        [FBSession openActiveSessionWithReadPermissions:@[@"email"] allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState state, NSError *error)
        {
            if(!error)
            {
                [self socialLoginWithAccessToken:[session.accessTokenData accessToken] andType:SOCIAL_TYPE_Facebook];
            }
            else
            {
                [self displayDropdownwithmessage:@"There was some error.Please Try Again Later"];
            }
        }];
    }
}


#pragma Google Plus Login

-(void) setupGooglePlus
{
    signIn= [GPPSignIn sharedInstance];
    [signIn setShouldFetchGooglePlusUser:YES];
    [signIn setShouldFetchGoogleUserEmail:YES];
    [signIn setClientID:@"441180665306-5ddkgh968b7qfb8qhm65n0b87i42fkle.apps.googleusercontent.com"];
    
    [signIn setScopes:@[kGTLAuthScopePlusUserinfoEmail]];
    [signIn setDelegate:self];
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth error: (NSError *) error {
    NSLog(@"Received error %@ and auth object %@",error, auth);
    if(error)
    {
        [self displayDropdownwithmessage:@"There was some error.Please Try Again Later"];
    }
    else
    {
        [self disableViews];
        [self socialLoginWithAccessToken:auth.accessToken andType:SOCIAL_TYPE_GooglePlus];
    }
}

- (void)presentSignInViewController:(UIViewController *)viewController {
    // This is an example of how you can implement it if your app is navigation-based.
    [[self navigationController] pushViewController:viewController animated:YES];
}

#pragma View Creations

-(void) createViews
{
    buttonWidth = 42;
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.titleLabel setText:@"GRE Cards"];
    [self.titleLabel setFrame:CGRectMake(0,10, W(self.view),50)];
    
    self.signInButton = [[GPPSignInButton alloc] init];
    [self.signInButton setFrame:CGRectMake(SIDE_PADDING,BOTTOM(self.titleLabel)+SIDE_PADDING, W(self.view)-2*SIDE_PADDING, 2*buttonWidth)];
    [self.signInButton setStyle:kGPPSignInButtonStyleWide];
    [self.signInButton.layer setCornerRadius:3.0];

    UIFont *googleFont = [self.signInButton.titleLabel.font copy];
    UIImageView *fbLoginImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"facebook.png"]];
    NSInteger fbLoginImageSize = 22;
    
    [fbLoginImage setFrame:CGRectMake(SIDE_PADDING + fbLoginImageSize/2,BOTTOM(self.signInButton)+SIDE_PADDING + (buttonWidth-fbLoginImageSize)/2,fbLoginImageSize,fbLoginImageSize)];
    [fbLoginImage setContentMode:UIViewContentModeScaleAspectFill];
    
    self.fbButton = [[UIButton alloc] init];
    [self.fbButton setFrame:CGRectMake(SIDE_PADDING,BOTTOM(self.signInButton)+SIDE_PADDING, W(self.view)-2*SIDE_PADDING, buttonWidth)];
    [self.fbButton setBackgroundImage:[CommonFunction imageWithColor:UIColorFromRGB(0X3B5999)] forState:UIControlStateNormal];
    [self.fbButton setBackgroundImage:[CommonFunction imageWithColor:UIColorFromRGB(0X3B59C0)] forState:UIControlStateHighlighted];
    
    
    [self.fbButton.layer setCornerRadius:3.0];
    [self.fbButton setTitle:@"Sign in with Facebook" forState:UIControlStateNormal];
    [self.fbButton setTitleColor:UIColorFromRGB(WHITE_COLOR) forState:UIControlStateNormal];
    [self.fbButton.titleLabel setFont:[UIFont fontWithName:googleFont.fontName size:14.0]];
    [self.fbButton addTarget:self action:@selector(loginFB) forControlEvents:UIControlEventTouchUpInside];
    
    self.loginLabel = [[UILabel alloc] init];
    [self.loginLabel setTextAlignment:NSTextAlignmentCenter];
    [self.loginLabel setText:@"OR LOG IN USING EMAIL"];
    [self.loginLabel setFrame:CGRectMake(0,BOTTOM(self.fbButton) + SIDE_PADDING, W(self.view),50)];
    
    self.emailTextView = [self getEmailTextField];
    
    self.passwordTextView = [self getPasswordView];
    
    self.loginButton = [[UIButton alloc]init];
    [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [self.loginButton.titleLabel setTextColor:UIColorFromRGB(WHITE_COLOR)];
    [self.loginButton setBackgroundImage:[CommonFunction imageWithColor:UIColorFromRGB(IOS_BLUE)] forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:[CommonFunction imageWithColor:UIColorFromRGB(IOS_BLUE_FEEDBACK)] forState:UIControlStateHighlighted];
    [self.loginButton setFrame:CGRectMake(SIDE_PADDING, BOTTOM(self.passwordTextView)+SIDE_PADDING, W(self.view)-2*SIDE_PADDING, buttonWidth)];
    [self.loginButton.layer setCornerRadius:3.0];
    [self.loginButton setClipsToBounds:true];
    [self.loginButton addTarget:self action:@selector(loginButtonTapped:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.signInButton];
    [self.view addSubview:self.fbButton];
    [self.view addSubview:self.loginLabel];
    [self.view addSubview:self.emailTextView];
    [self.view addSubview:self.passwordTextView];
    [self.view addSubview:self.loginButton];
    [self.view insertSubview:fbLoginImage aboveSubview:fbButton];
}

-(UIView *) getEmailTextField
{
    UIView *textFieldContainerView = [[UIView alloc] initWithFrame:CGRectMake(SIDE_PADDING,BOTTOM(self.loginLabel) + SIDE_PADDING, W(self.view)-2*SIDE_PADDING, buttonWidth)];
    self.emailTextField = [[UITextField alloc]initWithFrame:CGRectMake(SIDE_PADDING, 0, W(self.view)-4*SIDE_PADDING, buttonWidth)];
    
    [self.emailTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.emailTextField setPlaceholder:@"Email"];
    [self.emailTextField setBackgroundColor:UIColorFromRGB(WHITE_COLOR)];
    [self.emailTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [self.emailTextField setText:@""];
    
    [textFieldContainerView setBackgroundColor:UIColorFromRGB(WHITE_COLOR)];
    [textFieldContainerView addSubview:self.emailTextField];
    [textFieldContainerView.layer setCornerRadius:ZRC_MEDIUM];
    [textFieldContainerView setClipsToBounds:true];
    
    return textFieldContainerView;
}

-(UIView *) getPasswordView
{
    UIView *textFieldContainerView = [[UIView alloc] initWithFrame:CGRectMake(SIDE_PADDING, BOTTOM(self.emailTextView)+SIDE_PADDING, W(self.view)-2*SIDE_PADDING, buttonWidth)];
    self.passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(SIDE_PADDING,0, W(self.view)-4*SIDE_PADDING, buttonWidth)];
    
    [self.passwordTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.passwordTextField setPlaceholder:@"Password"];
    [self.passwordTextField setBackgroundColor:UIColorFromRGB(WHITE_COLOR)];
    [self.passwordTextField setSecureTextEntry:YES];
    [self.passwordTextField setText:@""];
    
    [textFieldContainerView setBackgroundColor:UIColorFromRGB(WHITE_COLOR)];
    [textFieldContainerView addSubview:self.passwordTextField];
    [textFieldContainerView.layer setCornerRadius:ZRC_MEDIUM];
    [textFieldContainerView setClipsToBounds:true];
    
    return textFieldContainerView;
}

#pragma mark - textfield delegate

-(void) createLoginIndicator
{
    self.loginActivityIndicator = [[UIActivityIndicatorView alloc]init];
    [self.loginActivityIndicator setCenter:self.loginButton.center];
    [self.loginActivityIndicator setHidesWhenStopped:true];
    [self.loginActivityIndicator stopAnimating];
    [self.view addSubview:self.loginActivityIndicator];
}


-(BOOL) prefersStatusBarHidden
{
    return YES;
}

-(void) socialLoginWithAccessToken:(NSString *)accessToken andType:(NSString *)type
{
    NSLog(@"Trying to Login");
    [self disableViews];
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[SocialLogin class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"login":   @"login",
                                                  @"auth" :   @"auth",
                                                  @"email":   @"email"
                                                  }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?auth=%@&type=%@",API_URL,SOCIAL_LOGIN_API,accessToken,type]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result)
     {
         [self.loginActivityIndicator stopAnimating];
         SocialLogin *auth = (SocialLogin*)[result firstObject];
         if([auth.login isEqualToString:LOGIN_SUCCESS])
         {
             [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_LOGGED_IN];
             [[NSUserDefaults standardUserDefaults] setValue:auth.auth forKey:AUTH_KEY];
             [[NSUserDefaults standardUserDefaults] setValue:type forKey:LOGIN_TYPE];
             if([[NSUserDefaults standardUserDefaults] boolForKey:IS_JSON_DOWNLOADED])
             {
                 DashboardViewController *viewController = [[DashboardViewController alloc] init];
                 [self presentViewController:viewController animated:YES completion:^{
                     
                 }];
             }
             else
             {
                 DownloadViewController *viewController = [[DownloadViewController alloc] init];
                 [self presentViewController:viewController animated:YES completion:^{
                     
                 }];
             }
         }
         else
         {
             [self displayDropdownwithmessage:@"There was some error.Please Try Again Later"];
             [self enableViews];
         }
     } failure:nil];
    [operation start];
}


-(void) loginWithUserName:(NSString *)userName password:(NSString *)password
{
    NSLog(@"Trying to Login");
    [self disableViews];
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Authentication class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"login":   @"login",
                                                  @"auth":     @"auth"
                                                  }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?email=%@&password=%@",API_URL,LOGIN_API,userName,[password MD5]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result)
    {
        [self.loginActivityIndicator stopAnimating];
        Authentication *auth = (Authentication*)[result firstObject];
        if([auth.login isEqualToString:LOGIN_SUCCESS])
        {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_LOGGED_IN];
            [[NSUserDefaults standardUserDefaults] setValue:auth.auth forKey:AUTH_KEY];
            [[NSUserDefaults standardUserDefaults] setValue:LOGIN_NORMAL forKey:LOGIN_TYPE];
            if([[NSUserDefaults standardUserDefaults] boolForKey:IS_JSON_DOWNLOADED])
            {
                DashboardViewController *viewController = [[DashboardViewController alloc] init];
                [self presentViewController:viewController animated:YES completion:^{
                    
                }];
            }
            else
            {
                DownloadViewController *viewController = [[DownloadViewController alloc] init];
                [self presentViewController:viewController animated:YES completion:^{
                    
                }];
            }
        }
        else
        {
            [self displayDropdownwithmessage:@"Incorrect Login/Password"];
            [self enableViews];
        }
    } failure:nil];
    [operation start];
}

-(void) disableViews
{
    [self.loginActivityIndicator startAnimating];
    [self.signInButton setEnabled:FALSE];
    [self.fbButton setEnabled:FALSE];
    [self.loginButton setTitle:@"" forState:UIControlStateNormal];
    [self.loginButton setEnabled:FALSE];
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.emailTextField setUserInteractionEnabled:FALSE];
    [self.passwordTextField setUserInteractionEnabled:FALSE];
    
}

-(void) enableViews
{
    [self.signInButton setEnabled:TRUE];
    [self.fbButton setEnabled:TRUE];
    [self.loginButton setEnabled:TRUE];
    [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [self.emailTextField setUserInteractionEnabled:TRUE];
    [self.passwordTextField setUserInteractionEnabled:TRUE];
    [self.loginActivityIndicator stopAnimating];
    
    
}

- (void) displayDropdownwithmessage : (NSString *) message
{
    if(message != nil)
    {
        Toast *mToast = [Toast toastWithMessage:message];
        [mToast showOnView:self.view];
    }
}

- (void) loginButtonTapped:(UIButton *)sender {
    
    if (self.emailTextField.text.length>0 && self.passwordTextField.text.length>0) {
        [self loginWithUserName:self.emailTextField.text password:self.passwordTextField.text];
        
    }
    else
    {
        [self displayDropdownwithmessage:@"Fill in All the Details"];
    }
}
@end
