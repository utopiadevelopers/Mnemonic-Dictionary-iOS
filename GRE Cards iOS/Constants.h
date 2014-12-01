//
//  Constants.h
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 19/09/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

#define DEFAULT_DATE_FORMAT @"yyyy-MM-dd"
#define TRANSACTION_DATE_FORMAT @"yyyy-MM-dd HH:mm:ss"

//********************API***********************

#define HOST @"www.utopiadevelopers.com"
#define API_URL @"/gre/api"
#define JSON_URL @"http://www.utopiadevelopers.com/gre/upload/data.json"
#define JSON_URL_TEST @"http://www.utopiadevelopers.com/gre/upload/data.json"
//#define JSON_URL_TEST @"http://www.utopiadevelopers.com/gre/upload/test.json"

#define STATUS_SUCCESS @"success"
#define LOGIN_SUCCESS STATUS_SUCCESS
#define LOGIN_FAIL @"fail"
#define LOGIN_TYPE @"login_type"
#define LOGIN_NORMAL @"login_normal"
#define SOCIAL_TYPE_GOOGLEPLUS @"GPlus"
#define SOCIAL_TYPE_FACEBOOK @"FB"

//***********************end***********************

//********************default height of some views***********************

#define SIDE_PADDING 15.0
#define SCROLLABLE_TAB_HEIGHT 40.0f
#define URC_LOW 3.0
#define URC_MEDIUM 5.0
#define NAVIGATION_BAR_HEIGHT 64.0
#define MAIN_HEADER_HEIGHT 45.0f
#define TAB_BAR_HEIGHT 49.0
#define STATUS_BAR_HEIGHT_ADDITION (SYSTEM_VERSION_LESS_THAN(@"7.0") ? 0.0f : 20.0f)

//***********************end***********************


//********************* NSUserDefaults Constants **************************

#define IS_LOGGED_IN    @"is_logged_in"
#define USER_ID         @"user_id"
#define USER_EMAIL      @"user_email"
#define IS_JSON_DOWNLOADED @"is_file_present"
#define AUTH_KEY        @"user_auth"

//********************* ENDS **************************

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

#define WHITE_COLOR          0xFFFFFF
#define BLACK_COLOR          0x000000
#define IOS_BLUE             0x007AFF
#define IOS_BLUE_FEEDBACK    0x005AFF
#define UTOPIA_BLUE          0x2F8AE9
#define UTOPIA_GREY          0xD6D7D8
#define SEARCH_BAR_COLOR     0xBFBFC4

#define NAV_BAR_COLOR        UTOPIA_BLUE
#define NAV_BAR_ITEMS_COLOR  WHITE_COLOR


#define IMG(p)        [UIImage imageNamed:[NSString stringWithFormat: @"%@", p]]

//********************* ends **************************


/*=============================Universal Fonts=======================================*/
#define FONT_BODY_SMALL                 [UIFont fontWithName:@"OpenSans" size:13]
#define FONT_BODY                       [UIFont fontWithName:@"OpenSans" size:14]
#define FONT_BODY_BOLD                  [UIFont fontWithName:@"OpenSans-Bold" size:14]
#define FONT_BODY_BOLD_LARGE            FONT_BOLD_15
#define FONT_HEADER_LABEL               FONT_GOTHAM_BOLD(12)
#define FONT_NAV_BAR_LABEL              [UIFont fontWithName:@"OpenSans-Semibold" size:17]
#define FONT_MODAL_LABEL                FONT_BOLD(16)
#define FONT_TITLE_LABEL                FONT_SEMIBOLD(15)
#define FONT_COLLECTIONS_TITLE          [UIFont fontWithName:@"OpenSans" size:23]
#define FONT_HELVETICANEUE_REGULAR(X)   [UIFont fontWithName:@"HelveticaNeue" size:X]
#define FONT_HELVETICANEUE_LIGHT(X)     [UIFont fontWithName:@"Helvetica-Light" size:X]
#define FONT_SUBMIT_BUTTON              FONT_GOTHAM_BOLD(18)
/*===================================================================================*/

// BOLD FONTS


#define FONT_BOLD_8                 [UIFont fontWithName:@"OpenSans-Bold" size:8]
#define FONT_BOLD_9                 [UIFont fontWithName:@"OpenSans-Bold" size:9]
#define FONT_BOLD_10                [UIFont fontWithName:@"OpenSans-Bold" size:10]
#define FONT_BOLD_11                [UIFont fontWithName:@"OpenSans-Bold" size:11]
#define FONT_BOLD_12                [UIFont fontWithName:@"OpenSans-Bold" size:12]
#define FONT_BOLD_13                [UIFont fontWithName:@"OpenSans-Bold" size:13]
#define FONT_BOLD_14                [UIFont fontWithName:@"OpenSans-Bold" size:14]
#define FONT_BOLD_15                [UIFont fontWithName:@"OpenSans-Bold" size:15]
#define FONT_BOLD_16                [UIFont fontWithName:@"OpenSans-Bold" size:16]
#define FONT_BOLD_17                [UIFont fontWithName:@"OpenSans-Bold" size:17]
#define FONT_BOLD_18                [UIFont fontWithName:@"OpenSans-Bold" size:18]
#define FONT_BOLD_19                [UIFont fontWithName:@"OpenSans-Bold" size:19]
#define FONT_BOLD_20                [UIFont fontWithName:@"OpenSans-Bold" size:20]
#define FONT_BOLD_22                [UIFont fontWithName:@"OpenSans-Bold" size:22]
#define FONT_BOLD_24                [UIFont fontWithName:@"OpenSans-Bold" size:24]
#define FONT_BOLD_26                [UIFont fontWithName:@"OpenSans-Bold" size:26]
#define FONT_BOLD_32                [UIFont fontWithName:@"OpenSans-Bold" size:32]
#define FONT_BOLD(X)                [UIFont fontWithName:@"OpenSans-Bold" size:X]
#define FONT_BOLD_PLUS_MINUS        [UIFont fontWithName:@"OpenSans-Bold" size:36]


