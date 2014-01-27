//
//  TweetDetailedVC.m
//  twitter
//
//  Created by Madhukar Mulpuri on 1/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "TweetDetailedVC.h"
#import "TwitterClient.h"
#import "ComposeVC.h"



@interface TweetDetailedVC ()
- (IBAction)rtweetButtonPressed:(id)sender;
- (IBAction)favButtonPressed:(id)sender;
- (IBAction)replyButtonPressed:(id)sender;

@end

@implementation TweetDetailedVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.tweet.profileBGImageUrl];
    /*
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *imageData, NSError *connectionError) {
        NSLog(@"Image fetch done");
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithData:imageData]];
    }];*/
    //self.userNameDVLabel.text = self.tweet.name;
    
    
    request = [NSURLRequest requestWithURL:self.tweet.profileImageUrl];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *imageData, NSError *connectionError) {
        //NSLog(@"Image fetch done");
    [self.profileDVImageView setImage:[UIImage imageWithData:imageData]];    }];
    //NSLog(@"self.tweet.name: %@", self.tweet.name);
    self.screenNameDVLabel.text =  [@"@" stringByAppendingString:self.tweet.screenName];
    [self.screenNameDVLabel sizeToFit];
    self.userNameDVLabel.text = self.tweet.name;
    [self.userNameDVLabel sizeToFit];
    self.tweetDVLabel.text = self.tweet.text;
    self.tweetDVLabel.numberOfLines = 0;
    [self.tweetDVLabel sizeToFit];
    
    //Time of tweet
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEE MMM dd HH:mm:ss +zzzz yyyy"];
    
    NSDate *date = [dateFormat dateFromString:self.tweet.tweetTime];
    
    NSDateFormatter *displayFormat = [[NSDateFormatter alloc] init];
    [displayFormat setDateFormat:@"MM/dd/yyy HH:mm"];
    NSString *dateString = [displayFormat stringFromDate:date];
    
    self.tweetTimeDVLabel.text = dateString;
    [self.tweetTimeDVLabel sizeToFit];
    self.retweetCountDVLabel.text = self.tweet.retweetCount;
    [self.retweetCountDVLabel sizeToFit];
    self.favCountDVLabel.text = self.tweet.favoriteCount;
    [self.favCountDVLabel sizeToFit];
    self.retweeted = self.tweet.retweeted;
    self.favorited = self.tweet.favorited;
    
    if( self.retweeted != 0) {
        [self.retweetDVButton setSelected:true];
    }
    if( self.favorited != 0) {
        [self.favouritedDVButton setSelected:true];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rtweetButtonPressed:(id)sender {
    NSLog(@"self.tweet.tweetID: %@", self.tweet.tweetID);
    NSLog(@"onTweet");
    //TODO: Tweet
    TwitterClient *twitterClient = [TwitterClient instance];
    if(self.retweeted == 0){
        [twitterClient retweet:self.tweet.tweetID success:^(AFHTTPRequestOperation *operation, id response) {
           NSLog(@"%@", response);
            self.retweeted = 1;
           [self.retweetDVButton setSelected:true];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           NSLog(@"%@", error);
        }];
    }
}

- (IBAction)favButtonPressed:(id)sender {
    TwitterClient *twitterClient = [TwitterClient instance];
    if(self.favorited == 0){
        [twitterClient makeFavorite:self.tweet.tweetID success:^(AFHTTPRequestOperation *operation, id response) {
            NSLog(@"%@", response);
            self.favorited = 1;
            
            [self.favouritedDVButton setSelected:true];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    } else {
        [twitterClient destroyFavorite:self.tweet.tweetID success:^(AFHTTPRequestOperation *operation, id response) {
            NSLog(@"%@", response);
            self.favorited = 0;
             [self.favouritedDVButton setSelected:false];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
}

- (IBAction)replyButtonPressed:(id)sender {
    ComposeVC *cvc = [[ComposeVC alloc] init];
    
    cvc.tweet = self.tweet;
    [self.navigationController pushViewController:cvc animated:YES];

}

@end
