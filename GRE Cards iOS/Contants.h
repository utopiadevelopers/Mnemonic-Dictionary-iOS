//
//  Contants.h
//  Gre Cards
//
//  Created by Satyam Krishna on 11/07/14.
//  Copyright (c) 2014 Zomato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contants : NSObject

#define DEFAULT_DATE_FORMAT @"yyyy-MM-dd"
#define TRANSACTION_DATE_FORMAT @"yyyy-MM-dd HH:mm:ss"

//********************API***********************
#define API_URL @"http://www.utopiadevelopers.com/gre/api/"
#define JSON_URL @"http://www.utopiadevelopers.com/gre/upload/O.json"

#define LOGIN_API @"login.php"
#define SOCIAL_LOGIN_API @"login_social.php"

#define LOGIN_SUCCESS @"success"
#define LOGIN_FAIL @"fail"
#define LOGIN_TYPE @"login_type"
#define LOGIN_NORMAL @"login_normal"
#define SOCIAL_TYPE_GooglePlus @"GPlus"
#define SOCIAL_TYPE_Facebook @"FB"

//***********************end***********************

//********************default height of some views***********************

#define POPUP_HEADER_HEIGHT 50.0
#define SIDE_PADDING 15.0
#define SCROLLABLE_TAB_HEIGHT 40.0f
#define ZRC_LOW 3.0
#define ZRC_MEDIUM 5.0
#define NAVIGATION_BAR_HEIGHT 64.0
#define TAB_BAR_HEIGHT 49.0

//***********************end***********************

////*********************Localization**************************
//
//#define NSLocalizedString(X, Y) [CommonFunction getLocalizedStringForKey:X]  //overriding the default nslocalizedstring function
//#define NSLocalizedStringUppercase(X, Y) [NSLocalizedString(X, Y) uppercaseString]   //get upperCaseString
//#define NSLocalizedStringCapitalized(X, Y) [NSLocalizedString(X, Y) capitalizedString]   //get capitalized
//#define NSLocalizedStringLowercase(X, Y) [NSLocalizedString(X, Y) lowercaseString]   //get upperCaseString
//
////********************* end **************************

//********************* nsuser defaults constants **************************
#define IS_LOGGED_IN    @"is_logged_in"
#define USER_ID         @"user_id"
#define IS_JSON_DOWNLOADED @"is_file_present"
//*********************ends **************************

//*********************Colors**************************

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define ZHL                 0xF4F4F2
#define ZHL2                0xE7E7E4
#define ZHL_DARK            0xE4E4E2
#define ZHL_DARKER          0xCBCBC8
#define ZHL_DARKEST         0x9A9A93

#define ZDHL                0x3D3D39
#define ZDHL2               0x4D4D49
#define ZDHL3               0x5D5D58
#define ZDHL4               0x6D6D67
#define ZDHL5               0x7D7D76
#define ZDHL6               0x8D8D85

#define ZBLUE               0x00AACC
#define ZDARK               0x2D2D2A
#define ZDARK_iOS           0x1a1a19
#define ZDARKER_iOS         0x141411
#define ZDARKEST_iOS        0x0a0a09
#define ZERROR              0xFCF8E3
#define GOOGLE_COLOR        0xdd4b39
#define SEARCH_TAGS_COLOR   0xde695b
#define NAV_BAR_COLOR       ZOMATO_RED
#define NAV_BAR_SEPARATOR_COLOR ZHL_DARKEST
#define TEXT_COLOR_LESS_DARK ZDHL2
#define NAV_BAR_ITEMS_COLOR  WHITE_COLOR

#define LINE_COLOR          ZHL_DARKER
#define LINE_COLOR_LIGHT    ZHL_DARK
#define RES_LINE_COLOR      0xf1f1e9

#define FEEDBACK_GREY       ZHL
#define GREY				ZDHL6
#define HIGHLIGHT_GREY      ZHL
#define DARK_GREY           ZDHL

#define WHITE_COLOR         0xFFFFFF
#define BLACK_COLOR         0x000000

#define ZOMATO_GREEN        0x69bc63
#define ZOMATO_GREEN_FEEDBACK        0x59a553