#define FONT_NORMAL_15              [UIFont fontWithName:@"OpenSans" size:15]
#define FONT_NORMAL_30              [UIFont fontWithName:@"OpenSans" size:28]
#define FONT_SMALL_TEXT             [UIFont fontWithName:@"OpenSans" size:11]

// Regular fonts
#define FONT_REGULAR_1              [UIFont fontWithName:@"OpenSans" size:1]
#define FONT_REGULAR_8              [UIFont fontWithName:@"OpenSans" size:8]
#define FONT_REGULAR_9              [UIFont fontWithName:@"OpenSans" size:9]
#define FONT_REGULAR_10             [UIFont fontWithName:@"OpenSans" size:10]
#define FONT_REGULAR_11             [UIFont fontWithName:@"OpenSans" size:11]
#define FONT_REGULAR_12             [UIFont fontWithName:@"OpenSans" size:12]
#define FONT_REGULAR_12_5           [UIFont fontWithName:@"OpenSans" size:12.5]
#define FONT_REGULAR_13             [UIFont fontWithName:@"OpenSans" size:13]
#define FONT_REGULAR_14             [UIFont fontWithName:@"OpenSans" size:14]
#define FONT_REGULAR_15             [UIFont fontWithName:@"OpenSans" size:15]
#define FONT_REGULAR_16             [UIFont fontWithName:@"OpenSans" size:16]
#define FONT_REGULAR_17             [UIFont fontWithName:@"OpenSans" size:17]
#define FONT_REGULAR_18             [UIFont fontWithName:@"OpenSans" size:18]
#define FONT_REGULAR_19             [UIFont fontWithName:@"OpenSans" size:19]
#define FONT_REGULAR_20             [UIFont fontWithName:@"OpenSans" size:20]
#define FONT_REGULAR_21             [UIFont fontWithName:@"OpenSans" size:21]
#define FONT_REGULAR_22             [UIFont fontWithName:@"OpenSans" size:22]
#define FONT_REGULAR_23             [UIFont fontWithName:@"OpenSans" size:23]
#define FONT_REGULAR_24             [UIFont fontWithName:@"OpenSans" size:24]
#define FONT_REGULAR_25             [UIFont fontWithName:@"OpenSans" size:25]
#define FONT_REGULAR_30             [UIFont fontWithName:@"OpenSans" size:30]
#define FONT_REGULAR(X)             [UIFont fontWithName:@"OpenSans" size:X]

#define FONT_SEMIBOLD_12            [UIFont fontWithName:@"OpenSans-SemiBold" size:12]
#define FONT_SEMIBOLD_13            [UIFont fontWithName:@"OpenSans-SemiBold" size:13]
#define FONT_SEMIBOLD_14            [UIFont fontWithName:@"OpenSans-SemiBold" size:14]
#define FONT_SEMIBOLD_15            [UIFont fontWithName:@"OpenSans-SemiBold" size:15]

#define FONT_PROXIMA_REGULAR(X)     [UIFont fontWithName:@"OpenSans" size:X]
#define FONT_PROXIMA_BOLD(X)        [UIFont fontWithName:@"OpenSans-Bold" size:X]
#define FONT_SEMIBOLD(X)            [UIFont fontWithName:@"OpenSans-SemiBold" size:X]


#define FONT_LIGHT(X)             [UIFont fontWithName:@"OpenSans-Light" size:X]

#define FONT_SUBTEXT                FONT_REGULAR_12
#define FONT_NAV_BAR_LABEL_TITLE           [UIFont fontWithName:@"OpenSans-Bold" size:20]
#define FONT_BUTTON                 [UIFont fontWithName:@"OpenSans-Bold" size:10]
#define FONT_COMMENT				FONT_REGULAR_12

#define FONT_BIG_LIGHT              [UIFont fontWithName:@"OpenSans" size:21]

#define FONT_VERY_BIG_BOLD          [UIFont fontWithName:@"OpenSans-Bold" size:24]

#define FONT_ICON(X)                [UIFont fontWithName:@"custom" size:X]

#define FONT_RATINGZ(X)             [UIFont fontWithName:@"ratingzRegular" size:X]
#define FONT_GOTHAM_BOLD(X)         [UIFont fontWithName:@"HelveticaNeue-Bold" size:X]

#define SETTINGS_FONT_ICON          FONT_ICON(15)



@end
