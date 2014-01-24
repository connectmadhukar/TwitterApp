//
//  Tweet.m
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (NSString *)text {
    return [self.data valueOrNilForKeyPath:@"text"];
}

- (NSString *)screenName {
    return [self.data valueOrNilForKeyPath:@"user.screen_name"];
}


- (NSString *)name {
    return [self.data valueOrNilForKeyPath:@"user.name"];
}

- (NSURL *)profileImageUrl {
    return [NSURL URLWithString:[self.data valueOrNilForKeyPath:@"user.profile_image_url"]];
   
}

- (NSURL *)profileBGImageUrl {
    return [NSURL URLWithString:[self.data valueOrNilForKeyPath:@"user.profile_background_image_url"]];
    
}


- (NSString *)tweetTime{
    return [self.data valueOrNilForKeyPath:@"user.created_at"];
}

- (NSString *)retweetCount{
    NSLog(@"retweetCount %@", [self.data valueOrNilForKeyPath:@"retweet_count"]);

    return [NSString stringWithFormat:@"%@", [self.data valueOrNilForKeyPath:@"retweet_count"]];
}

- (NSString *)favoriteCount{
    NSLog(@"FavCount %@", [self.data valueOrNilForKeyPath:@"favorite_count"]);
    return [NSString stringWithFormat:@"%@", [self.data valueOrNilForKeyPath:@"favorite_count"]];
}


+ (NSMutableArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:params]];
    }
    return tweets;
}

@end
