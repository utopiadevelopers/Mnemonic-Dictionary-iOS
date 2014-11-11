//
//  LoginViewController.m
//  Gre Cards
//
//  Created by Satyam Krishna on 11/07/14.
//

#import "LoginViewController.h"
#import "DownloadViewController.h"
#import "DashboardViewController.h"
#import "Toast.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>
#import "MainHeaderView.h"

@implementation LoginViewController
{
    NSInteger buttonWidth;
    UILabel *titleLabel;
    UILabel *loginLabel;
    UITextField *emailTextField;
    UITextField *passwordTextField;
    UIButton *loginButton;
    UIView *emailTextView ;
    UIView *passwordTextView;
    UIActivityIndicatorView * loginActivityIndicator;
    GPPSignInButton *signInButton;
    UIButton *fbButton;
    GPPSignIn *signIn;
    LoginAPI *loginManager;
    SocialLoginAPI *socialLoginManager;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self initializeVariables];
    [self setupNavigationBar];
    [self setupKeyboardNotification];
    [self createViews];
    [self createLoginIndicator];
    [self setupGooglePlus];
}

- (void) initializeVariables
{
    loginManager = [[LoginAPI alloc] init];
    [loginManager setDelegate:self];
    
    socialLoginManager = [[SocialLoginAPI alloc] init];
    [socialLoginManager setDelegate:self];
}

- (void) setupNavigationBar
{
    MainHeaderView *headerView = [[MainHeaderView alloc] initMainHeaderWithParent:self WithTitle:@"Login" backButtonRequired:NO];
    UIBarButtonItem *leftLabelButton = [[UIBarButtonItem alloc] initWithCustomView:headerView];
    [[self navigationItem] setLeftBarButtonItem:leftLabelButton];
}

#pragma Keyboard Notification

