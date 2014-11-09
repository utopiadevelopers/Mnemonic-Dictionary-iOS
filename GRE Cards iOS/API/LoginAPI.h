//
//  LoginAPI.h
//  GRE Cards iOS
//
//  Created by Satyam Krishna on 08/11/14.
//  Copyright (c) 2014 Utopia Developers. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginDelegateAPI <NSObject>

@required
-(void) loginWasSuccessful;

@required
-(void) loginFalied;

@end

@interface LoginAPI : UtopiaObject<APIManagerDelegate>

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

-(void) loginWithUserName:(NSString *)user password:(NSString *)pass;

@end