#define ZOMATO_MERCHANT        0xff6622
#define ZOMATO_MERCHANT_FEEDBACK   0xff9966

#define ZOMATO_BLACK_HEADER ZDARK
#define CROP_LINES_COLOR    ZDHL6
#define ZOMATO_YELLOW       0xFFD35D
#define Z_YELLOW_BRIGHT     0xFFFCED
#define ZOMATO_RED          0xCB202D
#define ZOMATO_BLUE         0xacd8e1
#define IOS_BLUE            0x007AFF
#define IOS_BLUE_FEEDBACK   0x005AFF

#define ZOMATO_RED_LIGHT    0xE71323
#define ZOMATO_VERIFIED_BLUE_COLOR 0x00aacc
#define ZOMATO_BLACK        [UIColor colorWithWhite:0.18f alpha:1]
#define DARK_BUTTON         ZDHL4
#define ZOMATO_ORANGE       0xF58552

#define FORM_HIGHLIGHT_COLOR    0x2d2d2a

//********************* end **************************


//****************************Fonts*****************************************


#define FONT_BOLD_8                 [UIFont fontWithName:@"HelveticaNeue-Medium" size:8]
#define FONT_BOLD_9                 [UIFont fontWithName:@"HelveticaNeue-Medium" size:9]
#define FONT_BOLD_10                [UIFont fontWithName:@"HelveticaNeue-Medium" size:10]
#define FONT_BOLD_11                [UIFont fontWithName:@"HelveticaNeue-Medium" size:11]
#define FONT_BOLD_12                [UIFont fontWithName:@"HelveticaNeue-Medium" size:12]
#define FONT_BOLD_13                [UIFont fontWithName:@"HelveticaNeue-Medium" size:13]
#define FONT_BOLD_14                [UIFont fontWithName:@"HelveticaNeue-Medium" size:14]
#define FONT_BOLD_15                [UIFont fontWithName:@"HelveticaNeue-Medium" size:15]
#define FONT_BOLD_16                [UIFont fontWithName:@"HelveticaNeue-Medium" size:16]
#define FONT_BOLD_17                [UIFont fontWithName:@"HelveticaNeue-Medium" size:17]
#define FONT_BOLD_18                [UIFont fontWithName:@"HelveticaNeue-Medium" size:18]
#define FONT_BOLD_19                [UIFont fontWithName:@"HelveticaNeue-Medium" size:19]
#define FONT_BOLD_20                [UIFont fontWithName:@"HelveticaNeue-Medium" size:20]
#define FONT_BOLD_22                [UIFont fontWithName:@"HelveticaNeue-Medium" size:22]
#define FONT_BOLD_24                [UIFont fontWithName:@"HelveticaNeue-Medium" size:24]
#define FONT_BOLD_26                [UIFont fontWithName:@"HelveticaNeue-Medium" size:26]

#define FONT_BOLD_PLUS_MINUS        [UIFont fontWithName:@"Helvetica-Bold" size:36]


#define FONT_NORMAL_15              [UIFont fontWithName:@"HelveticaNeue" size:15]
#define FONT_NORMAL_30              [UIFont fontWithName:@"HelveticaNeue" size:28]
#define FONT_SMALL_TEXT             [UIFont fontWithName:@"HelveticaNeue" size:11]

// Regular fonts

