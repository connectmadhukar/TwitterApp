//
//  TweetDetailedVC.m
//  twitter
//
//  Created by Madhukar Mulpuri on 1/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "TweetDetailedVC.h"

@interface TweetDetailedVC ()

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
    self.tweetTimeDVLabel.text = self.tweet.tweetTime;
    [self.tweetTimeDVLabel sizeToFit];
    self.retweetCountDVLabel.text = self.tweet.retweetCount;
    [self.retweetCountDVLabel sizeToFit];
    self.favCountDVLabel.text = self.tweet.favoriteCount;
    [self.favCountDVLabel sizeToFit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
