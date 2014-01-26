//
//  User.h
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const UserDidLoginNotification;
extern NSString *const UserDidLogoutNotification;

@interface User : RestObject
@property (nonatomic, strong, readonly) NSString *screenName;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *text;
@property (nonatomic, strong) NSURL *profileImageUrl;
@property (nonatomic, strong) NSURL *profileBGImageUrl;
@property (nonatomic, strong) NSString *tweetTime;//created_at

@property (nonatomic, strong) NSString *retweetCount;//retweet_count

@property (nonatomic, strong) NSString *favoriteCount;


+ (User *)currentUser;
+ (void)setCurrentUser:(User *)currentUser;

@end