#define FONT_REGULAR_9              [UIFont fontWithName:@"HelveticaNeue" size:9]
#define FONT_REGULAR_10             [UIFont fontWithName:@"HelveticaNeue" size:10]
#define FONT_REGULAR_11             [UIFont fontWithName:@"HelveticaNeue" size:11]
#define FONT_REGULAR_12             [UIFont fontWithName:@"HelveticaNeue" size:12]
#define FONT_REGULAR_12_5           [UIFont fontWithName:@"HelveticaNeue" size:12.5]
#define FONT_REGULAR_13             [UIFont fontWithName:@"HelveticaNeue" size:13]
#define FONT_REGULAR_14             [UIFont fontWithName:@"HelveticaNeue" size:14]
#define FONT_REGULAR_15             [UIFont fontWithName:@"HelveticaNeue" size:15]
#define FONT_REGULAR_16             [UIFont fontWithName:@"HelveticaNeue" size:16]
#define FONT_REGULAR_17             [UIFont fontWithName:@"HelveticaNeue" size:17]
#define FONT_REGULAR_18             [UIFont fontWithName:@"HelveticaNeue" size:18]
#define FONT_REGULAR_20             [UIFont fontWithName:@"HelveticaNeue" size:20]
#define FONT_REGULAR_21             [UIFont fontWithName:@"HelveticaNeue" size:21]
#define FONT_REGULAR_22             [UIFont fontWithName:@"HelveticaNeue" size:22]
#define FONT_REGULAR_23             [UIFont fontWithName:@"HelveticaNeue" size:23]
#define FONT_REGULAR_24             [UIFont fontWithName:@"HelveticaNeue" size:24]
#define FONT_REGULAR_25             [UIFont fontWithName:@"HelveticaNeue" size:25]
#define FONT_REGULAR_30             [UIFont fontWithName:@"HelveticaNeue" size:30]



#define URL(X)              [NSURL URLWithString:X]

#define FONT_REGULAR(X)     [UIFont fontWithName:@"HelveticaNeue" size:X]
#define FONT_BOLD(X)        [UIFont fontWithName:@"HelveticaNeue-Medium" size:X]
#define FONT_SEMIBOLD(X)        [UIFont fontWithName:@"HelveticaNeue-Medium" size:X]

#define FONT_SUBTEXT                FONT_REGULAR_12
#define FONT_HEADER_TITLE           [UIFont fontWithName:@"HelveticaNeue-Medium" size:20]
#define FONT_BUTTON                 [UIFont fontWithName:@"HelveticaNeue-Medium" size:10]
#define FONT_COMMENT				FONT_REGULAR_12

#define FONT_BIG_LIGHT              [UIFont fontWithName:@"HelveticaNeue" size:21]

#define FONT_VERY_BIG_BOLD          [UIFont fontWithName:@"HelveticaNeue-Medium" size:24]

#define FONT_ICON(X)                [UIFont fontWithName:@"zmerchant" size:X]

#define FONT_RATINGZ(X)             [UIFont fontWithName:@"ratingzRegular" size:X]


//***************default colors****************

#define POPUP_HEADER_BACKGROUND UIColorFromRGB(ZHL_DARK)

//*********************ends **************************

//********************* nsuser defaults constants **************************
#define IS_LOGGED_IN    @"is_logged_in"
#define AUTH_KEY        @"user_auth"
//*********************end**************************

////****************uilabel styles********

#define STYLE_H2 [[UIStyle alloc] initWithFont : FONT_BOLD_15 color: UIColorFromRGB(ZDARK) allCaps : YES]
#define STYLE_H3 [[UIStyle alloc] initWithFont : FONT_BOLD_12 color: [UIColor whiteColor] allCaps : YES]
#define STYLE_BODY_TEXT [[UIStyle alloc] initWithFont : FONT_REGULAR_14 color: UIColorFromRGB(DARK_GREY) allCaps : NO]
#define STYLE_BODY_TEXT_BOLD [[UIStyle alloc] initWithFont : FONT_BOLD_14 color: UIColorFromRGB(DARK_GREY) allCaps : NO]
#define STYLE_BODY_TEXT_BOLD_WHITE [[UIStyle alloc] initWithFont : FONT_BOLD_14 color: [UIColor whiteColor] allCaps : NO]
#define STYLE_CAPTION_BOLD [[UIStyle alloc] initWithFont : FONT_BOLD_14 color: [UIColor whiteColor] allCaps : NO]
#define STYLE_CAPTION_REGULAR [[UIStyle alloc] initWithFont : FONT_REGULAR_14 color: [UIColor whiteColor] allCaps : NO]
#define STYLE_H22 [[UIStyle alloc] initWithFont : FONT_BOLD_15 color: UIColorFromRGB(0xAAAAAA) allCaps : YES]
#define STYLE_H2_LABEL [[UIStyle alloc] initWithFont : FONT_REGULAR_14 color: UIColorFromRGB(0xAAAAAA) allCaps : NO]
#define STYLE_H2_LABEL_2D [[UIStyle alloc] initWithFont : FONT_REGULAR_14 color: UIColorFromRGB(ZDARK) allCaps : NO]
#define STYLE_FORM_LABEL [[UIStyle alloc] initWithFont : FONT_REGULAR_14 color: UIColorFromRGB(0x444444) allCaps : NO]
#define STYLE_BODY [[UIStyle alloc] initWithFont : FONT_REGULAR_14 color: UIColorFromRGB(ZDARK) allCaps : NO]
#define STYLE_H3D [[UIStyle alloc] initWithFont : FONT_BOLD_11 color: UIColorFromRGB(0xAAAAAA) allCaps : YES]
#define STYLE_LIST [[UIStyle alloc] initWithFont : FONT_REGULAR_16 color: UIColorFromRGB(ZDARK) allCaps : NO]
#define STYLE_LIST_D [[UIStyle alloc] initWithFont : FONT_REGULAR_14 color: [UIColor ZHLDarkerColor] allCaps : NO]
#define STYLE_LIST_2_D [[UIStyle alloc] initWithFont : FONT_REGULAR_14 color: UIColorFromRGB(0xAAAAAA) allCaps : NO]
#define STYLE_POPUP_HEADER_TITLE [[UIStyle alloc] initWithFont : FONT_BOLD_15 color: UIColorFromRGB(ZDARK) allCaps : NO]

