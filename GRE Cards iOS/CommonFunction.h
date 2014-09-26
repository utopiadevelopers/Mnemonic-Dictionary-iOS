//
//  CommonFunction.h
//  Gre Cards
//
//  Created by Satyam Krishna on 12/07/14.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import <GooglePlus/GooglePlus.h>
#import "Constants.h"
#import "LoginViewController.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define ENABLE_DEBUGGING false
#define UIVIEW_HEIGHT(v)                              v.frame.size.height
#define UIVIEW_WIDTH(v)                               v.frame.size.width
#define UIVIEW_X(v)                                   v.frame.origin.x
#define UIVIEW_Y(v)                                   v.frame.origin.y

#define X(v)                                            v.frame.origin.x
#define Y(v)                                            v.frame.origin.y
#define H(v)                                            v.frame.size.height
#define W(v)                                            v.frame.size.width
#define BOTTOM(v)                                       v.frame.origin.y + v.frame.size.height
#define AFTER(v)                                        v.frame.origin.x + v.frame.size.width

#define ZIMG(p)                                     [UIImage imageNamed:[NSString stringWithFormat: @"/Images/%@", p]]


@interface CommonFunction : NSObject

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color withWidth:(CGFloat)width andHeight:(CGFloat)height;

+ (UIImage *)imageWithColor:(UIColor *)color andOpacity:(CGFloat)alpha;

+ (UIImage *)imageWithColor:(UIColor *)color withWidth:(CGFloat)width andHeight:(CGFloat)height andAlpha:(CGFloat)alpha;

+ (UIColor *) colorFromHexString:(NSString *)hexString ;

+ (NSMutableString *)getFormattedDate:(NSString *)date andInDateFormat:(NSString *)informat andOutDateFormat:(NSString *)outformat;

+ (NSString *)getStringFromDefaultDateFormat:(NSString *)dateStringFromApi ForFormat:(NSString *)requiredDateFormat;

+ (NSString *)getStringFromDate:(NSDate *)date ForFormat:(NSString *)requiredDateFormat;

+ (BOOL) isUserLoggedIn;

+ (void) logOutUser;

+ (UINavigationController *) getLoginViewController;

@end
