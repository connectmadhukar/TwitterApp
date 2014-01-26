//
//  User.m
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "User.h"
#import "TwitterClient.h"

NSString * const UserDidLoginNotification = @"UserDidLoginNotification";
NSString * const UserDidLogoutNotification = @"UserDidLogoutNotification";
NSString * const kCurrentUserKey = @"kCurrentUserKey";

@implementation User

static User *_currentUser;

+ (User *)currentUser {
    if (!_currentUser) {
        NSData *userData = [[NSUserDefaults standardUserDefaults] dataForKey:kCurrentUserKey];
        if (userData) {
            NSDictionary *userDictionary = [NSJSONSerialization JSONObjectWithData:userData options:NSJSONReadingMutableContainers error:nil];
            _currentUser = [[User alloc] initWithDictionary:userDictionary];
        }
    }
    
    return _currentUser;
}

+ (void)setCurrentUser:(User *)currentUser {
    if (currentUser) {
        NSData *userData = [NSJSONSerialization dataWithJSONObject:currentUser.data options:NSJSONWritingPrettyPrinted error:nil];
        [[NSUserDefaults standardUserDefaults] setObject:userData forKey:kCurrentUserKey];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserKey];
        [TwitterClient instance].accessToken = nil;
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (!_currentUser && currentUser) {
        _currentUser = currentUser; // Needs to be set before firing the notification
        [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLoginNotification object:nil];
    } else if (_currentUser && !currentUser) {
        _currentUser = currentUser; // Needs to be set before firing the notification
        [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLogoutNotification object:nil];
    }
}

- (NSString *)screenName {
    return [self.data valueOrNilForKeyPath:@"screen_name"];
}

- (NSString *)name {
    return [self.data valueOrNilForKeyPath:@"name"];
}


- (NSURL *)profileBGImageUrl {
    return [NSURL URLWithString:[self.data valueOrNilForKeyPath:@"profile_background_image_url"]];
}

- (NSURL *)profileImageUrl {
    return [NSURL URLWithString:[self.data valueOrNilForKeyPath:@"profile_image_url"]];
}

- (NSString *)favouritesCount {
     return [NSString stringWithFormat:@"%@", [self.data valueOrNilForKeyPath:@"favourites_count"]];
}

- (NSString *)followersCount{
    return [NSString stringWithFormat:@"%@", [self.data valueOrNilForKeyPath:@"followers_count"]];
}

- (NSString *)statusesCount{
    return [NSString stringWithFormat:@"%@", [self.data valueOrNilForKeyPath:@"statuses_count"]];
}

- (NSString *)retweetCount {
    return [NSString stringWithFormat:@"%@", [self.data valueOrNilForKeyPath:@"retweet_count"]];
}


@end