#define STYLE_SMALL_LABEL [[UIStyle alloc] initWithFont : FONT_BOLD_10 color: UIColorFromRGB(ZDARK) allCaps : YES]
#define STYLE_BIG_LABEL [[UIStyle alloc] initWithFont : FONT_BOLD_12 color: UIColorFromRGB(ZDHL2) allCaps : YES]
#define STYLE_SMALLEST_LABEL [[UIStyle alloc] initWithFont : FONT_BOLD_11 color: UIColorFromRGB(0xAAAAAA) allCaps : YES]
#define STYLE_SMALLEST_LABEL_FOR_RATING_TEXT [[UIStyle alloc] initWithFont : FONT_BOLD_10 color: UIColorFromRGB(0xAAAAAA) allCaps : YES]
#define STYLE_SMALLEST_LABEL_GREY [[UIStyle alloc] initWithFont : FONT_BOLD_9 color: UIColorFromRGB(0xAEAEAE) allCaps : YES]
#define STYLE_SMALLEST_LABEL_DARK [[UIStyle alloc] initWithFont : FONT_BOLD_9 color: UIColorFromRGB(ZDHL6) allCaps : YES]
#define STYLE_USER_SNIPPET_SMALL_NAME [[UIStyle alloc] initWithFont: FONT_BOLD_14 color: UIColorFromRGB(0x000000) allCaps : NO]
#define STYLE_USER_SNIPPET_SMALL_FOODIE_LEVEL [[UIStyle alloc] initWithFont : FONT_BOLD_9 color: [UIColor whiteColor] allCaps : YES]
#define STYLE_TIMESTAMP [[UIStyle alloc] initWithFont : FONT_SUBTEXT color: UIColorFromRGB(ZHL_DARKER) allCaps : NO]
#define STYLE_MAIN_HEADER_TITLE [[UIStyle alloc] initWithFont : FONT_BOLD_17 color : [UIColor whiteColor] allCaps : NO]
#define STYLE_BIG_BODY_LABEL [[UIStyle alloc] initWithFont : FONT_BOLD_20 color: UIColorFromRGB(0x000000) allCaps : NO]

#define STYLE_BIG_LIGHT_LABEL [[UIStyle alloc] initWithFont : FONT_BIG_LIGHT color: UIColorFromRGB(ZDHL4) allCaps : NO]

#define STYLE_SMALL_TEXT [[UIStyle alloc] initWithFont : FONT_SMALL_TEXT color : UIColorFromRGB(0xAEAEAE) allCaps : NO]

#define TABLE_HEADER_STYLE [[UIStyle alloc] initWithFont:FONT_BOLD_14  color:UIColorFromRGB(ZDHL5) allCaps:YES]
//*********************end**************************
@end