- (void)setupKeyboardNotification
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void) dismissKeyboard
{
    [emailTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
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
                [self socialLoginWithAccessToken:[session.accessTokenData accessToken] andType:SOCIAL_TYPE_FACEBOOK];
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
        [self socialLoginWithAccessToken:auth.accessToken andType:SOCIAL_TYPE_GOOGLEPLUS];
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
    
    [[self view] setBackgroundColor:UIColorFromRGB(UTOPIA_GREY)];

    signInButton = [[GPPSignInButton alloc] init];
    [signInButton setFrame:CGRectMake(SIDE_PADDING,SIDE_PADDING, W(self.view)-2*SIDE_PADDING, 2*buttonWidth)];
    [signInButton setStyle:kGPPSignInButtonStyleWide];
    [signInButton.layer setCornerRadius:3.0];

    UIFont *googleFont = [signInButton.titleLabel.font copy];
    UIImageView *fbLoginImage = [[UIImageView alloc]initWithImage:IMG(@"facebook.png")];
    NSInteger fbLoginImageSize = 22;
    
    [fbLoginImage setFrame:CGRectMake(SIDE_PADDING + fbLoginImageSize/2,BOTTOM(signInButton)+SIDE_PADDING + (buttonWidth-fbLoginImageSize)/2,fbLoginImageSize,fbLoginImageSize)];
    [fbLoginImage setContentMode:UIViewContentModeScaleAspectFill];
    
    fbButton = [[UIButton alloc] init];
    [fbButton setFrame:CGRectMake(SIDE_PADDING,BOTTOM(signInButton)+SIDE_PADDING, W(self.view)-2*SIDE_PADDING, buttonWidth)];
    [fbButton setBackgroundImage:[CommonFunction imageWithColor:UIColorFromRGB(0X3B5999)] forState:UIControlStateNormal];
    [fbButton setBackgroundImage:[CommonFunction imageWithColor:UIColorFromRGB(0X3B59C0)] forState:UIControlStateHighlighted];
    
    
    [fbButton.layer setCornerRadius:3.0];
    [fbButton setTitle:@"Sign in with Facebook" forState:UIControlStateNormal];
    [fbButton setTitleColor:UIColorFromRGB(WHITE_COLOR) forState:UIControlStateNormal];
    [fbButton.titleLabel setFont:[UIFont fontWithName:googleFont.fontName size:14.0]];
    [fbButton addTarget:self action:@selector(loginFB) forControlEvents:UIControlEventTouchUpInside];
    
    loginLabel = [[UILabel alloc] init];
    [loginLabel setTextAlignment:NSTextAlignmentCenter];
    [loginLabel setText:@"OR LOG IN USING EMAIL"];
    [loginLabel setFrame:CGRectMake(0,BOTTOM(fbButton) + SIDE_PADDING, W(self.view),50)];
    
    emailTextView = [self getEmailTextField];
    passwordTextView = [self getPasswordView];
    
    loginButton = [[UIButton alloc]init];
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [loginButton.titleLabel setTextColor:UIColorFromRGB(WHITE_COLOR)];
    [loginButton setBackgroundImage:[CommonFunction imageWithColor:UIColorFromRGB(IOS_BLUE)] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[CommonFunction imageWithColor:UIColorFromRGB(IOS_BLUE_FEEDBACK)] forState:UIControlStateHighlighted];
    [loginButton setFrame:CGRectMake(SIDE_PADDING, BOTTOM(passwordTextView)+SIDE_PADDING, W(self.view)-2*SIDE_PADDING, buttonWidth)];
    [loginButton.layer setCornerRadius:3.0];
    [loginButton setClipsToBounds:true];
    [loginButton addTarget:self action:@selector(loginButtonTapped:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:titleLabel];
    [self.view addSubview:signInButton];
    [self.view addSubview:fbButton];
    [self.view addSubview:loginLabel];
    [self.view addSubview:emailTextView];
    [self.view addSubview:passwordTextView];
    [self.view addSubview:loginButton];
    [self.view insertSubview:fbLoginImage aboveSubview:fbButton];
}

-(UIView *) getEmailTextField
{
    UIView *textFieldContainerView = [[UIView alloc] initWithFrame:CGRectMake(SIDE_PADDING,BOTTOM(loginLabel) + SIDE_PADDING, W(self.view)-2*SIDE_PADDING, buttonWidth)];
    emailTextField = [[UITextField alloc]initWithFrame:CGRectMake(SIDE_PADDING, 0, W(self.view)-4*SIDE_PADDING, buttonWidth)];
    
    [emailTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [emailTextField setPlaceholder:@"Email"];
    [emailTextField setBackgroundColor:UIColorFromRGB(WHITE_COLOR)];
    [emailTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [emailTextField setText:@""];
    
    [textFieldContainerView setBackgroundColor:UIColorFromRGB(WHITE_COLOR)];
    [textFieldContainerView addSubview:emailTextField];
    [textFieldContainerView.layer setCornerRadius:URC_MEDIUM];
    [textFieldContainerView setClipsToBounds:true];
    
    return textFieldContainerView;
}

-(UIView *) getPasswordView
{
    UIView *textFieldContainerView = [[UIView alloc] initWithFrame:CGRectMake(SIDE_PADDING, BOTTOM(emailTextView)+SIDE_PADDING, W(self.view)-2*SIDE_PADDING, buttonWidth)];
    passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(SIDE_PADDING,0, W(self.view)-4*SIDE_PADDING, buttonWidth)];
    
    [passwordTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [passwordTextField setPlaceholder:@"Password"];
    [passwordTextField setBackgroundColor:UIColorFromRGB(WHITE_COLOR)];
    [passwordTextField setSecureTextEntry:YES];
    [passwordTextField setText:@""];
    
    [textFieldContainerView setBackgroundColor:UIColorFromRGB(WHITE_COLOR)];
    [textFieldContainerView addSubview:passwordTextField];
    [textFieldContainerView.layer setCornerRadius:URC_MEDIUM];
    [textFieldContainerView setClipsToBounds:true];
    
    return textFieldContainerView;
}

#pragma mark - textfield delegate

-(void) createLoginIndicator
{
    loginActivityIndicator = [[UIActivityIndicatorView alloc]init];
    [loginActivityIndicator setCenter:loginButton.center];
    [loginActivityIndicator setHidesWhenStopped:true];
    [loginActivityIndicator stopAnimating];
    [self.view addSubview:loginActivityIndicator];
}

-(void) socialLoginWithAccessToken:(NSString *)accessToken andType:(NSString *)type
{
    [self disableViews];
    [socialLoginManager socialLoginWithAccessToken:accessToken andType:type];
}

#pragma Login Delegate

-(void) loginWasSuccessful
{
    [loginActivityIndicator stopAnimating];
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:IS_JSON_DOWNLOADED])
    {
        [self presentViewController:[CommonFunction getDashboardViewController] animated:YES completion:^{
            
        }];
    }
    else
    {
        [self presentViewController:[CommonFunction getDownloadViewController] animated:YES completion:^{
            
        }];
    }
}

-(void) loginFalied
{
    [self displayDropdownwithmessage:@"Incorrect Login/Password"];
    [self enableViews];
}

#pragma Social Login Delegate

-(void) socialLoginWasSuccessful
{
    [self loginWasSuccessful];
}

-(void) socialLoginFalied
{
    [self loginFalied];
}

-(void) disableViews
{
    [loginActivityIndicator startAnimating];
    [signInButton setEnabled:FALSE];
    [fbButton setEnabled:FALSE];
    [loginButton setTitle:@"" forState:UIControlStateNormal];
    [loginButton setEnabled:FALSE];
    [emailTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    [emailTextField setUserInteractionEnabled:FALSE];
    [passwordTextField setUserInteractionEnabled:FALSE];
    
}

-(void) enableViews
{
    [signInButton setEnabled:TRUE];
    [fbButton setEnabled:TRUE];
    [loginButton setEnabled:TRUE];
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [emailTextField setUserInteractionEnabled:TRUE];
    [passwordTextField setUserInteractionEnabled:TRUE];
    [loginActivityIndicator stopAnimating];
    
    
}

- (void) displayDropdownwithmessage : (NSString *) message
{
    if(message != nil)
    {
        Toast *mToast = [Toast toastWithMessage:message];
        [mToast showOnView:self.view];
    }
}

- (void) loginButtonTapped:(UIButton *)sender
{
    if (emailTextField.text.length>0 && passwordTextField.text.length>0)
    {
        [self disableViews];
        [loginManager loginWithUserName:[emailTextField text] password:[passwordTextField text]];
    }
    else
    {
        [self displayDropdownwithmessage:@"Fill in All the Details"];
    }
}

@end
