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

#define SIDE_PADDING 15.0
#define SCROLLABLE_TAB_HEIGHT 40.0f
#define URC_LOW 3.0
#define URC_MEDIUM 5.0
#define NAVIGATION_BAR_HEIGHT 64.0
#define TAB_BAR_HEIGHT 49.0

//***********************end***********************

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

#define WHITE_COLOR         0xFFFFFF
#define BLACK_COLOR         0x000000
#define IOS_BLUE            0x007AFF
#define IOS_BLUE_FEEDBACK   0x005AFF

//*********************ends **************************

//********************* nsuser defaults constants **************************
#define IS_LOGGED_IN    @"is_logged_in"
#define AUTH_KEY        @"user_auth"
//*********************end**************************

@end
