//
//  CommonFunction.m
//  Gre Cards
//
//  Created by Satyam Krishna on 12/07/14.
//

#import "CommonFunction.h"
#import "SplashViewController.h"
#import "LoginViewController.h"
#import "DownloadViewController.h"
#import "DashboardViewController.h"

@implementation CommonFunction

+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [self imageWithColor:color withWidth:1.0f andHeight:1.0f];
}

+ (UIImage *)imageWithColor:(UIColor *)color withWidth:(CGFloat)width andHeight:(CGFloat)height
{
    return [self imageWithColor:color withWidth:width andHeight:height andAlpha:1];
}

+ (UIImage *)imageWithColor:(UIColor *)color andOpacity:(CGFloat)alpha
{
    return [self imageWithColor:color withWidth:1 andHeight:1 andAlpha:alpha];
}

+ (UIImage *)imageWithColor:(UIColor *)color withWidth:(CGFloat)width andHeight:(CGFloat)height andAlpha:(CGFloat)alpha
{
    
    CGFloat r, g, b, a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, width, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetAlpha(context, alpha);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIColor *) colorFromHexString:(NSString *)hexString
{
    @try {
        unsigned rgbValue = 0;
        NSScanner *scanner = [NSScanner scannerWithString:hexString];
        [scanner setScanLocation:1]; // bypass '#' character
        [scanner scanHexInt:&rgbValue];
        return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
        
    }
    @catch (NSException *exception) {
        return [UIColor blackColor];
    }
}

+(NSMutableString *)getFormattedDate:(NSString *)date andInDateFormat:(NSString *)informat andOutDateFormat:(NSString *)outformat
{
    NSArray* myDate = [date  componentsSeparatedByString:@" "];
    
    NSString* dateStamp = [myDate objectAtIndex:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:informat];
    NSDate *dateFromString = [dateFormatter dateFromString:dateStamp];
    [dateFormatter setDateFormat:outformat] ;
    NSMutableString *InDate = (NSMutableString *)[dateFormatter stringFromDate:dateFromString];//req format 10 jan 2012
    
    return InDate;
}

+(NSString *)getStringFromDefaultDateFormat:(NSString *)dateStringFromApi ForFormat:(NSString *)requiredDateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:DEFAULT_DATE_FORMAT];
    NSDate *date = [dateFormatter dateFromString:dateStringFromApi];
    [dateFormatter setDateFormat:requiredDateFormat];
    
    return [dateFormatter stringFromDate:date];
}

+(NSString *)getStringFromDate:(NSDate *)date ForFormat:(NSString *)requiredDateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:requiredDateFormat];
    return [dateFormatter stringFromDate:date];
}

#pragma User Login 

+ (BOOL) isUserLoggedIn
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:IS_LOGGED_IN];
}

+ (void) logOutUser
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if([[prefs objectForKey:LOGIN_TYPE] isEqualToString:SOCIAL_TYPE_GOOGLEPLUS])
    {
        [[GPPSignIn sharedInstance] signOut];
        [[GPPSignIn sharedInstance] disconnect];
    }
    else if([[prefs objectForKey:LOGIN_TYPE] isEqualToString:SOCIAL_TYPE_FACEBOOK])
    {
        [[FBSession activeSession] closeAndClearTokenInformation];
    }
    
    [prefs removeObjectForKey:IS_LOGGED_IN];
    [prefs removeObjectForKey:AUTH_KEY];
    [prefs removeObjectForKey:LOGIN_TYPE];
}

#pragma View Controllers

+ (UIViewController *) getSplashViewController
{
    SplashViewController *svc = [[SplashViewController alloc] init];
    return svc;
}

+ (UINavigationController *) getLoginViewController
{
    LoginViewController *lvc = [[LoginViewController alloc] init];
    
    UINavigationController *loginNavigationController = [[UINavigationController alloc] initWithRootViewController:lvc];
    
    [loginNavigationController setNavigationBarHidden:NO];
    [[loginNavigationController navigationBar] setTintColor:[UIColor whiteColor]];
    [[loginNavigationController navigationBar] setBarTintColor:UIColorFromRGB(NAV_BAR_COLOR)];
    [[loginNavigationController navigationBar] setBarStyle:UIBarStyleBlackTranslucent];
    [[loginNavigationController navigationBar] setTranslucent:NO];
    [[loginNavigationController navigationBar] setBackgroundImage:[CommonFunction imageWithColor:UIColorFromRGB(NAV_BAR_COLOR)] forBarMetrics:UIBarMetricsDefault];
    [[loginNavigationController navigationBar] setShadowImage:[[UIImage alloc] init]];
    
    return loginNavigationController;
}

+ (UINavigationController *) getDownloadViewController
{
    DownloadViewController *dvc = [[DownloadViewController alloc] init];
    
    UINavigationController *downloadNavigationController = [[UINavigationController alloc] initWithRootViewController:dvc];
    
    [downloadNavigationController setNavigationBarHidden:NO];
    [[downloadNavigationController navigationBar] setTintColor:[UIColor whiteColor]];
    [[downloadNavigationController navigationBar] setBarTintColor:UIColorFromRGB(NAV_BAR_COLOR)];
    [[downloadNavigationController navigationBar] setBarStyle:UIBarStyleBlackTranslucent];
    [[downloadNavigationController navigationBar] setTranslucent:NO];
    [[downloadNavigationController navigationBar] setBackgroundImage:[CommonFunction imageWithColor:UIColorFromRGB(NAV_BAR_COLOR)] forBarMetrics:UIBarMetricsDefault];
    [[downloadNavigationController navigationBar] setShadowImage:[[UIImage alloc] init]];
    
    return downloadNavigationController;
}

+ (UINavigationController *) getDashboardViewController
{
    DashboardViewController *dvc = [[DashboardViewController alloc] init];
    
    UINavigationController *dashboardNavigationController = [[UINavigationController alloc] initWithRootViewController:dvc];
    
    [dashboardNavigationController setNavigationBarHidden:NO];
    [[dashboardNavigationController navigationBar] setTintColor:[UIColor whiteColor]];
    [[dashboardNavigationController navigationBar] setBarTintColor:UIColorFromRGB(NAV_BAR_COLOR)];
    [[dashboardNavigationController navigationBar] setBarStyle:UIBarStyleBlackTranslucent];
    [[dashboardNavigationController navigationBar] setTranslucent:NO];
    [[dashboardNavigationController navigationBar] setBackgroundImage:[CommonFunction imageWithColor:UIColorFromRGB(NAV_BAR_COLOR)] forBarMetrics:UIBarMetricsDefault];
    [[dashboardNavigationController navigationBar] setShadowImage:[[UIImage alloc] init]];
    
    return dashboardNavigationController;
}

#pragma Size Related

+ (CGFloat) getPhoneWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat) getPhoneHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat) isiPhone6
{
    if([UIScreen mainScreen].bounds.size.width > 350)
    {
        return YES;
    }
    return NO;
}

+ (CGFloat) isiPhone6Plus
{
    if([UIScreen mainScreen].bounds.size.width > 380)
    {
        return YES;
    }
    return NO;
}

@end
