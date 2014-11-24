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

//*********************ends **************************


/*=============================Universal Fonts=======================================*/

#define FONT_ICON(X)                [UIFont fontWithName:@"custom" size:X]
#define FONT_GOTHAM_BOLD(X)         [UIFont fontWithName:@"HelveticaNeue-Bold" size:X]
#define FONT_BODY_SMALL             [UIFont fontWithName:@"OpenSans" size:13]
#define FONT_BODY                   [UIFont fontWithName:@"OpenSans" size:14]
#define FONT_BODY_BOLD              [UIFont fontWithName:@"OpenSans-Bold" size:14]
#define FONT_BODY_BOLD_LARGE        FONT_BOLD_15
#define FONT_HEADER_LABEL           FONT_GOTHAM_BOLD(12)
#define FONT_NAV_BAR_LABEL          [UIFont fontWithName:@"OpenSans-Semibold" size:17]
#define FONT_MODAL_LABEL            FONT_BOLD(16)
#define FONT_TITLE_LABEL            FONT_SEMIBOLD(15)
#define FONT_COLLECTIONS_TITLE      [UIFont fontWithName:@"OpenSans" size:23]
#define FONT_HELVETICANEUE_REGULAR(X)     [UIFont fontWithName:@"HelveticaNeue" size:X]
#define FONT_HELVETICANEUE_LIGHT(X)     [UIFont fontWithName:@"Helvetica-Light" size:X]
#define FONT_SUBMIT_BUTTON          FONT_GOTHAM_BOLD(18)

/*===================================================================================*/



@end
