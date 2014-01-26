//
//  Tweet.h
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : RestObject
@property (nonatomic, strong, readonly) NSString *tweetID;
@property (nonatomic, strong, readonly) NSString *screenName;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *text;
@property (nonatomic, strong, readonly) NSURL *profileImageUrl;
@property (nonatomic, strong, readonly) NSURL *profileBGImageUrl;
@property (nonatomic, strong, readonly) NSString *tweetTime;//created_at

@property (nonatomic, strong, readonly) NSString *retweetCount;//retweet_count
//@property (nonatomic, strong, readonly) boolean retweeted;
@property (nonatomic, strong, readonly) NSString *favoriteCount;

@property (nonatomic) NSInteger retweeted;
@property (nonatomic) NSInteger favorited;

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array;

@end
